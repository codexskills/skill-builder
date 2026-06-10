# Example: SaaS Dashboard Platform

## Input
> `"Build a SaaS dashboard for small business analytics"`

| Field | Value |
|-------|-------|
| Team Size | 2 developers (1 frontend, 1 full-stack) |
| Timeline | 8 weeks |
| Budget | $50-100/month |
| Expertise | Intermediate TypeScript, familiar with React |
| Existing Stack | None |
| Project Phase | Production (funded startup) |

## Project Summary
A web-based analytics dashboard where small business owners connect their data sources (Stripe, Google Analytics, social media) and get unified metrics, visualizations, and weekly reports. Multi-tenant with tiered pricing.

## Core Requirements
- User authentication (email + Google OAuth)
- Connect external data sources via OAuth/API keys
- Unified metrics dashboard with charts
- Custom date range filtering
- Automated weekly email reports
- Team member invitations
- Subscription tiers (Free, Pro, Enterprise)
- Stripe billing integration
- Responsive design (desktop + mobile)

## Recommended Tech Stack

| Layer | Choice | Why |
|-------|--------|-----|
| Framework | Next.js 14 (App Router) | SSR + API routes + React Server Components |
| Language | TypeScript | Type safety across full stack |
| Database | PostgreSQL 16 + Prisma | Type-safe ORM, migrations, relation queries |
| Auth | NextAuth v5 | Built for Next.js, 20+ providers |
| Charts | Recharts / Tremor | React-native charting, dashboard-ready |
| Queue | Inngest | Serverless job queue, email scheduling |
| Email | Resend | React email templates, high deliverability |
| Billing | Stripe + Stripe SDK | Metered billing, subscription management |
| CSS | Tailwind CSS + shadcn/ui | Pre-built components, consistent design |
| Hosting | Vercel (Pro) | Edge functions, ISR, analytics |
| Monitoring | Sentry + Vercel Analytics | Error tracking, performance |

## Folder Structure

```
saas-dashboard/
├── src/
│   ├── app/                       # Next.js App Router
│   │   ├── (auth)/               # Auth-required routes
│   │   │   ├── dashboard/
│   │   │   │   ├── page.tsx
│   │   │   │   ├── reports/
│   │   │   │   ├── settings/
│   │   │   │   └── billing/
│   │   │   └── layout.tsx
│   │   ├── api/                   # API route handlers
│   │   │   ├── auth/
│   │   │   ├── stripe/
│   │   │   ├── integrations/
│   │   │   └── webhooks/
│   │   ├── (marketing)/          # Public pages
│   │   │   ├── page.tsx          # Landing
│   │   │   ├── pricing/
│   │   │   └── blog/
│   │   ├── layout.tsx
│   │   └── globals.css
│   ├── components/
│   │   ├── ui/                    # shadcn/ui base
│   │   ├── dashboard/            # Dashboard widgets
│   │   │   ├── metrics-card.tsx
│   │   │   ├── revenue-chart.tsx
│   │   │   └── data-table.tsx
│   │   └── layouts/
│   │       ├── sidebar.tsx
│   │       └── header.tsx
│   ├── lib/
│   │   ├── prisma.ts             # DB client singleton
│   │   ├── stripe.ts             # Stripe client
│   │   ├── resend.ts             # Email client
│   │   ├── auth.ts               # NextAuth config
│   │   └── utils.ts
│   ├── integrations/             # Data source connectors
│   │   ├── stripe.ts
│   │   ├── google-analytics.ts
│   │   └── types.ts
│   ├── emails/                   # React Email templates
│   │   ├── weekly-report.tsx
│   │   └── invite.tsx
│   ├── jobs/                     # Inngest background functions
│   │   ├── weekly-email.ts
│   │   └── sync-data.ts
│   ├── middleware.ts             # Next.js middleware
│   └── i18n/                     # Internationalization
├── prisma/
│   ├── schema.prisma
│   └── seed.ts
├── tests/
│   ├── unit/
│   └── e2e/
├── public/
├── .env.example
├── next.config.ts
├── tailwind.config.ts
├── tsconfig.json
├── Dockerfile                    # For self-hosted option
└── README.md
```

## Database Design

### Tables

**users**
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| email | VARCHAR(255) | Unique |
| name | VARCHAR(255) | |
| avatar_url | TEXT | |
| created_at | TIMESTAMPTZ | |
| updated_at | TIMESTAMPTZ | |

