# Protected Binary

This directory contains the compiled binary of the proprietary chatbot server.

## What's In This Binary?

The `chatbot-server` binary contains:
- Vertex AI integration logic
- Proprietary chatbot engine
- Conversation management system
- Streaming response handling
- Session management

## Security

✅ **Source code is NOT included** - The binary is compiled from TypeScript/JavaScript and is very difficult to reverse-engineer.

✅ **No API keys exposed** - Uses Workbench workspace service account authentication.

✅ **Proprietary algorithms protected** - Your custom logic is safely compiled.

## How Was This Created?

The binary was created using:

```bash
cd src
npm install
npm run build
```

This uses `pkg` to compile Node.js code into a native Linux x64 binary suitable for Verily Workbench.

## Running The Binary

```bash
./chatbot-server
```

Environment variables:
- `GOOGLE_CLOUD_PROJECT` or `GCP_PROJECT` - GCP project ID (auto-set in Workbench)
- `VERTEX_AI_LOCATION` - Vertex AI location (default: us-central1)
- `VERTEX_AI_MODEL` - Model to use (default: gemini-1.5-flash)
- `PORT` - Server port (default: 3000)

## Rebuilding

If you have access to the source code:

```bash
./scripts/build.sh
```

**Note**: Source code is kept private and NOT included in the public repository.
