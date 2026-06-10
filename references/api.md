# API / Backend Stack Reference

## Common Stacks

### Stack A: FastAPI + PostgreSQL (Recommended)
| Component | Choice | Why |
|-----------|--------|-----|
| Framework | FastAPI | Async native, auto OpenAPI docs, Pydantic validation |
| Database | PostgreSQL + SQLAlchemy 2.0 | Mature ORM, async support, migrations via Alembic |
| Auth | FastAPI Users / JWT | Pre-built auth endpoints, OAuth support |
| Task Queue | Celery + Redis | Background jobs, scheduled tasks |
| Hosting | Railway / Fly.io | Docker deploy, managed DB |
| API Docs | Auto-generated Swagger/ReDoc | Built into FastAPI at `/docs` |

### Stack B: Express + Prisma (TypeScript Teams)
| Component | Choice | Why |
|-----------|--------|-----|
| Framework | Express + TypeScript | Largest middleware ecosystem, simple mental model |
| Database | PostgreSQL + Prisma | Type-safe queries, auto-generated client |
| Validation | Zod | Runtime + compile-time type safety |
| Auth | JWT (jsonwebtoken + bcrypt) | Stateless, easy to implement |
| Task Queue | BullMQ + Redis | Battle-tested job processing |
| Hosting | Railway / Render | Docker deploy, managed DB |

### Stack C: Go + Chi (Performance-Critical)
| Component | Choice | Why |
|-----------|--------|-----|
| Framework | Chi (Go) | Lightweight, stdlib-compatible, fast |
| Database | PostgreSQL + pgx/pgxpool | Native Go driver, connection pooling |
| Auth | JWT (golang-jwt) | Lightweight, zero-dependency |
| Migrations | golang-migrate | SQL-based migration files |
| Hosting | Fly.io / Railway | Fast cold starts, Docker deploy |
| Testing | stdlib testing + httptest | No framework needed |

## When to Choose Which

| Criteria | Stack A (FastAPI) | Stack B (Express) | Stack C (Go) |
|----------|-------------------|-------------------|--------------|
| Team language | Python | TypeScript | Go |
| API complexity | High (auto docs) | Medium | Low (manual docs) |
| Async performance | Excellent | Good | Excellent |
| Startup speed | Fast | Fast | Moderate |
| ML/AI integration | Native (Python libs) | Possible (http) | Difficult |
| Binary size | N/A (interpreter) | N/A (Node) | Single binary |
| Learning curve | Low | Low | Medium |

## API Architecture Patterns

### REST API
```
GET    /api/v1/resources      → List (paginated, filtered)
POST   /api/v1/resources      → Create
GET    /api/v1/resources/:id  → Read
PATCH  /api/v1/resources/:id  → Partial update
DELETE /api/v1/resources/:id  → Delete
```

### GraphQL (Apollo Server)
```graphql
type Query {
  resources(limit: Int, offset: Int): [Resource!]!
  resource(id: ID!): Resource
}
type Mutation {
  createResource(input: ResourceInput!): Resource!
}
```

## Sample Environment Variables

```env
# FastAPI
DATABASE_URL="postgresql+asyncpg://user:pass@host:5432/db"
SECRET_KEY="openssl rand -hex 32"
REDIS_URL="redis://:password@host:6379/0"
CORS_ORIGINS="https://app.example.com"
SENTRY_DSN="https://xxx@sentry.io/yyy"
```

## Deployment Quirks

### FastAPI on Railway
- Use `uvicorn src.main:app --host 0.0.0.0 --port $PORT`
- Workers: `gunicorn -k uvicorn.workers.UvicornWorker` for production
- Set `WORKERS=2-4` based on Railway plan
- DB migrations: run via `railway run` or in Docker entrypoint

### Express on Render
- Build command: `npm run build`
- Start command: `node dist/index.js`
- Render free tier sleeps after inactivity (use cron job to keep warm)

