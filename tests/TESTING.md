# StackForge Testing Guide

Test prompts for each project type across all supported AI agents.

## Quick Test

Start with this simple test on any agent:

```
I want to build a Telegram bot for restaurant food ordering
```

**Pass criteria**: Output includes all 10 sections — Stack, Folder Structure, Database, Architecture, Roadmap, Deployment, Testing, Security, Cost, Risks.

## Test Prompts by Type

### Web Application
```
Build me a SaaS dashboard for tracking freelance projects with client management, invoicing, and time tracking
```

### Bot
```
Create a Discord bot for music playlist sharing with vote-based queue
```

### API / Backend
```
Design a REST API for a food delivery marketplace with real-time tracking
```

### Mobile App
```
I want to build a React Native fitness tracker with workout logging and progress charts
```

### AI System
```
Help me architect a RAG chatbot for customer support using company documentation
```

### CLI Tool
```
Build a CLI tool for scaffolding React components with TypeScript and tests
```

### Static Site
```
Give me a project blueprint for a developer blog with MDX and RSS
```

### Browser Extension
```
Plan a Chrome extension for tab management with groups and search
```

### Desktop App
```
Design a Tauri desktop app for markdown note-taking with local file sync
```

## Platform-Specific Testing

### OpenCode
```bash
# After install, run in any project
opencode
# Say: "I want to build X"
```

### Claude Code
```bash
# After install
claude
# Say: "Build me a Telegram bot"
```

### Codex
```bash
# After install
codex
# Say: "Design an API for..."
```

### Cursor
- Open Cursor
- Press `Cmd+I` to open composer
- Type: "Create a project blueprint for X"

### ChatGPT
- Open StackForge custom GPT (or paste SKILL.md as instructions)
- Type: "I want to build a mobile app for X"

## Output Validation Checklist

| Section | Must Include |
|---------|-------------|
| Tech Stack | Language, framework, database, hosting, justification |
| Folder Structure | Directory tree with file purposes |
| Database Design | Table names, columns, types, indexes, relationships |
| Architecture | ASCII/Mermaid diagram, data flow, auth flow |
| Roadmap | Phases (P0/P1), milestones, timeline |
| Deployment | Local dev, staging, production commands |
| Testing Strategy | Unit, integration, E2E tools |
| Security & Monitoring | Auth, rate limiting, error tracking |
| Cost Breakdown | Monthly estimates, free tier limits |
| Risk Mitigation | Top 3-5 risks with prevention |

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Agent ignores StackForge | Reinstall SKILL.md in correct path |
| Missing sections | Re-prompt: "Add testing strategy and cost breakdown" |
| Wrong stack | Specify: "Use Python, not Node.js" |
| Too generic | Add: "Make it specific to my use case" |
| Installation not found | Check `ls` on skills directory |
