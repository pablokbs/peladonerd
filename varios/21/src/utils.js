function calculateDiscount(price, percentage) {
  if (typeof price !== 'number' || typeof percentage !== 'number') {
    throw new Error('Both price and percentage must be numbers');
  }
  
  if (percentage < 0 || percentage > 100) {
    throw new Error('Percentage must be between 0 and 100');
  }

  return price - (price * (percentage / 100));
}

module.exports = {
  calculateDiscount
}; 