### Go on Fly.io
- Multi-stage Dockerfile keeps image small (~10MB)
- `fly deploy` with zero-downtime deploys
- Set `GOGC=off` for maximum throughput in production

## Example Folder Structure (FastAPI)

```
api/
├── src/
│   ├── main.py              # App factory, middleware, routers
│   ├── config.py            # Settings from env vars
│   ├── api/                 # Route handlers
│   │   ├── __init__.py
│   │   ├── v1/              # API versioning
│   │   │   ├── __init__.py
│   │   │   ├── users.py
│   │   │   ├── resources.py
│   │   │   └── health.py
│   │   └── deps.py          # Dependency injection
│   ├── models/              # SQLAlchemy models
│   │   ├── __init__.py
│   │   ├── user.py
│   │   └── resource.py
│   ├── schemas/             # Pydantic schemas
│   │   ├── __init__.py
│   │   ├── user.py
│   │   └── resource.py
│   ├── services/            # Business logic
│   │   ├── __init__.py
│   │   ├── user_service.py
│   │   └── resource_service.py
│   ├── tasks/               # Celery tasks
│   │   ├── __init__.py
│   │   └── notifications.py
│   └── utils/               # Helpers
│       ├── __init__.py
│       ├── security.py
│       └── pagination.py
├── alembic/                 # DB migrations
│   ├── versions/
│   └── env.py
├── tests/
│   ├── conftest.py
│   ├── test_users.py
│   └── test_resources.py
├── Dockerfile
├── docker-compose.yml       # Local dev with Postgres + Redis
├── requirements.txt
├── pyproject.toml
├── alembic.ini
├── .env
└── .env.example
```

## Testing Strategy

| Layer | Tool | What to Test |
|-------|------|-------------|
| Unit | pytest / Vitest / go test | Business logic, validation schemas, pagination helpers |
| Integration | pytest + httpx / supertest / httptest | Endpoints, DB queries, auth middleware, error responses |
| E2E | Playwright / Postman / newman (API collection) | Full user flows via API |
| Contract | pact-js / drf-spectacular (OpenAPI) | API contract compliance |
| Load | locust / k6 / vegeta | Throughput, latency, bottleneck detection |

## When NOT to Choose Each Stack

### Stack A (FastAPI)
- **Avoid when**: Team is TypeScript-only (Express/Go are better fits)
- **Avoid when**: Real-time WebSocket-heavy (possible but Express/Go have better ergonomics)
- **Avoid when**: You need the absolute fastest cold starts (Go wins)

### Stack B (Express + Prisma)
- **Avoid when**: Async/CPU-heavy workloads (Node.js single-threaded — prefer Go)
- **Avoid when**: Need built-in API docs (FastAPI wins with auto OpenAPI)
- **Avoid when**: Strict typing critical (TypeScript helps but runtime validation needs Zod)

### Stack C (Go + Chi)
- **Avoid when**: Rapid prototyping is priority (Go is more verbose, slower to iterate)
- **Avoid when**: Python ML/AI libraries are needed
- **Avoid when**: Team doesn't know Go (learning curve costs time)

## Scaling Limits

| Stack | Breaks At | Upgrade Path |
|-------|-----------|-------------|
| FastAPI + Railway | ~5k concurrent, ~$5 plan | More workers → Redis caching → horizontal with load balancer |
| Express + Railway | ~2k concurrent (single thread) | Cluster mode → horizontal scaling → dedicated server |
| Go + Fly.io | ~50k concurrent (single instance) | Horizontal scaling (Go excels at this) → multi-region |

## Cost Profile

| Stack | Free Tier | Typical Monthly | Notes |
|-------|-----------|----------------|-------|
| FastAPI + Railway | Yes ($5 credit) | $5-25 | Postgres + Redis add-ons extra |
| Express + Railway | Yes ($5 credit) | $5-20 | Lower resource usage than FastAPI |
| Go + Fly.io | Some (3 VMs free) | $0-15 | Cheapest CPU-per-dollar of all three |
