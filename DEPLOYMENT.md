# 🚀 Tether Deployment Guide

This guide will help you deploy your Tether application with the frontend on Netlify and backend on Fly.io.

## 📋 Prerequisites

1. **GitHub Account**: Your code is already on GitHub at https://github.com/rd554/tether.git
2. **Netlify Account**: Sign up at https://netlify.com
3. **Fly.io Account**: Sign up at https://fly.io
4. **MongoDB Atlas Account**: For cloud database (https://mongodb.com/atlas)
5. **Clerk Account**: For authentication (https://clerk.com)

## 🗄️ Step 1: Set up MongoDB Atlas

1. Create a MongoDB Atlas account
2. Create a new cluster (free tier is fine)
3. Create a database user with read/write permissions
4. Get your connection string (will look like: `mongodb+srv://username:password@cluster.mongodb.net/tether`)

## 🔐 Step 2: Set up Clerk Authentication

1. Create a Clerk account
2. Create a new application
3. Get your API keys:
   - `CLERK_SECRET_KEY`
   - `NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY`

## 🚀 Step 3: Deploy Backend to Fly.io

### Install Fly CLI
```bash
# macOS
brew install flyctl

# Or download from https://fly.io/docs/hands-on/install-flyctl/
```

### Login to Fly.io
```bash
fly auth login
```

### Deploy Backend
```bash
cd backend

# Create the app (first time only)
fly apps create tether-backend

# Set environment variables
fly secrets set MONGODB_URI="your_mongodb_atlas_connection_string"
fly secrets set CLERK_SECRET_KEY="your_clerk_secret_key"
fly secrets set JWT_SECRET="your_jwt_secret_key"
fly secrets set NODE_ENV="production"
fly secrets set FRONTEND_URL="https://your-netlify-app.netlify.app"

# Deploy
fly deploy

# Get your backend URL
fly status
```

Your backend will be available at: `https://tether-backend.fly.dev`

## 🌐 Step 4: Deploy Frontend to Netlify

### Option A: Deploy via Netlify UI (Recommended)

1. Go to https://app.netlify.com
2. Click "Add new site" → "Import an existing project"
3. Connect your GitHub account
4. Select the `rd554/tether` repository
5. Configure build settings:
   - **Base directory**: `frontend`
   - **Build command**: `npm run build`
   - **Publish directory**: `.next`
6. Add environment variables:
   - `NEXT_PUBLIC_API_URL`: `https://tether-backend.fly.dev`
   - `NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY`: `your_clerk_publishable_key`
7. Click "Deploy site"

### Option B: Deploy via Netlify CLI

```bash
# Install Netlify CLI
npm install -g netlify-cli

# Login
netlify login

# Deploy
cd frontend
netlify deploy --prod --dir=.next
```

## 🔧 Step 5: Update Environment Variables

After deployment, update your environment variables:

### Backend (Fly.io)
```bash
fly secrets set FRONTEND_URL="https://your-netlify-app.netlify.app"
```

### Frontend (Netlify)
In Netlify dashboard → Site settings → Environment variables:
- `NEXT_PUBLIC_API_URL`: `https://tether-backend.fly.dev`

## 🧪 Step 6: Test Your Deployment

1. **Test Backend Health**: Visit `https://tether-backend.fly.dev/health`
2. **Test Frontend**: Visit your Netlify URL
3. **Test Authentication**: Try logging in with Clerk
4. **Test API Calls**: Create a team and verify it works

## 🔄 Step 7: Set up Continuous Deployment

### Netlify (Automatic)
- Netlify automatically deploys when you push to your main branch
- No additional setup needed

### Fly.io (Manual)
```bash
# Deploy updates
cd backend
fly deploy
```

## 📊 Monitoring

### Fly.io
```bash
# View logs
fly logs

# Monitor app status
fly status

# Scale if needed
fly scale count 2
```

### Netlify
- View deployment logs in the Netlify dashboard
- Monitor performance in the "Analytics" tab

## 🛠️ Troubleshooting

### Common Issues

1. **CORS Errors**: Ensure `FRONTEND_URL` is set correctly in backend
2. **Database Connection**: Verify MongoDB Atlas connection string
3. **Authentication**: Check Clerk API keys are correct
4. **Build Failures**: Check Node.js version compatibility

### Useful Commands

```bash
# Fly.io
fly logs -a tether-backend
fly ssh console -a tether-backend
fly status -a tether-backend

# Netlify
netlify status
netlify logs
```

## 🔒 Security Checklist

- [ ] Environment variables are set (not in code)
- [ ] HTTPS is enabled (automatic on both platforms)
- [ ] CORS is properly configured
- [ ] Rate limiting is active
- [ ] Authentication is working
- [ ] Database is secure

## 📈 Next Steps

1. Set up custom domains
2. Configure monitoring and alerts
3. Set up staging environment
4. Implement CI/CD pipelines
5. Add performance monitoring

## 🆘 Support

- **Fly.io**: https://fly.io/docs/support/
- **Netlify**: https://docs.netlify.com/
- **MongoDB Atlas**: https://docs.atlas.mongodb.com/
- **Clerk**: https://clerk.com/docs

---

Your Tether application should now be live! 🎉 