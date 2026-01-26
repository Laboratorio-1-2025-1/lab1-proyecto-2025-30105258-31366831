import prisma from '../config/database';
import { BadRequestError, NotFoundError } from '../utils/errors';

/**
 * Lista todas las facturas.
 */
export const listarTodas = async () => {
  return await prisma.factura.findMany({
    include: { 
      persona: true,
      aseguradora: true,
      pagos: true 
    },
    orderBy: { fechaEmision: 'desc' } 
  });
};

/**
 * Lista ítems de facturación.
 */
export const listarItems = async () => {
  return await prisma.facturaItem.findMany({
    take: 50,
    include: {
      prestacion: true
    }
  });
};

/**
 * Servicio para persistir el pago en la BD
 * Este es el que permite que el array deje de estar vacío.
 */
export const crearPago = async (data: { facturaId: number, monto: number, medio: string, referencia?: string }) => {
  // 1. Verificar que la factura existe antes de pagar
  const factura = await prisma.factura.findUnique({ where: { id: data.facturaId } });
  if (!factura) throw new NotFoundError(`No se puede pagar la factura ${data.facturaId} porque no existe.`);

  // 2. Crear el registro en la tabla Pago
  return await prisma.pago.create({
    data: {
      facturaId: data.facturaId,
      monto: data.monto,
      medio: data.medio,
      referencia: data.referencia || `REF-${Date.now()}`,
    }
  });
};

/**
 * Genera una nueva factura validando aranceles y autorizaciones.
 */
export const generarFactura = async (data: any) => {
  return await prisma.$transaction(async (tx) => {
    let subtotalGeneral = 0;
    let impuestosGeneral = 0;

    const afiliacion = await tx.afiliacion.findFirst({
      where: { personaId: data.personaId, estado: 'activa' },
      include: { plan: true }
    });

    if (!afiliacion) {
      throw new BadRequestError(`El paciente con ID ${data.personaId} no tiene una afiliación activa.`);
    }

    const itemsProcesados = await Promise.all(data.items.map(async (item: any) => {
      const arancel = await tx.arancel.findFirst({
        where: {
          prestacionCodigo: item.prestacionCodigo,
          estado: 'vigente',
          planId: afiliacion.planId 
        },
        include: { prestacion: true }
      });

      if (!arancel) {
        throw new BadRequestError(`No arancel vigente para ${item.prestacionCodigo} en plan ${afiliacion.plan.nombre}.`);
      }

      const valorU = Number(arancel.valorBase);
      const impU = Number(arancel.impuestos);
      
      subtotalGeneral += valorU * item.cantidad;
      impuestosGeneral += impU * item.cantidad;

      return {
        prestacionCodigo: item.prestacionCodigo,
        descripcion: arancel.prestacion.nombre,
        cantidad: item.cantidad,
        valorUnitario: valorU,
        impuestos: impU,
        total: (valorU + impU) * item.cantidad
      };
    }));

    return await tx.factura.create({
      data: {
        numero: `FAC-${Date.now()}`,
        personaId: data.personaId,
        aseguradoraId: afiliacion.plan.aseguradoraId,
        subtotal: subtotalGeneral,
        impuestos: impuestosGeneral,
        total: subtotalGeneral + impuestosGeneral,
        estado: 'emitida',
        items: { create: itemsProcesados }
      },
      include: { items: true }
    });
  });
};

/**
 * Obtiene el detalle de una factura por ID.
 */
export const obtenerFacturaPorId = async (id: number) => {
  // Validación de ID mejorada para evitar el error "id is missing"
  if (!id || isNaN(id)) {
    throw new BadRequestError('El ID de la factura es inválido.');
  }

  const factura = await prisma.factura.findUnique({
    where: { id },
    include: { 
      items: true, 
      persona: true, 
      pagos: true 
    }
  });

  if (!factura) throw new NotFoundError(`La factura con ID ${id} no existe.`);
  return factura;
};