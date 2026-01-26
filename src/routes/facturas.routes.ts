import { Router } from 'express';
import * as factCtrl from '../controllers/facturas.controller';
import { authenticate } from '../middlewares/auth.middleware';
import { validate } from '../middlewares/validation.middleware';
import { checkPermission } from '../middlewares/rbac.middleware';
import { createFacturaSchema } from '../schemas/facturas.schema';

const router = Router();

// Middleware de autenticación para todas las rutas
router.use(authenticate);

/**
 * Listar facturas generales
 */
router.get(
  '/', 
  //checkPermission('FACTURACION_LEER'), 
  factCtrl.listFacturas
);

/**
 * Consultar ítems de facturación individuales (El de tu imagen)
 * Se coloca ANTES de /:id para que Express no lo confunda con un ID literal
 */
router.get(
  '/items',
  //checkPermission('FACTURACION_LEER'),
  factCtrl.listFacturaItems
);

/**
 * Emisión de factura
 */
router.post(
  '/', 
  //checkPermission('FACTURACION_CREAR'), 
  validate(createFacturaSchema), 
  factCtrl.createFactura
);

/**
 * REGISTRAR PAGO
 */
router.post(
  '/pagos', 
  factCtrl.registrarPago // <--- Esta función debe existir en tu controlador
);

/**
 * Obtener detalles de una factura específica
 */
router.get(
  '/:id', 
  //checkPermission('FACTURACION_LEER'),
  factCtrl.getFacturaById
); 

export default router;