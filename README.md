# Vertex AI Chatbot for Verily Workbench

A production-ready AI chatbot powered by Google's Vertex AI Gemini models, designed for Verily Workbench with **protected proprietary code**.

## 🎯 Overview

This app demonstrates:
- ✅ **Vertex AI Integration** - Using Gemini 1.5 Flash for conversational AI
- ✅ **Workbench Authentication** - Automatic service account authentication
- ✅ **Protected Code** - Proprietary logic compiled to native binary
- ✅ **Modern UI** - Beautiful chat interface with streaming responses
- ✅ **Production Ready** - Health checks, session management, and monitoring

## 🔐 Code Protection Strategy

This app uses **compiled native binaries** to protect proprietary code:

### What's Public (in this repo):
- ✅ Dev container configuration (`.devcontainer/`)
- ✅ Web interface (`public/`)
- ✅ **Compiled binary** (`bin/chatbot-server`) - Very hard to reverse-engineer
- ✅ Documentation

### What's Private (NOT in this repo):
- ❌ Source code (`src/`) - Contains proprietary chatbot logic
- ❌ Vertex AI integration code
- ❌ Conversation management algorithms
- ❌ Custom features and enhancements

The compiled binary contains ALL proprietary logic, making it extremely difficult to reverse-engineer while satisfying Verily Workbench's public repository requirement.

## 📁 Project Structure

```
verily-workbench-vertex-chatbot/
├── .devcontainer/
│   ├── devcontainer.json          # Workbench configuration
│   └── post-startup.sh             # Startup script (detects GCP project)
├── bin/
│   ├── chatbot-server              # 🔒 COMPILED BINARY (proprietary code)
│   └── README.md                   # Binary documentation
├── public/
│   └── index.html                  # Chat UI (streaming support)
├── scripts/
│   └── build.sh                    # Build script (for rebuilding binary)
├── src/                            # ❌ NOT IN PUBLIC REPO (proprietary)
│   ├── package.json
│   └── server.js                   # Contains chatbot logic
├── .gitignore                      # Protects src/ from being committed
└── README.md                       # This file
```

## 🚀 Features

### Chatbot Capabilities
- **Conversational AI** - Natural language conversations using Gemini 1.5
- **Streaming Responses** - Real-time token streaming for better UX
- **Session Management** - Maintains conversation context
- **Safety Controls** - Content filtering and safety ratings
- **Configurable** - Adjust temperature, max tokens, etc.

### Technical Features
- **Automatic GCP Authentication** - Uses Workbench workspace service account
- **Health Monitoring** - `/health` endpoint for status checks
- **Statistics API** - Track usage and performance
- **Error Handling** - Graceful error messages
- **Logging** - Comprehensive logging for debugging

## 📋 Requirements

### Verily Workbench Requirements
✅ Runs on `app-network` (Workbench requirement)
✅ Container named `application-server`
✅ Port 3000 exposed on localhost
✅ Dev container configuration
✅ Public Git repository (satisfied with compiled binary)

### GCP Requirements
- Vertex AI API enabled in your workspace project
- Workspace service account with Vertex AI permissions (pre-configured in Workbench)
- Location: `us-central1` (configurable)

## 🛠️ Configuration

### Environment Variables

The app automatically detects configuration from Workbench:

| Variable | Description | Default |
|----------|-------------|---------|
| `GOOGLE_CLOUD_PROJECT` | GCP project ID | Auto-detected from workspace |
| `VERTEX_AI_LOCATION` | Vertex AI region | `us-central1` |
| `VERTEX_AI_MODEL` | Gemini model to use | `gemini-1.5-flash` |
| `PORT` | Server port | `3000` |

These are set in `.devcontainer/devcontainer.json` and auto-detected in `post-startup.sh`.

## 📦 Deployment to Verily Workbench

### Prerequisites
1. Create a **PUBLIC** GitHub repository
2. Compile the binary (if you have source code access)
3. Push to GitHub

### Step 1: Build the Binary (If You Have Source)

```bash
# Install dependencies and compile
cd src
npm install
npm run build

# Or use the build script
./scripts/build.sh
```

This creates `bin/chatbot-server` - a compiled binary containing all proprietary logic.

### Step 2: Prepare for Public Repository

```bash
# Initialize git
git init
git add .devcontainer/ bin/ public/ scripts/ README.md .gitignore
git commit -m "Initial commit: Vertex AI Chatbot for Workbench"

# Note: src/ is excluded by .gitignore to protect proprietary code
```

### Step 3: Push to GitHub

```bash
# Create public repo on GitHub: https://github.com/new
# Then push:
git remote add origin https://github.com/YOUR_USERNAME/vertex-ai-chatbot.git
git branch -M main
git push -u origin main
```

### Step 4: Add to Verily Workbench

1. Go to Verily Workbench UI
2. Navigate to your workspace
3. Click "Add App" → "Custom"
4. Enter:
   - **Repository URL**: `https://github.com/YOUR_USERNAME/vertex-ai-chatbot`
   - **Folder Path**: `.` (root folder)
   - **Compute**: Select desired resources (minimum: 2 CPU, 4GB RAM)
5. Click "Create"

### Step 5: Launch

1. Find your app in the workspace
2. Click "Launch"
3. Wait for container to start (~2-3 minutes)
4. Access at `http://localhost:3000`

## 💬 Usage

### Web Interface

Open `http://localhost:3000` to access the chat interface:

- **Chat**: Type messages and get AI responses
- **Streaming**: Responses appear in real-time as they're generated
- **Clear**: Reset conversation history
- **Stats**: View usage statistics

### API Endpoints

#### Create Session
```bash
POST /api/chat/session
```