**teams**
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| name | VARCHAR(255) | |
| slug | VARCHAR(100) | Unique, URL-friendly |
| plan | VARCHAR | free / pro / enterprise |
| stripe_customer_id | VARCHAR | |
| stripe_subscription_id | VARCHAR | |
| created_at | TIMESTAMPTZ | |

**team_members**
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| team_id | UUID | FK → teams |
| user_id | UUID | FK → users |
| role | VARCHAR | owner / admin / member |
| invited_at | TIMESTAMPTZ | |
| joined_at | TIMESTAMPTZ | |

**integrations**
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| team_id | UUID | FK → teams |
| provider | VARCHAR | stripe / ga4 / meta |
| access_token | TEXT | Encrypted |
| refresh_token | TEXT | Encrypted |
| expires_at | TIMESTAMPTZ | |
| is_active | BOOLEAN | |
| created_at | TIMESTAMPTZ | |

**metrics**
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| team_id | UUID | FK → teams |
| integration_id | UUID | FK → integrations |
| metric_name | VARCHAR(100) | revenue / users / sessions |
| metric_value | DECIMAL(15,2) | |
| recorded_at | TIMESTAMPTZ | |
| metadata | JSONB | Arbitrary context |

**reports**
| Column | Type | Notes |
|--------|------|-------|
| id | UUID | PK |
| team_id | UUID | FK → teams |
| title | VARCHAR(255) | |
| config | JSONB | Chart configs, metrics |
| is_scheduled | BOOLEAN | |
| schedule_cron | VARCHAR | Cron expression |
| last_sent_at | TIMESTAMPTZ | |
| created_at | TIMESTAMPTZ | |

## System Architecture

```
User (Browser) → Next.js (Vercel Edge/Serverless)
                    ↕
        NextAuth → Prisma → PostgreSQL (Neon)
                    ↕
        Stripe API, GA4 API, Meta API
                    ↕
        Inngest (Background Jobs)
                    ↕
        Resend (Email Delivery)
```

- Server Components fetch data directly via Prisma (no API layer needed)
- API routes for mutations, Stripe webhooks, integration callbacks
- Inngest handles: weekly email generation, data sync from integrations
- Edge middleware checks auth + subscription status
- ISR for marketing pages, SSR for dashboard
- Prisma connection pooling via `pgbouncer` for serverless

## Development Roadmap

### Phase 1: Foundation (Week 1-2)
- Next.js project with App Router setup
- Auth (NextAuth + Google + Email)
- Prisma schema + migrations
- Landing page + pricing page
- Team creation flow

### Phase 2: Dashboard (Week 3-4)
- shadcn/ui components setup
- Metrics cards component
- Revenue chart (Recharts)
- Date range filter
- Empty state designs

### Phase 3: Integrations (Week 5-6)
- OAuth flow for Stripe + GA4
- Data sync background jobs
- Metrics storage + aggregation
- Dashboard populated with real data

### Phase 4: Billing (Week 7)
- Stripe subscription setup
- Plan tiers + feature flags
- Upgrade/downgrade flow
- Usage-based billing (if needed)

### Phase 5: Polish (Week 8)
- Weekly email reports (React Email + Resend)
- Team invitations
- Role-based access
- Error boundaries + Sentry

## Deployment Guide

### Local Development
```bash
git clone https://github.com/youruser/saas-dashboard
cd saas-dashboard
cp .env.example .env.local

# Edit .env.local with your keys
npm install

# Start PostgreSQL (Docker)
docker compose up -d postgres

# Run migrations + seed
npx prisma migrate dev
npx prisma db seed

# Start dev server
npm run dev
```

### Staging (Vercel Preview)
- Each PR auto-deploys with Vercel Preview
- Staging DB: separate Neon branch
- Stripe test mode keys
- Sentry test environment

### Production
- Connected to production Vercel project
- Production PostgreSQL (Neon)
- Stripe live keys
- Custom domain + SSL
- Sentry error tracking

```bash
# Promote to production
vercel --prod

# Run migrations
npx prisma migrate deploy

# Verify
curl https://yourdomain.com/api/health
```

## GitHub Repository Structure

