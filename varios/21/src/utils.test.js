const { calculateDiscount } = require('./utils');

describe('calculateDiscount', () => {
  test('calculates discount correctly', () => {
    expect(calculateDiscount(100, 20)).toBe(80);
    expect(calculateDiscount(50, 10)).toBe(45);
  });

  test('handles zero discount', () => {
    expect(calculateDiscount(100, 0)).toBe(100);
  });

  test('handles full discount', () => {
    expect(calculateDiscount(100, 100)).toBe(0);
  });

  test('throws error for invalid number inputs', () => {
    expect(() => calculateDiscount('100', 20)).toThrow('Both price and percentage must be numbers');
    expect(() => calculateDiscount(100, '20')).toThrow('Both price and percentage must be numbers');
  });

  test('throws error for invalid percentage range', () => {
    expect(() => calculateDiscount(100, -10)).toThrow('Percentage must be between 0 and 100');
    expect(() => calculateDiscount(100, 110)).toThrow('Percentage must be between 0 and 100');
  });
}); 