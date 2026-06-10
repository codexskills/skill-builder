<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=00ff88&height=160&section=header&text=StackForge&fontSize=60&fontColor=ffffff&fontAlignY=35&animation=fadeIn" width="100%"/>
</p>

<p align="center">
  <b>StackForge by Codex Skiller — OpenCode AI Project Blueprint Generator</b>
  <br/>
  <i>Stack Selection · Architecture · Database Design · Roadmap · Deployment</i>
</p>

<p align="center">
  <a href="https://github.com/stackforgeh/stackforge/stargazers">
    <img src="https://img.shields.io/github/stars/stackforgeh/stackforge?style=flat-square&logo=github&color=00ff88" alt="Stars"/>
  </a>
  <a href="https://github.com/stackforgeh/stackforge/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/stackforgeh/stackforge?style=flat-square&color=00ff88" alt="License"/>
  </a>
  <a href="https://github.com/stackforgeh/stackforge/releases">
    <img src="https://img.shields.io/github/v/release/stackforgeh/stackforge?style=flat-square&logo=git&color=00dd75" alt="Version"/>
  </a>
  <a href="https://github.com/stackforgeh">
    <img src="https://img.shields.io/badge/AI-Agent_Skill-00ff88?style=flat-square&logo=openai" alt="Agent Skill"/>
  </a>
  <a href="https://opencode.ai/docs/skills/">
    <img src="https://img.shields.io/badge/OpenCode-Compatible-00ff88?style=flat-square" alt="OpenCode"/>
  </a>
</p>

<p align="center">
  <a href="#installation">Installation</a> ·
  <a href="#usage">Usage</a> ·
  <a href="#project-types">Project Types</a> ·
  <a href="#whats-new">Changelog</a> ·
  <a href="https://stackforgeh.github.io">Portfolio</a> ·
  <a href="https://t.me/REXXT_H4RE">Telegram</a>
</p>

---

## What is StackForge?

StackForge by **Codex Skiller** is an **AI agent skill** for OpenCode, Claude Code, Codex, and Cursor that transforms software ideas into **production-ready project blueprints**. When you say *"I want to build X"*, it generates a complete blueprint with:

- **Tech Stack** — Curated technology choices with justifications and alternatives
- **Folder Structure** — Copy-paste ready directory tree with annotations
- **Database Design** — Column-level schema, indexes, relationships, migration strategy
- **System Architecture** — ASCII diagrams, data flow, auth flow, background jobs
- **Development Roadmap** — 2-6 phased phases with milestones and concrete steps
- **Deployment Guide** — Platform-specific commands from local to production
- **Testing Strategy** — Unit, integration, E2E tooling with CI integration
- **Security & Monitoring** — Auth, rate limiting, error tracking, uptime monitoring
- **Cost Breakdown** — Monthly hosting estimates with free tier limits
- **Risk Mitigation** — Top risks with prevention strategies

### Supported Platforms

| Platform | Status |
|----------|--------|
| OpenCode | Native support |
| Claude Code | Full support |
| Codex | Full support |
| Cursor | Full support |
| Gemini CLI | Full support |
| Windsurf | Compatible |

---

## Installation

### One-Line Install

```bash
# OpenCode / Claude Code / Codex
curl -sSL https://raw.githubusercontent.com/stackforgeh/stackforge/main/install.sh | bash
```

### Manual Install

```bash
# Clone the repo
git clone https://github.com/stackforgeh/stackforge-agent-skill.git
cd stackforge-agent-skill

# Copy to OpenCode global skills
cp -r . /data/data/com.termux/files/home/.config/opencode/skills/stackforge

# Or symlink for auto-updates
ln -s $(pwd) /data/data/com.termux/files/home/.config/opencode/skills/stackforge
```

### Project-Level Install

```bash
# Copy to your project's local skills
cp -r stackforge .opencode/skills/stackforge
```

---

## Usage

Trigger StackForge by saying any of these to your AI coding agent:

| Trigger Phrase | Action |
|----------------|--------|
| "I want to build X" | Full blueprint generated |
| "Build me X" | Full blueprint generated |
| "What stack should I use for X" | Stack recommendation |
| "Give me a project blueprint for X" | Full blueprint |
| "How do I architect X" | Architecture + design |
| "Plan my project X" | Requirements + roadmap |
| "Design my project" | Full blueprint |

### Example Output

