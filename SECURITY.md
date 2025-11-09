# Security Guidelines for APIConnectApp

## Overview

This document outlines the security measures implemented in this project to protect sensitive information such as API keys and credentials.

## Gitleaks Integration

### What is Gitleaks?

Gitleaks is an open-source tool that scans git repositories for secrets, passwords, and API keys to prevent them from being committed to version control.

### Setup

1. **Installed Version:** Gitleaks v8.29.0
2. **Configuration File:** `.gitleaks.toml` (uses default rules + custom allowlist)
3. **Pre-commit Hook:** Automatically runs on every commit attempt

### How It Works

#### Automatic Protection (Pre-commit Hook)

Location: `.git/hooks/pre-commit` and `.git/hooks/pre-commit.bat`

Every time you run `git commit`, the hook:
1. Runs `gitleaks protect --staged` on staged files
2. If secrets are detected → ❌ **Commit is blocked**
3. If no secrets found → ✅ **Commit proceeds**

#### Manual Scans

```bash
# Scan entire repository history for secrets
gitleaks detect --source . --verbose

# Scan only staged files (pre-commit behavior)
gitleaks protect --verbose --redact --staged

# Scan with redaction (hides actual secret values)
gitleaks detect --source . --redact
```

## Secret Management

### Environment Variables

**File:** `.env` (git-ignored)

All API keys and sensitive configuration must be stored in `.env`:

```bash
NEWS_API_KEY=your_actual_key_here
OPENWEATHERMAP_API_KEY=your_actual_key_here
```

### Template File

**File:** `.env.example` (tracked in git)

This template shows required environment variables without exposing actual secrets:

```bash
NEWS_API_KEY=your_news_api_key_here
OPENWEATHERMAP_API_KEY=your_openweathermap_api_key_here
```

### .gitignore Protection

The `.gitignore` file explicitly blocks:
- `.env` - Main environment file
- `.env.*` - Any .env variants (.env.local, .env.production, etc.)
- `!.env.example` - Allows only the template

## Best Practices

### ✅ DO

1. **Store all secrets in `.env`**
   ```dart
   final apiKey = dotenv.env['NEWS_API_KEY'];
   ```

2. **Use `.env.example` as documentation**
   - List all required environment variables
   - Use placeholder values
   - Include comments about where to get API keys

3. **Run gitleaks manually before major commits**
   ```bash
   gitleaks detect --source . --verbose
   ```

4. **Commit the security files**
   - `.gitignore` (with .env entries)
   - `.gitleaks.toml` (configuration)
   - `.env.example` (template)

### ❌ DON'T

1. **Never hardcode secrets in source files**
   ```dart
   // BAD - Don't do this!
   final apiKey = 'abc123def456ghi789jkl012mno345pq';
   
   // GOOD - Use environment variables
   final apiKey = dotenv.env['NEWS_API_KEY'];
   ```

2. **Never commit `.env` file**
   - It's already in `.gitignore`
   - Git will warn you if you try to add it

3. **Never use `git add -f .env`**
   - The `-f` flag forces git to add ignored files
   - This bypasses the `.gitignore` protection

4. **Never disable the pre-commit hook**
   - It's your last line of defense

## If Secrets Are Leaked

### If gitleaks blocks your commit:

1. **Remove the secret from the file**
   ```bash
   # Unstage the problematic file
   git restore --staged <filename>
   ```

2. **Move secret to `.env`**
   - Add the key to `.env`
   - Update code to use `dotenv.env['KEY_NAME']`

3. **Restage and commit**
   ```bash
   git add <filename>
   git commit -m "your message"
   ```

### If secrets were already committed:

⚠️ **CRITICAL:** Secrets in git history are considered compromised!

1. **Immediately revoke/rotate the leaked credentials**
   - News API: https://newsapi.org/account
   - OpenWeatherMap: https://home.openweathermap.org/api_keys

2. **Generate new API keys**

3. **Update `.env` with new keys**

4. **DO NOT try to rewrite git history** (for shared repositories)
   - Once pushed, assume the secret is public
   - Rewriting history can break collaborators' repositories

5. **For local-only commits** (not pushed):
   ```bash
   # Remove the file from last commit
   git rm --cached .env
   git commit --amend --no-edit
   ```

## Verification Checklist

Before pushing to remote:

- [ ] `.env` is in `.gitignore`
- [ ] `.env` is NOT tracked by git (`git status` should not show it)
- [ ] `.env.example` exists with placeholder values
- [ ] `.gitleaks.toml` exists
- [ ] Pre-commit hook exists (`.git/hooks/pre-commit` and `.git/hooks/pre-commit.bat`)
- [ ] No secrets in source code (run `gitleaks detect --source .`)
- [ ] README.md includes security section

## Current Status

### Repository Scan Results

Last scan: November 9, 2025

```
⚠️ WARNING: 2 secrets found in git history (commit 9c1edf3)
- NEWS_API_KEY (leaked in .env)
- OPENWEATHERMAP_API_KEY (leaked in .env)
```

**Action Required:** These API keys should be rotated/regenerated.

### Protection Status

✅ `.env` is now properly ignored  
✅ `.env.example` template created  
✅ `.gitleaks.toml` configuration active  
✅ Pre-commit hook installed and working  
✅ Git blocks staging of `.env` file  

## Resources

- [Gitleaks Documentation](https://github.com/gitleaks/gitleaks)
- [OWASP Secret Management](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html)
- [GitHub Secret Scanning](https://docs.github.com/en/code-security/secret-scanning/about-secret-scanning)

## Questions?

If you need to bypass gitleaks for a legitimate reason (e.g., test fixtures):
1. Add the file path to `.gitleaks.toml` allowlist
2. Document WHY it's allowed
3. Get team review before committing
