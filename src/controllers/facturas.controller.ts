import { Request, Response, NextFunction } from 'express';
import * as facturaService from '../services/facturas.service';
import { sendSuccess } from '../utils/response';
import { registrarAccion } from '../utils/logger';

export const listFacturas = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const facturas = await facturaService.listarTodas();
    return sendSuccess(res, { data: facturas });
  } catch (error) { next(error); }
};

export const createFactura = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const factura = await facturaService.generarFactura(req.body);
    const user = (req as any).user;
    if (user) await registrarAccion(user.id, 'FACTURACION', 'CREATE_FACTURA', req);

    return sendSuccess(res, { status: 201, data: factura });
  } catch (error) { next(error); }
};

export const getFacturaById = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const factura = await facturaService.obtenerFacturaPorId(Number(id));
    return sendSuccess(res, { data: factura });
  } catch (error) { next(error); }
};

export const listFacturaItems = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const items = await facturaService.listarItems();
    return sendSuccess(res, { data: items });
  } catch (error) { next(error); }
};

/**
 * Implementación real de registrarPago
 * Ahora sí guarda en la base de datos llamando al servicio.
 */
export const registrarPago = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { facturaId, monto, medio, referencia } = req.body;
    
    // Llamamos al servicio para persistir los datos
    const pagoRealizado = await facturaService.crearPago({
      facturaId: Number(facturaId),
      monto: Number(monto),
      medio,
      referencia
    });

    const user = (req as any).user;
    if (user) await registrarAccion(user.id, 'FACTURACION', 'PAGO_REGISTRADO', req);

    return sendSuccess(res, {
      status: 201,
      message: "Pago registrado y persistido con éxito",
      data: pagoRealizado
    });
  } catch (error) {
    next(error); // Ahora usa el middleware de errores global
  }
};