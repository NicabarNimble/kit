#!/bin/bash
# YOLO Workspace Setup Script

echo "🎯 Setting up YOLO workspace..."

# Ensure git is configured
if [ -z "$(git config --global user.email)" ]; then
    git config --global user.email "ai@patina.dev"
    git config --global user.name "AI Assistant"
fi

# Create Claude config directory
mkdir -p ~/.claude-linux

# Configure Claude settings using official settings.json API
# This ensures settings are up-to-date even if Dockerfile settings were cached
echo "🔧 Configuring Claude settings..."
cat > ~/.claude-linux/settings.json <<'EOF'
{
  "permissions": {
    "defaultMode": "bypassPermissions",
    "allow": [],
    "deny": []
  },
  "env": {
    "BASH_DEFAULT_TIMEOUT_MS": 3600000,
    "BASH_MAX_TIMEOUT_MS": 3600000
  }
}
EOF

echo "✅ Claude configured with:"
echo "  - Permissions: YOLO mode (bypassed)"
echo "  - Bash timeout: 1 hour (3600000ms)"

# Set up shell aliases for YOLO mode
cat >> ~/.bashrc <<'EOF'
alias yolo='echo "YOLO mode active - permissions bypassed"'
alias status='git status'
alias commit='git add -A && git commit -m'
EOF

# Install additional tools if needed
if command -v npm &> /dev/null; then
    echo "📦 Installing global npm packages..."
    npm install -g typescript ts-node 2>/dev/null || true
fi

# Check Claude authentication
echo ""
echo "🤖 Checking Claude Code authentication..."
if [ -f ~/.claude-linux/.credentials.json ]; then
    echo "✅ Claude already authenticated with Max subscription"
    echo "   Credentials shared from ~/.patina/claude-linux/"
else
    echo "⚠️  Claude not authenticated yet"
    echo ""
    echo "To enable autonomous AI work with Max subscription:"
    echo "  1. On your HOST machine (Mac), run: claude login"
    echo "  2. Move credentials: mv ~/.claude/.credentials.json ~/.patina/claude-linux/"
    echo "  3. Credentials will work in ALL patina containers"
    echo ""
    echo "After authentication, you can use:"
    echo "  • claude 'task description' - for autonomous AI work"
    echo "  • All changes stay isolated in this container"
    echo "  • One login works across all projects"
    echo ""
fi

echo "✅ YOLO workspace ready!"
echo ""
echo "💭 Available Commands:"
echo "  • claude 'task' - Autonomous AI assistant (Max subscription shared)"
echo "  • Language tools based on detected stack"
echo "  • git, npm, node - Standard development tools"
echo ""
