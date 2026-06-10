<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=00ff88&height=160&section=header&text=StackForge&fontSize=60&fontColor=ffffff&fontAlignY=35&animation=fadeIn" width="100%"/>
</p>

<p align="center">
  <b>StackForge by Codex Skiller — AI Project Blueprint Generator</b>
  <br/>
  <i>Works with OpenCode · Claude Code · Codex · Cursor · ChatGPT · Windsurf · Gemini CLI</i>
</p>

<p align="center">
  <a href="https://github.com/codexskills/skill-builder/stargazers">
    <img src="https://img.shields.io/github/stars/codexskills/skill-builder?style=flat-square&logo=github&color=00ff88" alt="Stars"/>
  </a>
  <a href="https://github.com/codexskills/skill-builder/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/codexskills/skill-builder?style=flat-square&color=00ff88" alt="License"/>
  </a>
  <a href="https://github.com/codexskills/skill-builder/releases">
    <img src="https://img.shields.io/github/v/release/codexskills/skill-builder?style=flat-square&logo=git&color=00dd75" alt="Version"/>
  </a>
  <img src="https://img.shields.io/badge/OpenCode-✓-00ff88?style=flat-square" alt="OpenCode"/>
  <img src="https://img.shields.io/badge/Claude_Code-✓-00ff88?style=flat-square" alt="Claude Code"/>
  <img src="https://img.shields.io/badge/Codex-✓-00ff88?style=flat-square" alt="Codex"/>
  <img src="https://img.shields.io/badge/Cursor-✓-00ff88?style=flat-square" alt="Cursor"/>
  <img src="https://img.shields.io/badge/ChatGPT-✓-00ff88?style=flat-square" alt="ChatGPT"/>
  <img src="https://img.shields.io/badge/Windsurf-✓-00ff88?style=flat-square" alt="Windsurf"/>
</p>

---

## What is StackForge?

StackForge is an **AI agent skill (SKILL.md)** that transforms software ideas into production-ready project blueprints. Works with any AI coding assistant that supports SKILL.md or custom instructions.

When you say *"I want to build X"*, it generates a complete blueprint with:

- **Tech Stack** — curated choices with justifications and alternatives
- **Folder Structure** — copy-paste ready directory tree
- **Database Design** — column-level schema, indexes, relationships
- **System Architecture** — ASCII diagrams, data flow, auth flow
- **Development Roadmap** — phased timeline with milestones
- **Deployment Guide** — platform-specific commands
- **Testing Strategy** — unit, integration, E2E with CI integration
- **Security & Monitoring** — auth, rate limiting, error tracking
- **Cost Breakdown** — monthly hosting estimates with free tier limits
- **Risk Mitigation** — top risks with prevention strategies

---

## Install StackForge on ANY AI Agent

### OpenCode

```bash
# Global install (all projects)
mkdir -p ~/.config/opencode/skills
git clone https://github.com/codexskills/skill-builder.git
cp -r skill-builder ~/.config/opencode/skills/stackforge

# Or project-level install
cp -r skill-builder .opencode/skills/stackforge
```

Restart OpenCode. The skill loads automatically when you say "build me X" or "design my project".

---

### Claude Code (Anthropic)

```bash
# Global install (all projects)
mkdir -p ~/.claude/skills
git clone https://github.com/codexskills/skill-builder.git
cp -r skill-builder ~/.claude/skills/stackforge

# Or project-level install
cp -r skill-builder .claude/skills/stackforge
```

Restart Claude Code. Say "I want to build a Telegram bot" to trigger StackForge.

---

### Codex (OpenAI)

```bash
# Install to Codex skills directory
mkdir -p ~/.codex/skills
git clone https://github.com/codexskills/skill-builder.git
cp -r skill-builder ~/.codex/skills/stackforge
```

Or add to your project:
```bash
cp -r skill-builder .agents/skills/stackforge
```

StackForge auto-detects when you describe a project idea.

---

### Cursor

```bash
# Install as Cursor rule
mkdir -p .cursor/rules
cp skill-builder/SKILL.md .cursor/rules/stackforge.mdc
```

Or add to Cursor's rules directory:
```bash
mkdir -p ~/.cursor/rules
cp skill-builder/SKILL.md ~/.cursor/rules/stackforge.mdc
```

---

### ChatGPT (Custom GPT / Projects)

1. Open ChatGPT
2. Go to **Explore GPTs** → **Create a GPT** (or **Projects** → **Add instructions**)
3. In the **Instructions** field, paste the entire content of `SKILL.md`
4. Save as "StackForge" or "Project Blueprint Generator"

Now when you describe a project idea, ChatGPT will generate blueprints using StackForge's framework.

---

### Windsurf

```bash
# Add to Windsurf rules
cp skill-builder/SKILL.md .windsurfrules
```

---

### Gemini CLI (Google)