```
saas-dashboard/
├── .github/workflows/
│   ├── ci.yml                  # Lint + test
│   ├── e2e.yml                 # Playwright E2E
│   └── deploy.yml              # Vercel deploy
├── src/                        # Application code
├── prisma/                     # Schema + migrations
├── tests/                      # Unit + E2E tests
├── public/                     # Static assets
├── Dockerfile                  # Self-hosted option
├── docker-compose.yml          # Local dev
├── .env.example
├── next.config.ts
├── package.json
└── README.md
```

Branch strategy: `main` (production), `develop` (staging), `feature/*` (PRs).

## Best Practices & Warnings

- **Server Components by default** — move to client only when interactivity is needed
- **Connection pooling** — use `DATABASE_URL` with `?pgbouncer=true` for serverless
- **Encrypt OAuth tokens** — store integration access tokens encrypted at rest
- **Rate limit APIs** — use Vercel's rate limiting or Upstash Ratelimit
- **Stripe webhook idempotency** — verify `stripe-signature` header every time
- **SaaS metrics to track** — MRR, churn, LTV, activation rate from day one
- **Feature flags** — use PostHog or LaunchDarkly for phased rollouts
- **Data isolation** — every query must filter by `team_id` (no cross-team data leaks)
- **Cron jobs** — use Inngest, not Vercel Cron (more reliable + logging)
- **Email deliverability** — warm up domain, set up SPF/DKIM/DMARC

## Appendix A: Testing Strategy

| Layer | Tool | What to Test |
|-------|------|-------------|
| Unit | Vitest + Testing Library | Components, hooks, utility functions, date formatting |
| API routes | Vitest + MSW (Mock Service Worker) | API handlers, auth middleware, Stripe webhooks |
| Integration | Vitest + Prisma test DB | DB queries, team membership logic, integration data sync |
| E2E | Playwright | Full user flow: signup → connect Stripe → view dashboard → invite team → upgrade plan |
| Visual | Chromatic / Storybook | UI regression for chart components and dashboard layouts |
| Email | Resend test mode + React Email preview | Email rendering, responsive design, link validation |

## Appendix B: Alternatives Considered

| Alternative | Why Not Chosen |
|-------------|----------------|
| Remix instead of Next.js | Smaller ecosystem, fewer SaaS-specific examples, smaller hiring pool |
| Django + DRF instead of Next.js | Team knows TypeScript, not Python; Next.js provides SSR + API routes in one framework |
| Chart.js instead of Recharts | Recharts is React-native (declarative), integrates better with shadcn/ui; Chart.js requires imperative wrapper |
| AWS instead of Vercel | Higher complexity (ECS/RDS/CloudFront) — overkill for early-stage SaaS; Vercel's ISR + edge functions cover all needs |
| MongoDB instead of PostgreSQL | SaaS analytics requires relational queries (JOINs across teams/users/metrics); Postgres JSONB covers semi-structured needs |

## Appendix C: Cost Breakdown

| Service | Plan | Monthly Cost |
|---------|------|-------------|
| Vercel | Pro ($20/mo) | $20 |
| PostgreSQL (Neon) | Scale ($19/mo — 10GB, branching) | $19 |
| Inngest | Free (1k runs/mo) → Pro ($10/mo) | $0-10 |
| Resend | Free (100 emails/day) → Pro ($10/mo) | $0-10 |
| Sentry | Team ($26/mo) | $26 |
| Stripe | Pay-as-you-go (2.9% + $0.30) | $10-30 (variable) |
| Domain + Cloudflare | $10/yr domain + free plan | ~$1 |
| **Total** | | **~$56-106/month** |

## Appendix D: Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Stripe OAuth token expires without refresh | Medium | High — integration breaks silently | Implement token refresh flow; send alert when refresh fails; store expiry and pre-refresh at 80% |
| Multi-tenant data leak (cross-team data visible) | Low | Critical — legal + churn disaster | Every query must filter by `team_id`; add RLS policies in Postgres; integration tests verify isolation |
| Third-party API rate limits (GA4, Meta) | High | Medium — dashboard shows stale data | Cache metrics for 15min; implement backoff + retry in sync jobs; show "last updated" timestamps in UI |
| Email landing in spam | Medium | Medium — users miss weekly reports | Set up SPF/DKIM/DMARC before sending; warm up sending domain gradually; monitor deliverability in Resend |
