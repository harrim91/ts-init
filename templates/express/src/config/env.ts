import { cleanEnv, num } from 'envalid';

export type Env = {
  PORT: number;
};

export function env() {
  return cleanEnv<Env>(process.env, {
    PORT: num(),
  });
}
