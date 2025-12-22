import { PrismaClient } from '@prisma/client';
import logger from '../utils/logger';

const prisma = new PrismaClient({
  log: [
    { emit: 'event', level: 'query' },
    { emit: 'stdout', level: 'error' },
    { emit: 'stdout', level: 'warn' },
  ],
});

// Esto permite ver las consultas SQL reales en la consola durante el desarrollo
prisma.$on('query', (e: any) => {
  logger.debug(`Query: ${e.query} | Params: ${e.params} | Duration: ${e.duration}ms`);
});

export default prisma;