import type { Context } from 'aws-lambda';
import { handler } from '.';

describe('handler', () => {
  it('returns "Hello <argument>!"', async () => {
    expect(await handler('world', {} as Context, jest.fn())).toBe(
      'Hello world!'
    );
  });
});
