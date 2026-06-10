# Example: Telegram Food Ordering Bot

## Input
> `"Build a Telegram bot for restaurant food ordering"`

| Field | Value |
|-------|-------|
| Team Size | Solo developer |
| Timeline | 6 weeks |
| Budget | $15-25/month |
| Expertise | Intermediate Python |
| Existing Stack | None |
| Project Phase | MVP → Production |

## Project Summary
A Telegram bot that lets users browse restaurant menus, place food orders, track delivery status, and make payments — all within the Telegram interface. Restaurants manage their listings via an admin panel.

## Core Requirements
- Browse nearby restaurants and their menus
- Add items to cart and place orders
- Receive real-time order status updates
- Payment integration (Telegram Payments or Stripe)
- Restaurant admin panel for menu management
- Order history for users
- Rate limiting to prevent abuse
- Multi-language support (optional)

## Recommended Tech Stack

| Layer | Choice | Why |
|-------|--------|-----|
| Language | Python 3.11+ | Async native, best Telegram bot libraries |
| Bot Framework | python-telegram-bot v21 | Mature, well-documented, callback query support |
| Web Framework | FastAPI | Admin dashboard API, webhook endpoint |
| Database | PostgreSQL 16 + pgvector | ACID for orders, JSON for menu flexibility |
| Cache | Redis 7 | Session storage, rate limiting, job queue |
| ORM | SQLAlchemy 2.0 + Alembic | Async, migration support |
| Admin UI | FastAPI + Jinja2 | Lightweight — no React needed for MVP |
| Payments | Stripe + python-telegram-bot Payments | Global coverage, webhook integration |
| Hosting | Railway + Docker | Cheap ($5-15/mo), managed Postgres + Redis |
| Monitoring | Sentry + Logfire | Error tracking, LLM observability |

## Folder Structure

```
food-bot/
├── src/
│   ├── bot/
│   │   ├── __init__.py
│   │   ├── main.py              # Bot init, webhook
│   │   ├── handlers/
│   │   │   ├── __init__.py
│   │   │   ├── start.py         # /start, registration
│   │   │   ├── menu.py          # Browse menu flow
│   │   │   ├── cart.py          # Cart management
│   │   │   ├── order.py         # Place order flow
│   │   │   ├── payment.py       # Payment flow
│   │   │   └── profile.py       # User profile
│   │   ├── keyboards/
│   │   │   ├── __init__.py
│   │   │   ├── menu.py          # Menu inline keyboards
│   │   │   └── order.py         # Order keyboards
│   │   └── conversations/
│   │       ├── __init__.py
│   │       ├── order_flow.py    # ConversationHandler
│   │       └── address.py       # Address collection
│   ├── api/
│   │   ├── __init__.py
│   │   ├── main.py              # FastAPI app
│   │   ├── routes/
│   │   │   ├── __init__.py
│   │   │   ├── restaurants.py
│   │   │   ├── orders.py
│   │   │   └── webhooks.py      # Stripe webhook
│   │   └── dependencies.py
│   ├── models/
│   │   ├── __init__.py
│   │   ├── user.py
│   │   ├── restaurant.py
│   │   ├── menu_item.py
│   │   ├── cart.py
│   │   ├── order.py
│   │   └── payment.py
│   ├── services/
│   │   ├── __init__.py
│   │   ├── order_service.py
│   │   ├── payment_service.py
│   │   └── notification_service.py
│   ├── admin/
│   │   ├── __init__.py
│   │   ├── templates/
│   │   └── static/
│   ├── config.py                # Pydantic settings
│   └── utils/
│       ├── __init__.py
│       ├── rate_limiter.py
│       └── helpers.py
├── alembic/
│   └── versions/
├── tests/
│   ├── test_handlers.py
│   ├── test_services.py
│   └── test_api.py
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
├── pyproject.toml
├── .env.example
└── README.md
```

## Database Design

### Tables

**users**
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| telegram_id | BIGINT | Unique Telegram user ID |
| phone | VARCHAR | Optional |
| address | TEXT | Delivery address (JSON) |
| lang | VARCHAR(2) | Language code |
| plan | VARCHAR | free / premium |
| created_at | TIMESTAMPTZ | |

