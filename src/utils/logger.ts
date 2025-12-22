const levels = {
  error: 0,
  warn: 1,
  info: 2,
  http: 3,
  debug: 4,
};

const logger = {
  error: (message: string) => console.error(`[ERROR] ${new Date().toISOString()}: ${message}`),
  warn: (message: string) => console.warn(`[WARN] ${new Date().toISOString()}: ${message}`),
  info: (message: string) => console.info(`[INFO] ${new Date().toISOString()}: ${message}`),
  debug: (message: string) => {
    if (process.env.NODE_ENV !== 'production') {
      console.debug(`[DEBUG] ${new Date().toISOString()}: ${message}`);
    }
  },
};

export default logger;