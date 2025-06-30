#!/bin/bash

# 🚀 Tether Deployment Script
# This script helps deploy your Tether application

set -e

echo "🎯 Tether Deployment Script"
echo "=========================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if required tools are installed
check_requirements() {
    print_status "Checking requirements..."
    
    if ! command -v fly &> /dev/null; then
        print_error "Fly CLI is not installed. Please install it first:"
        echo "  brew install flyctl"
        exit 1
    fi
    
    if ! command -v netlify &> /dev/null; then
        print_warning "Netlify CLI is not installed. You can install it with:"
        echo "  npm install -g netlify-cli"
        echo "  Or deploy manually via Netlify UI"
    fi
    
    print_status "Requirements check completed"
}

# Deploy backend to Fly.io
deploy_backend() {
    print_status "Deploying backend to Fly.io..."
    
    cd backend
    
    # Check if app exists, create if not
    if ! fly apps list | grep -q "tether-backend"; then
        print_status "Creating Fly.io app..."
        fly apps create tether-backend
    fi
    
    # Deploy
    print_status "Deploying to Fly.io..."
    fly deploy
    
    # Get the app URL
    APP_URL=$(fly status -a tether-backend | grep "Hostname" | awk '{print $2}')
    print_status "Backend deployed successfully!"
    print_status "Backend URL: https://$APP_URL"
    
    cd ..
}

# Deploy frontend to Netlify
deploy_frontend() {
    print_status "Deploying frontend to Netlify..."
    
    cd frontend
    
    # Build the project
    print_status "Building frontend..."
    npm run build
    
    # Deploy to Netlify
    if command -v netlify &> /dev/null; then
        print_status "Deploying to Netlify..."
        netlify deploy --prod --dir=.next
    else
        print_warning "Netlify CLI not found. Please deploy manually:"
        echo "1. Go to https://app.netlify.com"
        echo "2. Import your GitHub repository"
        echo "3. Set base directory to 'frontend'"
        echo "4. Set build command to 'npm run build'"
        echo "5. Set publish directory to '.next'"
    fi
    
    cd ..
}

# Main deployment function
main() {
    echo "Choose deployment option:"
    echo "1) Deploy backend only (Fly.io)"
    echo "2) Deploy frontend only (Netlify)"
    echo "3) Deploy both"
    echo "4) Check requirements only"
    
    read -p "Enter your choice (1-4): " choice
    
    case $choice in
        1)
            check_requirements
            deploy_backend
            ;;
        2)
            check_requirements
            deploy_frontend
            ;;
        3)
            check_requirements
            deploy_backend
            deploy_frontend
            ;;
        4)
            check_requirements
            ;;
        *)
            print_error "Invalid choice. Please run the script again."
            exit 1
            ;;
    esac
    
    print_status "Deployment completed!"
    echo ""
    echo "📋 Next steps:"
    echo "1. Set up environment variables in both platforms"
    echo "2. Configure your database (MongoDB Atlas)"
    echo "3. Set up authentication (Clerk)"
    echo "4. Test your deployment"
    echo ""
    echo "📖 For detailed instructions, see DEPLOYMENT.md"
}

# Run main function
main 