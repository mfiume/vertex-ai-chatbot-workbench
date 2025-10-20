#!/bin/bash

# Verily Workbench post-startup script for Vertex AI Chatbot
# This script runs after the container starts

# Don't exit on error - we want to see what's happening
set +e

echo ""
echo "🤖 Vertex AI Chatbot - Startup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Get GCP project information from workspace
# According to Workbench docs, the workspace service account is automatically used
echo "📍 Detecting GCP environment..."

# Try to get project ID using gcloud
if command -v gcloud &> /dev/null; then
    PROJECT_ID=$(gcloud config get-value project 2>/dev/null || echo "")

    if [ -z "$PROJECT_ID" ]; then
        echo "⚠️  Could not detect GCP project automatically"
        echo "   You can set it manually with: export GOOGLE_CLOUD_PROJECT=your-project-id"
    else
        export GOOGLE_CLOUD_PROJECT=$PROJECT_ID
        export GCP_PROJECT=$PROJECT_ID
        echo "✅ GCP Project: $PROJECT_ID"
    fi

    # Show authenticated service account
    echo ""
    echo "🔐 Service Account:"
    gcloud auth list --filter=status:ACTIVE --format="value(account)" 2>/dev/null || echo "   Not available"
else
    echo "⚠️  gcloud CLI not found (this is normal in some environments)"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Navigate to workspace
cd /workspace

# Debug: Show what files we have
echo "📁 Workspace contents:"
ls -lah /workspace/bin/ || echo "No bin/ directory found"
echo ""

# Check if binary exists
if [ ! -f "/workspace/bin/chatbot-server" ]; then
    echo "⚠️  Chatbot binary not found at /workspace/bin/chatbot-server"
    echo "   This might be a Git LFS issue. Checking..."

    # Check if it's a Git LFS pointer file
    if [ -f "/workspace/bin/chatbot-server" ]; then
        head -5 /workspace/bin/chatbot-server
    fi

    echo ""
    echo "Attempting to pull LFS files..."
    if command -v git &> /dev/null; then
        cd /workspace
        git lfs install
        git lfs pull
        echo "✅ Git LFS pull completed"
    else
        echo "❌ Git command not available"
    fi
fi

# Check again after LFS pull
if [ ! -f "/workspace/bin/chatbot-server" ]; then
    echo "❌ Error: Chatbot binary still not found"
    echo "   Listing workspace structure:"
    find /workspace -type f -name "chatbot*" || echo "No chatbot files found"
    exit 1
fi

# Make binary executable
chmod +x /workspace/bin/chatbot-server

echo "🚀 Starting Vertex AI Chatbot Server..."
echo ""

# Start the chatbot server in the background
nohup /workspace/bin/chatbot-server > /tmp/chatbot.log 2>&1 &
CHATBOT_PID=$!

# Wait a moment for server to start
sleep 3

# Check if server is running
if ps -p $CHATBOT_PID > /dev/null; then
    echo "✅ Chatbot server started successfully (PID: $CHATBOT_PID)"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "📊 Access Points:"
    echo "   🌐 Chatbot UI:    http://localhost:3000"
    echo "   🏥 Health Check:  http://localhost:3000/health"
    echo "   📈 Statistics:    http://localhost:3000/api/stats"
    echo ""
    echo "📝 Logs:"
    echo "   tail -f /tmp/chatbot.log"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
else
    echo "❌ Error: Chatbot server failed to start"
    echo "   Check logs at: /tmp/chatbot.log"
    echo ""
    echo "Last 20 lines of log:"
    tail -20 /tmp/chatbot.log
    exit 1
fi

# Show first few lines of log
echo "Recent log output:"
echo "─────────────────────────────────────────────────────────"
tail -15 /tmp/chatbot.log
echo "─────────────────────────────────────────────────────────"
echo ""
