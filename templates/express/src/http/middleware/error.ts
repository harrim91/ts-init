import { ErrorRequestHandler } from 'express';

import { ILogger } from '../../util/logger';

type Dependencies = {
  logger: Pick<ILogger, 'error'>;
};

export function error_handler({ logger }: Dependencies): ErrorRequestHandler {
  return (err: Error, _, res, __) => {
    logger.error(err.message);

    res.sendStatus(500);
  };
}
