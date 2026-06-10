# Bot Stack Reference

## Common Stacks

### Stack A: Python + python-telegram-bot (Recommended for Telegram)
| Component | Choice | Why |
|-----------|--------|-----|
| Language/Framework | Python + python-telegram-bot | Mature, well-documented, huge community |
| Database | PostgreSQL (via asyncpg/psycopg) | ACID, JSON fields for flexible bot state |
| Cache/Queue | Redis | Session storage, rate limiting, job queues |
| Async | asyncio + uvicorn | Native async throughout |
| Hosting | Railway / Fly.io | Cheap, easy Docker deploy |
| CI/CD | GitHub Actions | Free for public repos |

### Stack B: Node.js + Telegraf (TypeScript Teams)
| Component | Choice | Why |
|-----------|--------|-----|
| Language/Framework | TypeScript + Telegraf | Type safety, npm ecosystem |
| Database | PostgreSQL (via Prisma/Kysely) | Type-safe queries, migrations |
| Cache/Queue | Redis (via ioredis) | Session store, rate limiting |
| Hosting | Railway / Vercel (serverless) | Generous free tiers |
| Webhook | Express or Fastify | Required for production webhook mode |

### Stack C: Node.js + grammY (Modern TypeScript)
| Component | Choice | Why |
|-----------|--------|-----|
| Language/Framework | TypeScript + grammY | Modern API, plugin system, Deno support |
| Database | Any (grammY is DB-agnostic) | Bring your own |
| Plugins | grammY plugins | Built-in sessions, menus, i18n, conversations |
| Hosting | Railway / Fly.io | Dockerized deployment |

## Bot vs Webhook

| Method | Best For | Notes |
|--------|----------|-------|
| Polling (long-poll) | Development, low-traffic | Simple, no domain needed |
| Webhook | Production, any scale | Requires HTTPS + public domain |
| Serverless webhook | Vercel/Cloudflare | Cold starts, 10s timeout |

## Sample Environment Variables

```env
# Telegram Bot
BOT_TOKEN="123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11"
DATABASE_URL="postgresql://user:pass@host:5432/botdb"
REDIS_URL="redis://:password@host:6379"
WEBHOOK_URL="https://your-domain.com/webhook"
ADMIN_IDS="123456789,987654321"
LOG_LEVEL="INFO"
```

## Deployment Quirks

### Railway
- Single Dockerfile deploy
- Connect managed PostgreSQL and Redis add-ons
- Set `WEBHOOK_DOMAIN` to Railway's generated domain or custom domain
- Use `start` command: `python main.py` or `node dist/bot.js`

### Vercel Serverless
- Export webhook handler as serverless function
- 10s timeout limit — not ideal for long-running commands
- Use polling instead if bot is low-traffic

### Fly.io
- Deploy via `fly launch`
- Attach Fly Postgres and Upstash Redis
- Set `BOT_TOKEN` as secret: `fly secrets set BOT_TOKEN=xxx`
- Auto-scaling with min/max instances config

## Example Folder Structure (Python + python-telegram-bot)

```
telegram-bot/
├── src/
│   ├── bot.py               # Bot initialization, webhook setup
│   ├── config.py            # Settings from env vars
│   ├── handlers/            # Command and message handlers
│   │   ├── __init__.py
│   │   ├── start.py
│   │   ├── menu.py
│   │   └── admin.py
│   ├── keyboards/           # Inline and reply keyboards
│   │   ├── __init__.py
│   │   └── menu.py
│   ├── services/            # Business logic
│   │   ├── __init__.py
│   │   ├── order.py
│   │   └── payment.py
│   ├── models/              # Database models
│   │   ├── __init__.py
│   │   ├── user.py
│   │   └── order.py
│   ├── middleware/          # Rate limiting, logging
│   │   ├── __init__.py
│   │   └── ratelimit.py
│   └── utils/               # Helpers
│       ├── __init__.py
│       └── helpers.py
├── alembic/                 # DB migrations (if using Alembic)
├── Dockerfile
├── requirements.txt
├── .env
├── .env.example
└── README.md
```

## Platform-Specific Notes

### Discord Bots
- Use `discord.py` (Python) or `discord.js` (JS/TS)
- Slash commands are required for verified bots
- Bot needs `Privileged Gateway Intents` enabled in Developer Portal
- Host anywhere with websocket support (no webhooks needed)

### Slack Bots
- Use Bolt SDK (Python: `bolt-python`, JS: `bolt-js`)
- Socket Mode for development (no public URL needed)
- HTTP mode for production with Slack Events API
- Register slash commands and interactivity in Slack API dashboard

## Testing Strategy

| Layer | Tool | What to Test |
|-------|------|-------------|
| Unit | pytest / Vitest | Handler functions, order logic, menu parsing |
| Bot flow | python-telegram-bot `Application.builder()` with custom client / Telegraf `createBot()` | Command responses, callback queries, conversation flows |
| Integration | pytest + test DB / Vitest + test DB | DB queries, model validations, Alembic/Prisma migrations |
| Webhook | FastAPI test client / Express supertest | Webhook parsing, signature verification, error response |

## When NOT to Choose Each Stack

### Stack A (Python + python-telegram-bot)
- **Avoid when**: Team only knows Node.js (stick with Telegraf/grammY)
- **Avoid when**: Bot needs complex web UI alongside (use FastAPI + bot separate)
- **Avoid when**: Deployment must be serverless (Python cold starts > Node.js)

### Stack B (Node.js + Telegraf)
- **Avoid when**: Python data/ML processing is core to bot functionality
- **Avoid when**: Team prefers polling over webhooks (Telegraf webhook setup is more complex)

### Stack C (grammY)
- **Avoid when**: Need maximum community examples (grammY is newer, fewer tutorials)
- **Avoid when**: Team needs corporately-supported library (grammY is community-maintained)

## Scaling Limits

| Stack | Breaks At | Upgrade Path |
|-------|-----------|-------------|
| Python + polling | ~1k users (single process) | Switch to webhook mode → add workers → horizontal scaling |
| Python + webhook | ~10k users (1 Railway instance) | Upgrade Railway instance → add Redis cache → multiple bot instances with shared DB |
| Node.js + Telegraf webhook | ~5k users (Vercel free) | Vercel Pro → dedicated server with process manager |

## Cost Profile

| Stack | Free Tier | Typical Monthly | Notes |
|-------|-----------|----------------|-------|
| Python + Railway | Yes ($5 credit) | $5-15 | Managed Postgres + Redis included |
| Node.js + Vercel | Yes (limited) | $0-20 | Vercel free: 100GB bandwidth, 10s timeout |
| TypeScript + Fly.io | Some ($5/mo) | $5-15 | Fly: 3 shared VMs free with card |
