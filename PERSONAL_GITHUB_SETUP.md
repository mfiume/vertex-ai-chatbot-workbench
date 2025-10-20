# Push to Personal GitHub (Not DNAstack)

## ⚠️ IMPORTANT: This Goes to YOUR Personal Account

This project will be pushed to **your personal GitHub account (mfiume)**, NOT to DNAstack.

## 🔐 Safe Deployment to Personal GitHub

### Step 1: Create Personal GitHub Repo

1. Go to https://github.com/new
2. **Make sure you're logged in as your PERSONAL account (mfiume)**
3. Create repository:
   - **Owner**: Select **mfiume** (NOT dnastack or any org)
   - **Name**: `vertex-ai-chatbot-workbench` (or your choice)
   - **Visibility**: **PUBLIC** (required by Workbench)
   - **Add README**: No (we have one)
4. Click "Create repository"

**VERIFY**: Check the repo URL is `https://github.com/mfiume/...` (NOT dnastack)

---

### Step 2: Verify Local Setup

```bash
cd /Users/mfiume/Development/verily-workbench-vertex-chatbot

# Initialize git (if not already done)
git init

# Check current remotes (should be empty)
git remote -v
# Expected: No output (no remotes configured yet)

# If there's a DNAstack remote, REMOVE IT:
git remote remove origin  # If it exists
```

---

### Step 3: Add YOUR Personal Remote

```bash
# Add YOUR personal GitHub repo as remote
git remote add origin https://github.com/mfiume/vertex-ai-chatbot-workbench.git
                                        ^^^^^^
                                        YOUR PERSONAL ACCOUNT

# Verify it's correct
git remote -v

# Expected output:
# origin  https://github.com/mfiume/vertex-ai-chatbot-workbench.git (fetch)
# origin  https://github.com/mfiume/vertex-ai-chatbot-workbench.git (push)
```

**STOP HERE and verify the URL contains "mfiume" NOT "dnastack"!**

---

### Step 4: Stage and Commit (Local Only)

```bash
# Add files
git add .

# Verify what's being committed
git status

# VERIFY:
# - src/ should NOT be listed (excluded by .gitignore)
# - Only public files should be listed

# Commit locally (still not pushed anywhere)
git commit -m "Initial commit: Vertex AI Chatbot for Workbench"

# At this point: Still only on your local machine!
```

---

### Step 5: Push to YOUR Personal GitHub

```bash
# Double-check the remote before pushing
git remote -v
# VERIFY: URL contains "github.com/mfiume" ✅

# Push to YOUR personal GitHub
git branch -M main
git push -u origin main

# Enter YOUR personal GitHub credentials when prompted
```

---

## 🚨 Safety Checks

### Before Pushing - Verify:

1. **Check remote URL:**
   ```bash
   git remote -v
   ```
   **Must say**: `github.com/mfiume/...` ✅
   **Must NOT say**: `github.com/dnastack/...` ❌

2. **Check GitHub in browser:**
   - Go to https://github.com/mfiume
   - Verify the repo exists under YOUR account
   - Check owner is "mfiume" not "dnastack"

3. **Check files being pushed:**
   ```bash
   git status
   git diff --cached
   ```
   - Verify `src/` is NOT included

---

## 🔒 Additional Protection

### Option 1: Use a Different Repo Name

Use a clearly personal name:
```bash
git remote add origin https://github.com/mfiume/my-personal-vertex-chatbot.git
```

### Option 2: Check Your Git Config

```bash
# Check current Git user
git config user.email
git config user.name

# If it's set to DNAstack, change for this repo:
git config user.email "your-personal@email.com"
git config user.name "Marc Fiume"
```

### Option 3: Verify After First Push

```bash
# After pushing, verify on GitHub:
# 1. Go to https://github.com/mfiume/vertex-ai-chatbot-workbench
# 2. Check "Owner" in top-left
# 3. Should say "mfiume" NOT "dnastack"
```

---

## ✅ Correct Flow

```
Your Local Machine
        ↓
  (git init)
        ↓
  (git add .)
        ↓
  (git commit)
        ↓
  (git remote add origin https://github.com/mfiume/...)
        ↓
  (git push)
        ↓
YOUR PERSONAL GITHUB REPO ✅
(github.com/mfiume/vertex-ai-chatbot-workbench)
```

---

## ❌ What Will NOT Happen

- ❌ Will NOT go to DNAstack GitHub
- ❌ Will NOT go to DNAstack GitLab
- ❌ Will NOT be visible to DNAstack
- ❌ Will NOT use DNAstack credentials

**Unless you explicitly configure it to!**

---

## 🎯 Summary

**Where code will go:**
- ✅ **YOUR** personal GitHub account (mfiume)
- ✅ **YOUR** control
- ✅ **YOUR** repository

**Where code will NOT go:**
- ❌ DNAstack organization
- ❌ Any company repos
- ❌ Anywhere except where YOU specify

**You have complete control** via the `git remote add origin` URL.

---

## 🆘 If You Accidentally Push to Wrong Repo

If you accidentally push to DNAstack repo:

```bash
# Don't panic! Just delete the repo on GitHub
# Then create a new one under your personal account

# Or change the remote:
git remote set-url origin https://github.com/mfiume/vertex-ai-chatbot.git
git push -f origin main  # Force push to correct repo
```

---

## 📝 Recommended Repository Settings

Once created on YOUR personal GitHub:

**Repository name**: `vertex-ai-chatbot-workbench`
**Owner**: `mfiume` ✅
**Visibility**: Public (required by Workbench)
**Description**: "AI chatbot for Verily Workbench using Vertex AI"
**Topics**: `vertex-ai`, `workbench`, `chatbot`, `gemini`

---

**You're in complete control!** The code only goes where you explicitly tell it to go via the `git remote add origin` URL. 🔒
