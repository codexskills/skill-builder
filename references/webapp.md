# Web App Stack Reference

## Common Stacks

### Stack A: Next.js + PostgreSQL (Recommended for Most)
| Component | Choice | Why |
|-----------|--------|-----|
| Framework | Next.js 14+ (App Router) | SSR + API routes + file-based routing in one framework |
| Database | PostgreSQL (via Prisma) | ACID compliance, JSON support, rich indexing |
| Auth | NextAuth v5 | Built for Next.js, supports 20+ providers |
| Hosting | Vercel | Zero-config Next.js deployment, edge functions |
| CSS | Tailwind CSS | Utility-first, rapid prototyping |
| State | React Server Components + TanStack Query | RSC for server state, TanStack for client cache |
| Validation | Zod | Runtime type checking, inferred TypeScript types |

### Stack B: Remix + SQLite (Small Projects)
| Component | Choice | Why |
|-----------|--------|-----|
| Framework | Remix | Web standard APIs, progressive enhancement |
| Database | SQLite (via Turso/libsql) | Zero ops, serverless, fits small apps |
| Auth | Remix Auth | Lightweight, session-based |
| Hosting | Fly.io / Cloudflare Pages | Edge-deployable, generous free tier |
| CSS | Tailwind CSS | Same as above, universal |
| State | Remix loaders/actions | No client state needed for most apps |

### Stack C: Django + PostgreSQL (Python Teams)
| Component | Choice | Why |
|-----------|--------|-----|
| Framework | Django + DRF | Full-featured ORM, admin panel, mature ecosystem |
| Database | PostgreSQL | Best-in-class for Django ORM |
| Auth | django-allauth | Social auth, 2FA, email verification built-in |
| Hosting | Railway / Render | Easy Docker deploy, managed Postgres |
| CSS | Tailwind CSS via django-tailwind | Keeps styling modern |
| State | Django REST + htmx | Minimal JS, server-rendered interactivity |

## When to Choose Which

| Criteria | Stack A (Next.js) | Stack B (Remix) | Stack C (Django) |
|----------|-------------------|-----------------|-------------------|
| Team language | TypeScript | TypeScript | Python |
| SEO critical | Excellent (SSR) | Excellent (SSR) | Good (SSR) |
| Real-time features | Good (WebSocket libs) | Moderate | Moderate (Django Channels) |
| Startup speed | Fast | Fast | Moderate |
| Enterprise features | Moderate | Moderate | Excellent (admin, ORM) |
| Hiring pool | Large (JS devs) | Small (niche) | Large (Python devs) |

## Sample Environment Variables

```env
# Next.js + Prisma + PostgreSQL
DATABASE_URL="postgresql://user:pass@host:5432/db"
NEXTAUTH_SECRET="openssl rand -base64 32"
NEXTAUTH_URL="https://your-domain.com"
GITHUB_CLIENT_ID=""
GITHUB_CLIENT_SECRET=""
NEXT_PUBLIC_APP_URL="https://your-domain.com"
```

## Deployment Quirks

### Vercel (Next.js)
- Serverless functions have 10s timeout (Hobby), 60s (Pro), 300s (Enterprise)
- Edge functions: 1ms-50ms cold starts, 1MB code limit
- PostgreSQL via Neon/PlanetScale (not direct connect — use connection pooler)
- Set `DATABASE_URL` with `?pgbouncer=true&connection_limit=1` for serverless

### Railway (Any)
- Docker-based deploy — include `Dockerfile` in repo root
- Managed PostgreSQL with automatic backups
- Attach volume for persistent file storage (e.g., uploads)
- Set `PORT` env var — Railway injects this automatically

### Render (Django)
- Use `gunicorn` as WSGI server
- Set `DJANGO_SETTINGS_MODULE=yourproject.settings_production`
- Static/media files need cloud storage (S3/R2) — Render ephemeral filesystem

## Example Folder Structure (Next.js)

```
web-app/
├── src/
│   ├── app/                 # App Router pages
│   │   ├── (auth)/          # Auth-required routes
│   │   ├── api/             # API route handlers
│   │   ├── layout.tsx
│   │   └── page.tsx
│   ├── components/          # Shared UI components
│   │   ├── ui/              # Base UI (buttons, inputs)
│   │   └── features/        # Feature-specific components
│   ├── lib/                 # Utilities, API clients
│   ├── db/                  # Prisma schema + migrations
│   └── styles/              # Global CSS, Tailwind config
├── public/                  # Static assets
├── prisma/
│   ├── schema.prisma
│   └── seed.ts
├── tests/
│   ├── unit/
│   └── e2e/
├── .env
├── .env.example
├── Dockerfile
├── next.config.ts
├── package.json
├── tailwind.config.ts
└── tsconfig.json
```

## Testing Strategy

| Layer | Tool | What to Test |
|-------|------|-------------|
| Unit | Vitest (Next.js) / pytest (Django) | Functions, hooks, utilities, model methods |
| Integration | Vitest + MSW / pytest + test DB | API routes, DB queries, middleware |
| E2E | Playwright / Cypress | Critical user flows (signup → action → success) |
| Visual | Storybook + Chromatic (optional) | UI component regression |
| A11y | axe-core / Pa11y | WCAG compliance checks in CI |

## When NOT to Choose Each Stack

### Stack A (Next.js)
- **Avoid when**: Full control over server environment needed (SSR caching, custom server config)
- **Avoid when**: Python ML/AI libraries are core to the app (use Django or separate API)
- **Avoid when**: App is a simple static site (overkill — use Astro or plain HTML)

### Stack B (Remix + SQLite)
- **Avoid when**: Multiple concurrent writers needed (SQLite is single-writer)
- **Avoid when**: Expected to scale beyond ~10k daily users
- **Avoid when**: Team is not comfortable with progressive enhancement patterns

### Stack C (Django)
- **Avoid when**: Real-time features are core (Django Channels adds complexity)
- **Avoid when**: Team prefers TypeScript/JS full-stack
- **Avoid when**: Startup speed is critical (Django scaffolding takes longer)

## Scaling Limits

| Stack | Breaks At | Upgrade Path |
|-------|-----------|-------------|
| Next.js + Vercel Hobby | 60 req/min, 10s timeout | Upgrade to Pro ($20/mo) → Enterprise |
| Remix + SQLite (Turso) | ~10k concurrent users, 1GB DB | Migrate to PostgreSQL (Turso → Neon) |
| Django + Railway Starter | ~$5 RAM limit, 500 concurrent | Upgrade to $10-25 plan → dedicated server |

## Cost Profile

| Stack | Free Tier | Typical Monthly | Notes |
|-------|-----------|----------------|-------|
| Next.js + Vercel Hobby | Yes (limited) | $0-20 | Free: 100GB bandwidth, 60 req/min |
| Remix + Fly.io | Some (limited) | $0-15 | Free: 3 shared VMs, 160GB outbound |
| Django + Railway | Yes (limited) | $5-20 | Free: $5 credit, no sleep |
