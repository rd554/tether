const express = require('express');
const serverless = require('serverless-http');
const mongoose = require('mongoose');
const cors = require('cors');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
require('dotenv').config();

// Import routes
const teamRoutes = require('../../../backend/routes/teams');
const userRoutes = require('../../../backend/routes/users');
const linkRoutes = require('../../../backend/routes/links');
const dashboardRoutes = require('../../../backend/routes/dashboard');
const authRoutes = require('../../../backend/routes/auth');

// Import middleware
const loggerMiddleware = require('../../../backend/middleware/logger');
const { verifyGoogleToken } = require('../../../backend/middleware/auth');

const app = express();

// Security middleware
app.use(helmet());
app.use(cors({
  origin: true,
  credentials: true
}));

// Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // limit each IP to 100 requests per windowMs
});
app.use(limiter);

// Body parsing middleware
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));

// Custom middleware
app.use(loggerMiddleware);

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ 
    status: 'OK', 
    message: 'Tether API is running',
    timestamp: new Date().toISOString()
  });
});

// API routes
app.use('/teams', verifyGoogleToken, teamRoutes);
app.use('/users', verifyGoogleToken, userRoutes);
app.use('/links', verifyGoogleToken, linkRoutes);
app.use('/dashboard', verifyGoogleToken, dashboardRoutes);
app.use('/auth', authRoutes);

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ 
    error: 'Something went wrong!',
    message: process.env.NODE_ENV === 'development' ? err.message : 'Internal server error'
  });
});

// 404 handler
app.use('*', (req, res) => {
  res.status(404).json({ error: 'Route not found' });
});

// Database connection (only connect if not already connected)
if (mongoose.connection.readyState === 0) {
  mongoose.connect(process.env.MONGODB_URI)
    .then(() => {
      console.log('✅ Connected to MongoDB');
    })
    .catch((error) => {
      console.error('❌ MongoDB connection error:', error);
    });
}

// Export the serverless handler
module.exports.handler = serverless(app); 