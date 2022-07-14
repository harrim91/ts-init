import express from 'express';
import helmet from 'helmet';
import morgan from 'morgan';

import { ILogger } from '../util/logger';
import { error_handler } from './middleware/error';

type Dependencies = {
  logger: ILogger;
};

export function server(container: Dependencies) {
  const app = express();

  app.use(morgan('combined'));

  app.use(helmet());

  app.use(express.json());

  app.get('/_health', (_, res) => {
    res.sendStatus(200);
  });

  app.use(error_handler(container));

  return app;
}
