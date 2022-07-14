type LogMethod = {
  (message: string): void;
  (message: { [key: string]: unknown }): void;
};

export interface ILogger {
  error: LogMethod;
  info: LogMethod;
}
