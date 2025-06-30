# 🚀 Deploy Tether to Netlify (Full-Stack)

This guide will help you deploy your entire Tether application (frontend + backend) on Netlify using serverless functions.

## 📋 Prerequisites

1. **GitHub Account**: Your code is on GitHub at https://github.com/rd554/tether.git
2. **Netlify Account**: Sign up at https://netlify.com
3. **MongoDB Atlas Account**: For cloud database (https://mongodb.com/atlas)
4. **Google Cloud Console**: For OAuth credentials (https://console.cloud.google.com)

## 🗄️ Step 1: Set up MongoDB Atlas

1. Create a MongoDB Atlas account
2. Create a new cluster (free tier is fine)
3. Create a database user with read/write permissions
4. Get your connection string (will look like: `mongodb+srv://username:password@cluster.mongodb.net/tether`)

## 🔐 Step 2: Set up Google OAuth

1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Create a new project or select existing one
3. Enable Google+ API
4. Go to "Credentials" → "Create Credentials" → "OAuth 2.0 Client IDs"
5. Set application type to "Web application"
6. Add authorized redirect URIs:
   - `http://localhost:3000` (for development)
   - `https://your-netlify-app.netlify.app` (for production)
7. Copy your Client ID and Client Secret

## 🌐 Step 3: Deploy to Netlify

### Option A: Deploy via Netlify UI (Recommended)

1. Go to https://app.netlify.com
2. Click "Add new site" → "Import an existing project"
3. Connect your GitHub account
4. Select the `rd554/tether` repository
5. Configure build settings:
   - **Base directory**: `frontend`
   - **Build command**: `npm run build`
   - **Publish directory**: `.next`
6. Click "Deploy site"

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

## 🔧 Step 4: Set Environment Variables

In your Netlify dashboard → Site settings → Environment variables, add:

### Required Variables:
```
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/tether
GOOGLE_CLIENT_ID=your_google_client_id_here
GOOGLE_CLIENT_SECRET=your_google_client_secret_here
NODE_ENV=production
JWT_SECRET=your_jwt_secret_key_here
FRONTEND_URL=https://your-netlify-app.netlify.app
```

### Optional Variables:
```
OPENAI_API_KEY=your_openai_api_key_here
LOG_LEVEL=info
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100
```

### Frontend Variables:
```
NEXT_PUBLIC_API_URL=/api
NEXT_PUBLIC_GOOGLE_CLIENT_ID=your_google_client_id_here
```

## 🧪 Step 5: Test Your Deployment

1. **Test Health Check**: Visit `https://your-app.netlify.app/api/health`
2. **Test Frontend**: Visit your Netlify URL
3. **Test Authentication**: Try logging in with Google
4. **Test API Calls**: Create a team and verify it works

## 🔄 Step 6: Continuous Deployment

Netlify automatically deploys when you push to your main branch. No additional setup needed!

## 📊 Monitoring

- View deployment logs in the Netlify dashboard
- Monitor performance in the "Analytics" tab
- Check function logs in "Functions" tab

## 🛠️ Troubleshooting

### Common Issues:

1. **Build Failures**: 
   - Check Node.js version (should be 18+)
   - Verify all dependencies are installed
   - Check build logs in Netlify dashboard

2. **API Errors**:
   - Verify environment variables are set correctly
   - Check MongoDB connection string
   - Verify Google OAuth credentials

3. **Authentication Issues**:
   - Ensure Google OAuth redirect URIs are correct
   - Check Google Client ID is set properly
   - Verify CORS settings

### Useful Commands:

```bash
# Check Netlify status
netlify status

# View function logs
netlify functions:list
netlify functions:invoke api

# Test locally
netlify dev
```

## 🔒 Security Checklist

- [ ] Environment variables are set (not in code)
- [ ] HTTPS is enabled (automatic on Netlify)
- [ ] CORS is properly configured
- [ ] Rate limiting is active
- [ ] Google OAuth is working
- [ ] Database is secure

## 📈 Next Steps

1. Set up custom domain
2. Configure monitoring and alerts
3. Set up staging environment
4. Add performance monitoring
5. Implement caching strategies

## 🆘 Support

- **Netlify**: https://docs.netlify.com/
- **MongoDB Atlas**: https://docs.atlas.mongodb.com/
- **Google OAuth**: https://developers.google.com/identity/protocols/oauth2

---

Your Tether application should now be live on Netlify! 🎉

## 🎯 Quick Deploy Checklist

- [ ] MongoDB Atlas database created
- [ ] Google OAuth credentials configured
- [ ] Netlify site created and connected to GitHub
- [ ] Environment variables set in Netlify
- [ ] First deployment successful
- [ ] Authentication working
- [ ] API endpoints responding
- [ ] Frontend functionality tested 