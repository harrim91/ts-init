import { hello } from '.';

describe('hello', () => {
  it('returns "Hello <argument>!"', () => {
    expect(hello('world')).toBe('Hello world!');
  });
});
