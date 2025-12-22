import express, { Application, Request, Response } from 'express';
import cors from 'cors';
import config from './config/env'; // Tu objeto centralizado
import userRoutes from './routes/user.routes';

const app: Application = express();

// Middlewares
app.use(cors());
app.use(express.json());
app.use('/api/users', userRoutes);

// Ruta de prueba (Health Check)
app.get('/health', (req: Request, res: Response) => {
  res.status(200).json({
    status: 'success',
    message: 'API funcionando correctamente',
    environment: config.nodeEnv, // Usando config
    version: '1.0.0',
    uptime: process.uptime()
  });
});

// Manejo de rutas no encontradas (404)
app.use((req: Request, res: Response) => {
  res.status(404).json({ message: 'Ruta no encontrada' });
});

// Arrancar el servidor usando el puerto de tu config
app.listen(config.port, () => {
  console.log(`🚀 Servidor corriendo en modo ${config.nodeEnv} en: http://localhost:${config.port}`);
});