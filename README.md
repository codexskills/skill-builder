# StackForge v1.1.0

Full project blueprint generator agent skill. When a user wants to build any software project, StackForge produces a production-ready blueprint covering tech stack, folder structure, database design, system architecture, development roadmap, and deployment.

## Installation

Copy the `stackforge/` directory to your skills directory:

```bash
# OpenCode / Claude Code
cp -r stackforge /path/to/skills/

# Or symlink
ln -s $(pwd)/stackforge /data/data/com.termux/files/home/.config/opencode/skills/stackforge
```

## Usage

Trigger the skill by saying any of:

- `"I want to build X"` / `"Build me X"`
- `"Help me create X"`
- `"What stack should I use for X"`
- `"Give me a project blueprint for X"`
- `"How do I architect X"`
- `"Design my project"` / `"Plan my project"`

### Example

> **User**: "Build a Telegram bot for restaurant food ordering"
>
> **StackForge** produces a blueprint with:
> - Python + python-telegram-bot + PostgreSQL + Redis + Railway
> - 7 database tables (users, restaurants, menu_items, orders, order_items, payments)
> - 6-phase development roadmap (6 weeks)
> - Deployment commands for Local → Staging → Production
> - Testing strategy, security considerations, cost breakdown, risk mitigation
> - Best practices for payments, rate limiting, and webhook handling

## Project Types Supported

| Type | Reference File |
|------|---------------|
| Web App (SaaS, dashboard, landing page) | `references/webapp.md` |
| Bot (Telegram, Discord, Slack) | `references/bot.md` |
| API / Backend / Microservices | `references/api.md` |
| Mobile App (iOS, Android) | `references/mobile.md` |
| AI System (RAG, LLM, agents) | `references/ai.md` |
| CLI Tool / Script | `references/cli.md` |
| Static Site, Browser Extension, Desktop App | General knowledge (no dedicated ref) |

## What's New in v1.1.0

- **More project types**: Static Site, Browser Extension, Desktop App detection
- **Smarter input handling**: POC vs Production, existing stack, migration mode
- **Critical validation checks**: Built-in guardrails for security, auth, monitoring
- **Richer blueprints**: Optional Testing Strategy, Cost Breakdown, Risks & Mitigations, Alternatives Considered
- **Conversation flow**: Guided input collection with edge case handling
- **Cost-aware recommendations**: Free tier limits and scaling warnings per stack
- **Collaboration triggers**: Delegation paths to other skills (security, CI/CD, API design)

## Output

Core 10 sections + optional appendices:

1. Project Summary
2. Core Requirements (with P0/P1 priority)
3. Recommended Tech Stack (with justifications + version numbers)
4. Folder Structure (copy-paste ready)
5. Database Design (column-level detail with indexes)
6. System Architecture (ASCII diagram + data flow)
7. Development Roadmap (phased with milestones)
8. Deployment Guide (commands for Local → Staging → Production)
9. GitHub Repository Structure (branch strategy per team size)
10. Best Practices & Warnings (security, performance, scaling)

**Optional Appendices**: Testing Strategy, Cost Breakdown, Risks & Mitigations, Alternatives Considered

## Compatibility

| Platform | Status |
|----------|--------|
| Claude Code | ✅ |
| OpenCode | ✅ |
| Gemini CLI | ✅ |
| Codex | ✅ |

## File Structure

```
stackforge/
├── SKILL.md                  # Main skill file (v1.1.0)
├── README.md                 # This file
├── references/
│   ├── webapp.md             # Stack details for web apps
│   ├── bot.md                # Stack details for bots
│   ├── api.md                # Stack details for APIs
│   ├── mobile.md             # Stack details for mobile
│   ├── ai.md                 # Stack details for AI systems
│   └── cli.md                # Stack details for CLI tools
├── examples/
│   ├── telegram-bot.md       # Sample: Telegram food ordering bot
│   └── saas-platform.md      # Sample: SaaS analytics dashboard
└── templates/
    └── blueprint.md          # Blueprint template with all sections
```
