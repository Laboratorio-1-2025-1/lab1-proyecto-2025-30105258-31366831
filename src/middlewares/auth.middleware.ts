import { Request, Response, NextFunction } from 'express';
import { verifyToken } from '../config/jwt';
import logger from '../utils/logger';

export const authenticate = (req: Request, res: Response, next: NextFunction) => {
  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    logger.warn('Intento de acceso sin token');
    return res.status(401).json({ message: 'No autorizado, token faltante' });
  }

  const token = authHeader.split(' ')[1];
  const decoded = verifyToken(token);

  if (!decoded) {
    logger.warn('Token inválido o expirado');
    return res.status(401).json({ message: 'Token inválido o expirado' });
  }

  // Guardamos la info del usuario en el objeto request para usarlo luego
  (req as any).user = decoded;
  
  next();
};