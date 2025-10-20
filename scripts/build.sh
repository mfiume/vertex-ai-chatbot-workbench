#!/bin/bash

# Build script to compile proprietary source code to binary
# This protects your code while allowing public repository

set -e

echo "🔨 Building Vertex AI Chatbot Binary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Navigate to source directory
cd "$(dirname "$0")/../src"

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Compile to binary using pkg
echo "🔧 Compiling to native binary..."
echo "   Target: node18-linux-x64 (for Verily Workbench)"
npm run build

# Verify binary was created
if [ -f "../bin/chatbot-server" ]; then
    echo "✅ Binary created successfully!"
    echo ""
    echo "📁 Location: bin/chatbot-server"
    echo "📊 Size: $(du -h ../bin/chatbot-server | cut -f1)"
    echo ""
    echo "🔒 Your proprietary code is now protected in the binary."
    echo "   The source code (src/) is NOT needed in the public repo."
    echo ""
    echo "✅ Ready to commit bin/chatbot-server to your public repository!"
else
    echo "❌ Error: Binary not found!"
    exit 1
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
