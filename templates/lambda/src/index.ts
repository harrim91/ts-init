import type { Handler } from 'aws-lambda';

export const handler: Handler<string, string> = (event) => {
  return Promise.resolve(`Hello ${event}!`);
};
