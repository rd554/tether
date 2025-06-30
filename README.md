# 🎯 Tether - Team Coordination Platform

**Purpose-driven team coordination platform** designed for Product Managers in large organizations.

## 🚀 Features

- **Team Spaces**: Create product-based collaboration environments
- **Structured Nudges**: Send respectful, traceable collaboration requests
- **Links**: Log every meaningful meeting or decision
- **Visual Dashboard**: Bird's-eye view for CXOs and PMs
- **Gamification**: Team reputation system with response ratings
- **Access Control**: Role-based visibility and permissions

## 🛠 Tech Stack

- **Frontend**: Next.js 14 + TailwindCSS
- **Backend**: Node.js + Express
- **Database**: MongoDB + Mongoose
- **Authentication**: Clerk
- **Hosting**: Netlify (frontend) + Fly.io (backend)

## 📦 Installation

1. **Clone and install dependencies:**
```bash
git clone <repository-url>
cd tether
npm run install:all
```

2. **Set up environment variables:**
```bash
# Backend (.env)
MONGODB_URI=your_mongodb_uri
CLERK_SECRET_KEY=your_clerk_secret
JWT_SECRET=your_jwt_secret
PORT=5000

# Frontend (.env.local)
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=your_clerk_publishable_key
NEXT_PUBLIC_API_URL=http://localhost:5000
```

3. **Start development servers:**
```bash
npm run dev
```

## 🚀 Quick Deployment

Deploy your application with one command:

```bash
./deploy.sh
```

For detailed deployment instructions, see [DEPLOYMENT.md](./DEPLOYMENT.md).

## 🏗 Project Structure

```
tether/
├── frontend/          # Next.js application
├── backend/           # Express API server
├── shared/            # Shared constants and types
└── docs/             # Documentation
```

## 🎮 Core Concepts

### Teams
- Product-based collaboration spaces
- Role-based access control
- Stakeholder management

### Nudges
- Structured collaboration requests
- Predefined response options
- Response tracking and analytics

### Links
- Traceable collaboration records
- Meeting outcomes and summaries
- Status tracking (Pending/Scheduled/Completed)

### Gamification
- Team response ratings
- Individual reputation badges
- Performance leaderboards

## 📱 Key User Flows

1. **PM creates Team Space** → Adds stakeholders → Sends first nudge
2. **Stakeholder receives nudge** → Responds with availability → Creates Link
3. **Meeting occurs** → PM logs outcome → AI generates summary
4. **CXO views dashboard** → Sees team performance → Identifies bottlenecks

## 🚀 Development Phases

- ✅ **Phase 1**: App Foundation (Team Creation)
- 🔄 **Phase 2**: Nudging System
- ⏳ **Phase 3**: Link Engine
- ⏳ **Phase 4**: Access Control & Dashboard
- ⏳ **Phase 5**: Visual Polish
- ⏳ **Phase 6**: AI Integration

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📄 License

MIT License - see LICENSE file for details 