```bash
# Install to Gemini CLI skills
mkdir -p ~/.gemini/skills
git clone https://github.com/codexskills/skill-builder.git
cp -r skill-builder ~/.gemini/skills/stackforge
```

---

### Claude.ai (Web)

1. Open [claude.ai](https://claude.ai)
2. Create a new **Project**
3. Go to **Project Settings** → **Knowledge**
4. Upload or paste the content of `SKILL.md`
5. Also paste the relevant reference files from `references/` folder

---

### Any Other AI Agent

Most AI agents support one of these methods:
- **SKILL.md folder**: Copy `skill-builder/` folder to `~/.config/opencode/skills/stackforge/` or the agent's equivalent skills directory
- **Custom instructions**: Paste the content of `SKILL.md` into the agent's system prompt or instructions field
- **Project knowledge**: Upload `SKILL.md` and reference files as project knowledge documents

---

## Quick Install (all platforms)

```bash
git clone https://github.com/codexskills/skill-builder.git
cd skill-builder

# Install to all supported platforms at once
cp -r . ~/.config/opencode/skills/stackforge 2>/dev/null
cp -r . ~/.claude/skills/stackforge 2>/dev/null
cp -r . ~/.codex/skills/stackforge 2>/dev/null
cp -r . ~/.gemini/skills/stackforge 2>/dev/null
cp SKILL.md ~/.cursor/rules/stackforge.mdc 2>/dev/null
cp SKILL.md .windsurfrules 2>/dev/null

echo "StackForge installed!"
```

---

## How to Use

StackForge activates when you say any of these to your AI agent:

| Say This | What Happens |
|----------|--------------|
| "I want to build X" | Full project blueprint |
| "Build me a Telegram bot" | Bot-specific blueprint |
| "Design a SaaS dashboard" | Web app blueprint |
| "What stack should I use for X" | Stack recommendation |
| "Plan my project X" | Requirements + roadmap |
| "Architect an AI chatbot" | AI system architecture |
| "Help me create a mobile app" | Mobile app blueprint |

### Example

> **You**: *"Build a Telegram bot for restaurant food ordering"*
>
> **StackForge outputs**:
> - Stack: Python 3.12 + python-telegram-bot + PostgreSQL + Redis
> - Database: 7 tables with indexes and foreign keys
> - Architecture: Webhook → Queue → Processor → Payment
> - Roadmap: 6 phases over 6 weeks
> - Cost: $5-15/month on Railway free tier

---

## Project Types

| Type | Examples |
|------|----------|
| Web Application | SaaS, dashboard, e-commerce, landing page |
| Bot | Telegram, Discord, Slack bots, automation |
| API / Backend | REST, GraphQL, microservices |
| Mobile App | React Native, Flutter, SwiftUI |
| AI System | RAG, LLM chatbot, AI agent, ML pipeline |
| CLI Tool | Command-line apps, dev tools, scripts |
| Static Site | Blog, docs, portfolio |
| Browser Extension | Chrome, Firefox, Edge addons |
| Desktop App | Tauri, Electron, native |

---

## Repository Structure

```
skill-builder/
├── SKILL.md                  # Main skill file (agent instructions)
├── README.md                 # This file
├── install.sh                # One-line installer
├── references/               # Stack references by type
│   ├── webapp.md
│   ├── bot.md
│   ├── api.md
│   ├── mobile.md
│   ├── ai.md
│   └── cli.md
├── examples/                 # Full blueprint examples
│   ├── telegram-bot.md
│   └── saas-platform.md
└── templates/
    └── blueprint.md          # Blueprint template
```

---

## What's New in v1.1.0

- 9 project types supported
- Smarter input handling (POC, migration, existing stack)
- Critical validation checks (security, auth, monitoring)
- Testing strategy, cost breakdown, risk matrix
- Guided conversation flow
- Cost-aware recommendations with free tier limits
- Collaboration triggers (delegation to other skills)

---

## Search Keywords

StackForge Agent Skill — AI project blueprint generator for all coding assistants. Works with OpenCode, Claude Code, Codex, Cursor, ChatGPT, Windsurf, Gemini CLI. Builds: website builder, Telegram bot builder, Discord bot builder, AI agent builder, chatbot builder, RAG pipeline builder, API builder, backend builder, mobile app builder, CLI tool builder, SaaS builder, e-commerce builder, project planner, software architect, system architect, tech stack selector, database designer, deployment planner, MVP builder, full-stack planner, startup builder, indie hacker tool.

---

## Stay Updated

<p>
  <a href="https://t.me/REXXT_H4RE">
    <img src="https://img.shields.io/badge/Telegram-@REXXT_H4RE-0088cc?style=flat-square&logo=telegram" alt="Telegram"/>
  </a>
  <b>Channel:</b> <code>codex_update</code>
</p>

---

<p align="center">
  Built by <a href="https://github.com/codexskills">Codex Skiller</a><br/>
  <a href="https://codexskills.github.io">codexskills.github.io</a>
</p>
