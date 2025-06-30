#!/bin/bash

# 🚀 Tether Netlify Deployment Helper
# This script will guide you through deploying to Netlify

set -e

echo "🎯 Tether Netlify Deployment Helper"
echo "=================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check if Netlify CLI is installed
check_netlify_cli() {
    if ! command -v netlify &> /dev/null; then
        print_warning "Netlify CLI not found. Installing..."
        npm install -g netlify-cli
        print_status "Netlify CLI installed!"
    else
        print_status "Netlify CLI found!"
    fi
}

# Check if user is logged in to Netlify
check_netlify_auth() {
    if ! netlify status &> /dev/null; then
        print_warning "Not logged in to Netlify. Please log in:"
        echo "1. A browser window will open"
        echo "2. Log in to your Netlify account"
        echo "3. Authorize the CLI"
        netlify login
    else
        print_status "Already logged in to Netlify!"
    fi
}

# Build the project
build_project() {
    print_info "Building the project..."
    cd frontend
    npm run build
    cd ..
    print_status "Build completed!"
}

# Deploy to Netlify
deploy_to_netlify() {
    print_info "Deploying to Netlify..."
    cd frontend
    
    # Check if site already exists
    if netlify status &> /dev/null; then
        print_info "Updating existing site..."
        netlify deploy --prod --dir=.next
    else
        print_info "Creating new site..."
        netlify deploy --prod --dir=.next
    fi
    
    cd ..
    print_status "Deployment completed!"
}

# Show next steps
show_next_steps() {
    echo ""
    print_status "🎉 Deployment completed!"
    echo ""
    echo "📋 Next steps:"
    echo "1. Set up MongoDB Atlas:"
    echo "   - Go to https://mongodb.com/atlas"
    echo "   - Create a free cluster"
    echo "   - Get your connection string"
    echo ""
    echo "2. Set up Google OAuth:"
    echo "   - Go to https://console.cloud.google.com"
    echo "   - Create OAuth 2.0 credentials"
    echo "   - Add your Netlify URL to authorized redirects"
    echo ""
    echo "3. Add environment variables in Netlify:"
    echo "   - Go to your site settings"
    echo "   - Add the variables from env.netlify.example"
    echo ""
    echo "4. Test your application!"
    echo ""
    print_info "For detailed instructions, see NETLIFY_DEPLOYMENT.md"
}

# Main deployment function
main() {
    echo "This script will help you deploy Tether to Netlify."
    echo ""
    read -p "Do you want to continue? (y/n): " -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        check_netlify_cli
        check_netlify_auth
        build_project
        deploy_to_netlify
        show_next_steps
    else
        print_info "Deployment cancelled."
        exit 0
    fi
}

# Run main function
main 