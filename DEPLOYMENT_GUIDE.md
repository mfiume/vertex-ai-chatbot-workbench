# Deployment Guide - Vertex AI Chatbot

Quick guide to deploy this Vertex AI chatbot to Verily Workbench while protecting your proprietary code.

## 🎯 Goal

Deploy a fully functional AI chatbot to Workbench with:
- ✅ **Public repository** (Workbench requirement)
- ✅ **Protected code** (compiled binary)
- ✅ **Vertex AI integration** (automatic authentication)

## 📋 Prerequisites

1. Verily Workbench workspace
2. GCP project with Vertex AI API enabled
3. GitHub account

## 🚀 Quick Deployment (15 minutes)

### Step 1: Build the Binary (5 minutes)

**If you have the source code:**

```bash
cd /Users/mfiume/Development/verily-workbench-vertex-chatbot

# Install dependencies
cd src
npm install

# Compile to binary
npm run build
# Creates: bin/chatbot-server

# Verify binary
ls -lh ../bin/chatbot-server
```

**If binary is already built:**
- Skip to Step 2

### Step 2: Create Public GitHub Repository (2 minutes)

1. Go to https://github.com/new
2. Create repository:
   - **Name**: `vertex-ai-chatbot-workbench` (or your choice)
   - **Visibility**: **PUBLIC** (required by Workbench)
   - **Add README**: No (we have one)
3. Click "Create repository"

### Step 3: Push Code to GitHub (3 minutes)

```bash
cd /Users/mfiume/Development/verily-workbench-vertex-chatbot

# Initialize git (if not already)
git init

# Add files (IMPORTANT: src/ is excluded by .gitignore)
git add .
git status  # Verify src/ is NOT included

# Commit
git commit -m "Initial commit: Vertex AI Chatbot for Workbench

- Compiled binary with proprietary logic
- Beautiful chat UI with streaming
- Automatic GCP authentication
- Production-ready monitoring"

# Add remote and push
git remote add origin https://github.com/YOUR_USERNAME/vertex-ai-chatbot-workbench.git
git branch -M main
git push -u origin main
```

**CRITICAL**: Verify `src/` directory is NOT in your GitHub repo!

### Step 4: Add to Verily Workbench (5 minutes)

1. **Open Workbench**: Go to https://workbench.verily.com
2. **Select Workspace**: Choose your workspace
3. **Add Custom App**:
   - Click "Apps" or "Add App"
   - Select "Custom" app type
4. **Configure App**:
   - **Name**: "Vertex AI Chatbot"
   - **Description**: "AI chatbot powered by Gemini 1.5"
   - **Repository URL**: `https://github.com/YOUR_USERNAME/vertex-ai-chatbot-workbench`
   - **Folder Path**: `.` (or leave empty)
   - **Branch**: `main`
5. **Compute Resources**:
   - **CPUs**: 2 (minimum)
   - **Memory**: 4GB (minimum)
   - **GPU**: None needed
6. **Advanced** (optional):
   - **Autostop**: 30 minutes
7. Click "**Create**"

### Step 5: Launch and Test (5 minutes)

1. **Find your app** in workspace apps list
2. **Click "Launch"** or "Start"
3. **Wait** for container to build and start (~2-3 minutes first time)
4. **Access**: Click the app or go to `http://localhost:3000`

You should see:
- Beautiful chat interface
- "Hello! I'm your AI assistant..." greeting
- Session ID displayed

**Test it:**
- Type: "What is Vertex AI?"
- Should get streaming response from Gemini

## ✅ Verification Checklist

After deployment, verify:

- [ ] App shows in Workbench
- [ ] Container starts without errors
- [ ] Can access `http://localhost:3000`
- [ ] Chat interface loads properly
- [ ] Health check works: `http://localhost:3000/health`
- [ ] Can send messages and get responses
- [ ] Streaming works (tokens appear in real-time)
- [ ] Session ID is displayed
- [ ] Stats endpoint works: `http://localhost:3000/api/stats`

## 🔍 Troubleshooting

### "Repository must be public"
- Go to GitHub repo settings
- Under "Danger Zone" → "Change visibility"
- Select "Make public"

### "Binary not found"
```bash
# Rebuild binary
cd src
npm install
npm run build
```

### "Vertex AI permission denied"
- Contact Workbench admin
- Request `roles/aiplatform.user` permission
- Or check workspace IAM settings

### "Port 3000 already in use"
```bash
# In Workbench terminal:
lsof -ti:3000 | xargs kill -9
```

### View Logs
```bash
# In Workbench terminal:
tail -f /tmp/chatbot.log
```

## 🔐 Security Verification

Verify your code is protected:

1. **Check public repo**: Should NOT contain `src/` directory
2. **Check binary**: Should be present in `bin/chatbot-server`
3. **Try to read binary**:
   ```bash
   strings bin/chatbot-server | head -20
   ```
   Should see compiled code, NOT readable source

4. **Check .gitignore**: Confirms `src/` is excluded

## 📊 What's Deployed

### Public Repository Contains:
- ✅ `.devcontainer/` - Workbench configuration
- ✅ `bin/chatbot-server` - **Compiled binary** (proprietary logic)
- ✅ `public/` - Web interface
- ✅ `scripts/` - Build scripts
- ✅ Documentation (README, etc.)

### Private (NOT in repo):
- ❌ `src/` - Source code with Vertex AI integration
- ❌ Proprietary algorithms
- ❌ Business logic
- ❌ API keys (uses workspace service account)

## 🎉 Success!

You now have:
- ✅ AI chatbot running in Verily Workbench
- ✅ Powered by Vertex AI Gemini 1.5
- ✅ Proprietary code protected
- ✅ Public repository compliant
- ✅ Automatic GCP authentication
- ✅ Production-ready features

## 🔄 Making Updates

### Update UI Only
```bash
# Edit public/index.html
git add public/
git commit -m "Update UI"
git push
```

### Update Binary (Proprietary Logic)
```bash
# Edit src/server.js (locally, not in repo)
# Rebuild
./scripts/build.sh
# Commit binary
git add bin/chatbot-server
git commit -m "Update chatbot logic"
git push
```

**Note**: Source changes remain private, only compiled binary is pushed.

## 📚 Next Steps

1. **Customize** the chatbot for your use case
2. **Add features** (document upload, code analysis, etc.)
3. **Monitor** usage via stats API
4. **Scale** resources if needed
5. **Share** with team members in workspace

## 🆘 Need Help?

- **Workbench Issues**: Contact Verily support
- **Vertex AI**: Check [GCP Vertex AI docs](https://cloud.google.com/vertex-ai/docs)
- **Deployment**: Review [README.md](README.md)
- **Logs**: Check `/tmp/chatbot.log` in Workbench terminal

---

**Congratulations!** You've successfully deployed a production-ready AI chatbot with protected proprietary code. 🎊
