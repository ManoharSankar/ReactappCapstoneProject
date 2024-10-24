const express = require('express');
const client = require('prom-client');

// Create a registry for Prometheus metrics
const register = new client.Registry();

// Collect default metrics
client.collectDefaultMetrics({ register });

// Create a new counter for HTTP requests
const httpRequestCounter = new client.Counter({
  name: 'http_requests_total',
  help: 'Total number of HTTP requests',
  labelNames: ['method', 'route', 'status_code'],
});

// Register the counter metric
register.registerMetric(httpRequestCounter);

const app = express();

// Middleware to count HTTP requests
app.use((req, res, next) => {
  res.on('finish', () => {
    httpRequestCounter.labels(req.method, req.path, res.statusCode).inc();
  });
  next();
});

// Expose metrics at /metrics
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(await register.metrics());
});

// Set up a basic route
app.get('/', (req, res) => {
  res.send('Hello from Express.js!');
});

// Start the server
app.listen(3001, () => {
  console.log('Express server running on port 3001');
});



