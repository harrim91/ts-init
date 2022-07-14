import winston from 'winston';

import { ILogger } from '.';

export function logger(): ILogger {
  return winston.createLogger({
    format: winston.format.json(),
    level: 'info',
    transports: [new winston.transports.Console()],
  });
}