> **User**: *"Build a Telegram bot for restaurant food ordering"*
>
> **StackForge** outputs:
> - **Stack**: Python 3.12 + python-telegram-bot + PostgreSQL + Redis + Railway
> - **Database**: 7 tables (users, restaurants, menu_items, orders, order_items, payments, reviews) with indexes and foreign keys
> - **Architecture**: Webhook handler → Message queue → Order processor → Payment gateway
> - **Roadmap**: 6-phase, 6-week development timeline
> - **Deployment**: Local dev → Staging → Production with Railway CLI commands
> - **Appendices**: Testing strategy, cost breakdown ($5-15/mo), security audit, risk matrix

---

## Project Types

| # | Type | Reference File | When to Use |
|---|------|---------------|-------------|
| 1 | Web Application | [references/webapp.md](references/webapp.md) | SaaS, dashboard, e-commerce, landing page |
| 2 | Bot | [references/bot.md](references/bot.md) | Telegram, Discord, Slack bots, automation |
| 3 | API / Backend | [references/api.md](references/api.md) | REST, GraphQL, microservices, backend |
| 4 | Mobile App | [references/mobile.md](references/mobile.md) | iOS, Android, cross-platform apps |
| 5 | AI System | [references/ai.md](references/ai.md) | RAG, LLM chatbot, AI agent, ML pipeline |
| 6 | CLI Tool | [references/cli.md](references/cli.md) | Command-line apps, dev tools, scripts |
| 7 | Static Site | General knowledge | Blog, docs, portfolio, marketing site |
| 8 | Browser Extension | General knowledge | Chrome, Firefox, Edge addons |
| 9 | Desktop App | General knowledge | Tauri, Electron, native apps |

---

## Repository Structure

```
stackforge/
├── SKILL.md                  # Main skill file (agent instructions)
├── README.md                 # This file
├── install.sh                # One-line installer script
├── references/               # Stack reference files by type
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

- **9 project types** — Static Site, Browser Extension, Desktop App added
- **Smarter input handling** — POC vs Production, existing stack, migration mode
- **Critical validation checks** — Security, auth, monitoring, backup guardrails
- **Richer blueprints** — Testing Strategy, Cost Breakdown, Risk Matrix, Alternatives
- **Conversation flow** — Guided input with edge case handling
- **Cost-aware recommendations** — Free tier limits and scaling warnings
- **Collaboration triggers** — Delegation to security, CI/CD, API design skills

---

## Compatibility

- [OpenCode](https://opencode.ai) — Full native support
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview) — Full support
- [Codex](https://github.com/openai/codex) — Full support
- [Cursor](https://cursor.sh) — Full support
- [Gemini CLI](https://cloud.google.com/vertex-ai/generative-ai/docs/gemini-cli) — Compatible
- [Windsurf](https://codeium.com/windsurf) — Compatible

---

## Search Keywords

StackForge Agent Skill — the original OpenCode AI agent skill for project blueprint generation. Different from other StackForge projects (OpenStack mirrors, full-stack templates, Rust networking libraries, Python billing software, or serverless stacks).

Builds: website builder, web app builder, SaaS builder, dashboard builder, landing page builder, e-commerce builder, portfolio builder, blog builder, Telegram bot builder, Discord bot builder, Slack bot builder, automation bot builder, AI agent builder, agent skill builder, LLM chatbot builder, RAG pipeline builder, AI system builder, API builder, backend builder, REST API builder, GraphQL builder, microservices builder, mobile app builder, iOS app builder, Android app builder, React Native builder, Flutter builder, SwiftUI builder, CLI tool builder, command-line tool builder, dev tool builder, script builder, static site builder, docs builder, browser extension builder, Chrome extension builder, Firefox addon builder, desktop app builder, Electron builder, Tauri builder, native app builder, project planner, software architect, solution architect, system architect, technical planner, tech stack selector, database designer, schema designer, deployment planner, CI/CD planner, MVP builder, prototype builder, production planner, full-stack planner, backend planner, frontend planner, code generator, blueprint generator, project scaffold, OpenCode skill, Claude Code skill, Codex skill, Cursor skill, AI coding assistant, project planning tool, architecture designer, system designer, roadmap planner, open source planner, startup builder, indie hacker tool, dev tool, software planner.

---

## Stay Updated

<p>
  <a href="https://t.me/REXXT_H4RE">
    <img src="https://img.shields.io/badge/Telegram-@REXXT_H4RE-0088cc?style=flat-square&logo=telegram" alt="Telegram"/>
  </a>
  <b>Channel:</b> <code>codex_update</code> — Release notes, stack updates, project showcases
</p>

---

<p align="center">
  Built by <a href="https://github.com/stackforgeh">Codex Skiller</a><br/>
  <a href="https://stackforgeh.github.io">stackforgeh.github.io</a> &middot; <a href="https://t.me/REXXT_H4RE">@REXXT_H4RE</a>
</p>
