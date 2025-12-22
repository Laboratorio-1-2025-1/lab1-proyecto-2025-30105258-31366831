import dotenv from 'dotenv';

dotenv.config();

export const config = {
  // Entorno del servidor (development, production, test)
  nodeEnv: process.env.NODE_ENV || 'development',

  // Puerto del servidor
  port: parseInt(process.env.PORT || '3000', 10),

  // Base de datos (La que configuramos con puerto 3307)
  databaseUrl: process.env.DATABASE_URL,

  // Seguridad
  jwtSecret: process.env.JWT_SECRET || 'super_secret_key_change_in_production',
  jwtExpiresIn: process.env.JWT_EXPIRES_IN || '24h',

  // Configuración de Bcrypt (Rounds de sal)
  bcryptSaltRounds: parseInt(process.env.BCRYPT_SALT_ROUNDS || '10', 10),

  // Otros
  logLevel: process.env.LOG_LEVEL || 'info',
  corsOrigin: process.env.CORS_ORIGIN || 'http://localhost:3000',
};

export default config;