**restaurants**
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| name | VARCHAR(255) | |
| description | TEXT | |
| cuisine_type | VARCHAR(100) | |
| is_active | BOOLEAN | |
| admin_telegram_id | BIGINT | FK to users |
| created_at | TIMESTAMPTZ | |

**menu_items**
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| restaurant_id | UUID | FK → restaurants |
| name | VARCHAR(255) | |
| description | TEXT | |
| price_cents | INTEGER | Price in cents |
| category | VARCHAR(100) | |
| is_available | BOOLEAN | |
| image_url | TEXT | |

**orders**
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| user_id | UUID | FK → users |
| restaurant_id | UUID | FK → restaurants |
| status | VARCHAR | pending / confirmed / preparing / delivering / delivered / cancelled |
| total_cents | INTEGER | |
| delivery_address | TEXT | JSON |
| payment_status | VARCHAR | unpaid / paid / refunded |
| stripe_payment_id | VARCHAR | |
| created_at | TIMESTAMPTZ | |
| updated_at | TIMESTAMPTZ | |

**order_items**
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| order_id | UUID | FK → orders |
| menu_item_id | UUID | FK → menu_items |
| quantity | INTEGER | |
| unit_price_cents | INTEGER | Snapshot at order time |

**payments**
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| order_id | UUID | FK → orders |
| stripe_payment_intent_id | VARCHAR | |
| amount_cents | INTEGER | |
| currency | VARCHAR(3) | |
| status | VARCHAR | succeeded / failed / refunded |
| created_at | TIMESTAMPTZ | |

## System Architecture

```
User (Telegram) ←→ Bot (python-telegram-bot) → Webhook → FastAPI → PostgreSQL
                            ↕                                     ↕
                       Redis (cache/queue)                  Stripe API
                            ↕
                       Admin Panel (Jinja2)
```

- Bot runs as webhook mode (production) or polling (dev)
- FastAPI handles Stripe webhooks + admin dashboard
- Redis stores: user sessions, rate limit counters, active cart state
- Celery (optional) for: sending notifications, order timeout handling
- PostgreSQL with connection pooling via PgBouncer for serverless

## Development Roadmap

### Phase 1: Foundation (Week 1)
- Set up Python project with pyproject.toml
- Bot registration with @BotFather
- Database schema with Alembic migrations
- Docker Compose for local dev (Postgres + Redis)
- `/start` command with user registration

### Phase 2: Menu System (Week 2)
- Restaurant model + seed data
- Browse restaurants inline keyboard
- Category → Items menu navigation
- Menu item details with photo + price

### Phase 3: Cart & Ordering (Week 3)
- Cart management (add/remove/view items)
- Address collection conversation
- Place order → DB write → confirmation message
- Order status tracking

### Phase 4: Payments (Week 4)
- Stripe integration (Telegram Payments API)
- Payment success/failure handling
- Receipt message with order summary
- Payment webhook for async confirmations

### Phase 5: Admin & Polish (Week 5)
- Restaurant admin panel (FastAPI + Jinja2)
- Order management for restaurants
- Notification system (order updates)
- Rate limiting with Redis
- Error handling + Sentry

### Phase 6: Deploy (Week 6)
- Dockerfile optimization
- Railway deploy with managed Postgres + Redis
- Webhook URL configuration
- Domain + SSL setup
- Monitoring (Sentry + health checks)

## Deployment Guide

### Local Development
```bash
# Clone and setup
git clone https://github.com/youruser/food-bot
cd food-bot
cp .env.example .env

# Edit .env with your tokens
python -m venv venv && source venv/bin/activate
pip install -r requirements.txt

# Start infrastructure
docker compose up -d postgres redis

# Run migrations
alembic upgrade head

# Run bot (polling mode)
python -m src.bot.main
```

### Staging
```bash
# Deploy to Railway with staging environment
railway login
railway environment --name staging
railway up

# Set env variables
railway variables set BOT_TOKEN=xxx DATABASE_URL=xxx

# Run migrations on staging DB
railway run alembic upgrade head
```

