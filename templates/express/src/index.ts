import { env } from './config/env';
import { server } from './http';
import { logger } from './util/logger/winston';

const config = env();

const log = logger();

const container = {
  logger: log,
};

server(container).listen(config.PORT, () => {
  log.info(`service listening on http://localhost:${config.PORT}`);
});