Returns a new session ID for managing conversation context.

#### Send Message (Non-Streaming)
```bash
POST /api/chat
Content-Type: application/json

{
  "sessionId": "optional-session-id",
  "message": "Hello, how are you?",
  "options": {
    "temperature": 0.7,
    "maxTokens": 2048
  }
}
```

#### Send Message (Streaming)
```bash
POST /api/chat/stream
Content-Type: application/json

{
  "sessionId": "optional-session-id",
  "message": "Explain photosynthesis"
}
```

Returns Server-Sent Events (SSE) stream with real-time response.

#### Get Conversation History
```bash
GET /api/chat/history/:sessionId
```

#### Clear Conversation
```bash
DELETE /api/chat/history/:sessionId
```

#### Statistics
```bash
GET /api/stats
```

Returns:
```json
{
  "activeSessions": 5,
  "totalMessages": 142,
  "model": "gemini-1.5-flash",
  "location": "us-central1",
  "projectId": "your-project-id"
}
```

#### Health Check
```bash
GET /health
```

## 🔍 Monitoring

### View Logs

```bash
# Real-time logs
tail -f /tmp/chatbot.log

# Last 100 lines
tail -100 /tmp/chatbot.log
```

### Check Server Status

```bash
curl http://localhost:3000/health
```

### Monitor Statistics

```bash
curl http://localhost:3000/api/stats
```

## 🧪 Testing Locally

You can test the app locally before deploying to Workbench:

### Using Docker

```bash
# Build container
docker build -t vertex-chatbot .

# Run container (requires GCP credentials)
docker run -p 3000:3000 \
  --network=app-network \
  --name=application-server \
  -e GOOGLE_CLOUD_PROJECT=your-project-id \
  -v ~/.config/gcloud:/root/.config/gcloud \
  vertex-chatbot
```

### Using Dev Containers (VS Code)

1. Open folder in VS Code with Dev Containers extension
2. Run "Dev Containers: Reopen in Container"
3. Server starts automatically via `post-startup.sh`

## 🛡️ Security

### Authentication
- Uses Workbench workspace service account (automatic)
- No API keys or credentials in code
- Service account has proper Vertex AI IAM permissions

### Code Protection
- Source code compiled to native binary
- Binary very difficult to reverse-engineer
- No proprietary algorithms exposed
- Public repository requirement satisfied

### Content Safety
- Gemini safety filters enabled
- Blocks harmful content categories
- Safety ratings returned with responses

## 🔧 Customization

### Change AI Model

Edit `.devcontainer/devcontainer.json`:

```json
{
  "containerEnv": {
    "VERTEX_AI_MODEL": "gemini-1.5-pro"
  }
}
```

Available models:
- `gemini-1.5-flash` (default) - Fast, efficient
- `gemini-1.5-pro` - More capable, slower
- `gemini-1.0-pro` - Older stable version

### Adjust Generation Parameters

When calling the API, pass options:

```json
{
  "message": "Your question",
  "options": {
    "temperature": 0.9,    // 0.0 (deterministic) to 1.0 (creative)
    "maxTokens": 4096,     // Max response length
    "topP": 0.95           // Nucleus sampling
  }
}
```

### Modify UI

Edit `public/index.html` to customize:
- Colors and styling
- Layout and components
- Additional features

## 📊 Performance

### Resource Usage
- **CPU**: 1-2 cores recommended
- **Memory**: 2-4GB recommended
- **Network**: Requires internet for Vertex AI API

### Response Times
- **Streaming**: First token in ~1-2 seconds
- **Complete Response**: Varies by length (typically 5-15 seconds)
- **Session Management**: Instant (<100ms)

## 🐛 Troubleshooting

### Server Not Starting

**Check binary exists:**
```bash
ls -la /workspace/bin/chatbot-server
```

**Check logs:**
```bash
cat /tmp/chatbot.log
```

**Rebuild binary** (if you have source):
```bash
./scripts/build.sh
```

### GCP Project Not Detected

**Manually set project:**
```bash
export GOOGLE_CLOUD_PROJECT=your-project-id
```

**Check gcloud auth:**
```bash
gcloud auth list
gcloud config get-value project
```

### Vertex AI Permission Errors

Ensure your workspace service account has:
- `roles/aiplatform.user` or
- `roles/ml.developer`

Contact Workbench admin to grant permissions.

### Port Already in Use

**Kill existing process:**
```bash
lsof -ti:3000 | xargs kill -9
```

## 📚 Resources

- [Verily Workbench Documentation](https://support.workbench.verily.com/docs/)
- [Vertex AI Documentation](https://cloud.google.com/vertex-ai/docs)
- [Gemini API Reference](https://cloud.google.com/vertex-ai/docs/generative-ai/model-reference/gemini)
- [Dev Containers Specification](https://containers.dev/)

## 🔄 Updating

### Update Binary (If You Have Source)

```bash
# Make changes to src/server.js
# Rebuild binary
./scripts/build.sh

# Commit and push
git add bin/chatbot-server
git commit -m "Update chatbot logic"
git push
```

### Update UI

```bash
# Edit public/index.html
git add public/index.html
git commit -m "Update UI"
git push
```

## 📝 License

PROPRIETARY - Source code is proprietary and not included in this repository.
Binary is licensed for use in Verily Workbench environments only.

## 🆘 Support

For issues with:
- **Workbench**: Contact Verily Workbench support
- **Vertex AI**: Check GCP documentation or contact GCP support
- **This App**: Review logs and troubleshooting section above

---

**Note**: This app demonstrates production-ready code protection strategies while maintaining public repository compliance for Verily Workbench.