### Production
```bash
# Promotion from staging
railway environment --name production
railway variables set WEBHOOK_URL=https://yourdomain.com/webhook

# Set webhook
railway run python -c "from src.bot.main import setup_webhook; setup_webhook()"

# Verify
curl -X GET "https://api.telegram.org/bot$BOT_TOKEN/getWebhookInfo"
```

## GitHub Repository Structure

```
food-bot/
├── .github/workflows/
│   ├── test.yml
│   └── deploy.yml
├── src/                    # Source code
├── alembic/                # DB migrations
├── tests/                  # Tests
├── Dockerfile              # Production image
├── docker-compose.yml      # Local dev
├── pyproject.toml          # Dependencies
├── .env.example            # Env template
└── README.md               # Setup instructions
```

Branch: `main` only for solo dev. `main` + `develop` for team.

## Best Practices & Warnings

- **Never hardcode bot tokens** — use env vars or secrets manager
- **Rate limit user actions** — Telegram's API has limits, Redis counters prevent abuse
- **Idempotent payment handling** — Stripe webhooks may deliver duplicates; use `idempotency_key`
- **Use webhook mode in prod** — polling is fine for dev but unreliable at scale
- **Database migrations** — always use Alembic, never manual schema changes
- **Conversation state** — store in Redis, not memory (bot restart = lost state)
- **Handle bot blocking** — gracefully handle users who block the bot
- **Logging** — structured JSON logs for production debugging
- **Fallback messages** — handle cases where inline keyboard is stale (user clicked 10min ago)
- **Payment timeout** — cancel unpaid orders after 15 minutes

## Appendix A: Testing Strategy

| Layer | Tool | What to Test |
|-------|------|-------------|
| Unit | pytest + pytest-asyncio | Handler logic, order calculations, menu parsing |
| Integration | pytest + test DB | DB queries, Alembic migrations, model relationships |
| Bot handlers | python-telegram-bot `Application.builder()` with custom HTTP client | Command responses, callback flows, conversation states |
| API (FastAPI) | httpx + pytest | Admin endpoints, Stripe webhook parsing, error codes |
| E2E | python-telegram-bot + polling test client | Full order flow: start → browse → cart → pay |
| Load | locust (optional) | Webhook handling under concurrent users (~100 req/s) |

## Appendix B: Alternatives Considered

| Alternative | Why Not Chosen |
|-------------|----------------|
| aiogram (Python async bot lib) | Less documentation, smaller community, fewer examples for payments |
| Node.js + Telegraf | Equivalent capability but solo dev knows Python better; Python-ecosystem for Stripe SDK is more mature |
| MongoDB instead of PostgreSQL | Order data requires ACID (cart + payment consistency); relational model fits better |
| Vercel serverless | 10s timeout too limiting for bot webhook processing; Railway gives full control |

## Appendix C: Cost Breakdown

| Service | Plan | Monthly Cost |
|---------|------|-------------|
| Railway (web + bot) | Starter ($5/mo + $5 volume) | $10 |
| PostgreSQL (Railway) | Starter ($5/mo included in plan) | $0 |
| Redis (Railway) | Starter ($0 — included) | $0 |
| Stripe | Pay-as-you-go (2.9% + $0.30/transaction) | $5-15 (variable) |
| Sentry (error monitoring) | Free tier (5k events/mo) | $0 |
| Domain | .com via Cloudflare | $0 (no markup) |
| **Total** | | **~$15-25/month** |

## Appendix D: Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Stripe webhook timeout or duplicate delivery | Medium | High — double charge or no charge | Use idempotency keys; verify `stripe-signature` header; reconcile daily |
| Telegram rate limits (30 msg/s per bot) | Medium | Medium — users see delays | Implement Redis-backed rate limiter; queue outbound messages |
| Bot token leak | Low | Critical — bot hijacked | Use Railway secrets (not .env); rotate token if exposed; restrict bot commands to admin-only on first deploy |
