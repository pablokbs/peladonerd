const express = require('express');
const { calculateDiscount } = require('./utils');

const app = express();
app.use(express.json());

app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

app.post('/calculate-discount', (req, res) => {
  try {
    const { price, percentage } = req.body;
    const finalPrice = calculateDiscount(price, percentage);
    res.json({ 
      original: price,
      discount: percentage,
      final: finalPrice
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

const PORT = process.env.PORT || 3000;

if (process.env.NODE_ENV !== 'test') {
  app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
  });
}

module.exports = app; 