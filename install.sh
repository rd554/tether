#!/bin/bash

echo "🎯 Setting up Tether - Team Coordination Platform"
echo "=================================================="

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 18+ first."
    exit 1
fi

# Check Node.js version
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo "❌ Node.js version 18+ is required. Current version: $(node -v)"
    exit 1
fi

echo "✅ Node.js version: $(node -v)"

# Install root dependencies
echo "📦 Installing root dependencies..."
npm install

# Install backend dependencies
echo "📦 Installing backend dependencies..."
cd backend
npm install
cd ..

# Install frontend dependencies
echo "📦 Installing frontend dependencies..."
cd frontend
npm install
cd ..

# Create environment files
echo "🔧 Creating environment files..."

# Backend .env
if [ ! -f backend/.env ]; then
    cp backend/env.example backend/.env
    echo "✅ Created backend/.env (please update with your values)"
else
    echo "⚠️  backend/.env already exists"
fi

# Frontend .env.local
if [ ! -f frontend/.env.local ]; then
    cat > frontend/.env.local << EOF
# Clerk Authentication
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=your_clerk_publishable_key

# API Configuration
NEXT_PUBLIC_API_URL=http://localhost:5000

# Environment
NODE_ENV=development
EOF
    echo "✅ Created frontend/.env.local (please update with your values)"
else
    echo "⚠️  frontend/.env.local already exists"
fi

echo ""
echo "🎉 Installation complete!"
echo ""
echo "📋 Next steps:"
echo "1. Update backend/.env with your MongoDB URI and Clerk credentials"
echo "2. Update frontend/.env.local with your Clerk publishable key"
echo "3. Start MongoDB (if running locally)"
echo "4. Run 'npm run dev' to start both servers"
echo ""
echo "🚀 To start development:"
echo "   npm run dev"
echo ""
echo "📚 For more information, see README.md" 