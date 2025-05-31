const request = require('supertest');
const app = require('./app');

describe('API Endpoints', () => {
  describe('GET /health', () => {
    test('should return health status', async () => {
      const response = await request(app)
        .get('/health')
        .expect(200);
      
      expect(response.body).toEqual({ status: 'ok' });
    });
  });

  describe('POST /calculate-discount', () => {
    test('should calculate discount correctly', async () => {
      const response = await request(app)
        .post('/calculate-discount')
        .send({ price: 100, percentage: 20 })
        .expect(200);

      expect(response.body).toEqual({
        original: 100,
        discount: 20,
        final: 80
      });
    });

    test('should return 400 for invalid input', async () => {
      const response = await request(app)
        .post('/calculate-discount')
        .send({ price: '100', percentage: 20 })
        .expect(400);

      expect(response.body).toHaveProperty('error');
    });

    test('should return 400 for invalid percentage', async () => {
      const response = await request(app)
        .post('/calculate-discount')
        .send({ price: 100, percentage: 150 })
        .expect(400);

      expect(response.body).toHaveProperty('error');
    });
  });
}); 