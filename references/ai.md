# AI System Stack Reference

## Common Stacks

### Stack A: Python + LangChain + OpenAI (Recommended)
| Component | Choice | Why |
|-----------|--------|-----|
| Framework | LangChain / LangGraph | Orchestration, tools, agent loops, state machines |
| LLM Provider | OpenAI / Anthropic | Best-in-class models, function calling |
| Vector DB | pgvector (PostgreSQL extension) | No additional infra, ACID, hybrid search |
| Embeddings | OpenAI text-embedding-3-small | 1536d, cheapest, best quality-per-dollar |
| Document Store | Supabase / Neon | PostgreSQL with pgvector built-in |
| Orchestration | LangGraph | Stateful agent workflows, cycles, branching |
| Monitoring | LangSmith / Weights & Biases | Trace LLM calls, eval, debug |
| Hosting | Railway / Modal | GPU-backed, async, scale-to-zero |

### Stack B: TypeScript + Vercel AI SDK (Frontend-First)
| Component | Choice | Why |
|-----------|--------|-----|
| Framework | Vercel AI SDK (ai package) | Streaming, tool calls, RSC, framework-agnostic |
| LLM Provider | OpenAI / Anthropic via SDK | Unified API across providers |
| Vector DB | Neon pgvector | Serverless Postgres with pgvector |
| Embeddings | Vercel AI Embeddings SDK | Unified embedding interface |
| UI | Next.js + shadcn/ui | Chat UI, streaming components |
| Hosting | Vercel | Edge-optimized, streaming native |

### Stack C: Hugging Face + Transformers (Open-Source)
| Component | Choice | Why |
|-----------|--------|-----|
| Framework | Hugging Face Transformers | 200k+ models, PyTorch, JAX |
| Model Serving | vLLM / TGI | High-throughput LLM serving |
| Inference | Together AI / Fireworks / Groq | Cheap hosted open models |
| Vector DB | Qdrant / Milvus | Purpose-built for vector search |
| Embeddings | BGE / E5 (open-source) | Free, competitive quality |
| Hosting | Modal / RunPod / Lambda | GPU cloud providers |
| Monitoring | LangFuse / MLflow | Open-source LLM observability |

## RAG Architecture Patterns

### Basic RAG
```
User → Embed query → Vector search → Top-K chunks → LLM generate → Response
```

### Advanced RAG
```
User → Query rewrite → Multi-vector search → Re-ranking → Context window assembly → LLM generate → Citation source → Response
```

## Sample Environment Variables

```env
# LangChain + OpenAI
OPENAI_API_KEY="sk-xxx"
ANTHROPIC_API_KEY="sk-ant-xxx"
DATABASE_URL="postgresql://user:pass@host:5432/vectordb"
LANGCHAIN_API_KEY="lsv2_xxx"
LANGCHAIN_PROJECT="my-rag-app"
LANGCHAIN_TRACING_V2="true"
EMBEDDING_MODEL="text-embedding-3-small"
LLM_MODEL="gpt-4o"
```

## Deployment Quirks

### Railway (CPU workloads only)
- LangChain apps are CPU-bound, not GPU — fine on Railway
- Use async workers (uvicorn) for multiple concurrent requests
- Set `WEB_CONCURRENCY=2` for moderate traffic
- Redis for LLM response caching to reduce API costs

### Modal (GPU workloads)
- Best for fine-tuning, batch inference, heavy RAG
- Scale-to-zero, no idle cost
- Attach GPU via `@app.cls(gpu="A10G")`
- Cold start: 5-20s (container image pull)

### Vercel (Edge AI SDK)
- Serverless functions: 30s timeout (Pro)
- Edge functions: 60s timeout, 1MB code limit
- Stream responses via ReadableStream (not SSE)
- Use `@vercel/kv` (Upstash Redis) for conversation history

## Example Folder Structure (LangChain + FastAPI)

```
ai-system/
├── src/
│   ├── main.py              # FastAPI app, endpoints
│   ├── config.py            # Settings from env vars
│   ├── rag/                 # RAG pipeline
│   │   ├── __init__.py
│   │   ├── ingest.py        # Document ingestion
│   │   ├── retrieval.py     # Vector search logic
│   │   ├── generation.py    # LLM call, prompt templates
│   │   └── reranking.py     # Cross-encoder re-ranking
│   ├── agents/              # LangGraph agents
│   │   ├── __init__.py
│   │   ├── chat_agent.py    # Conversational agent
│   │   └── tools/           # Agent tools
│   │       ├── search.py
│   │       └── calculator.py
│   ├── models/              # Data models
│   │   ├── __init__.py
│   │   ├── documents.py
│   │   └── chat.py
│   ├── services/            # Business logic
│   │   ├── embedding_service.py
│   │   └── llm_service.py
│   ├── vector_store/        # pgvector setup
│   │   ├── __init__.py
│   │   └── schema.py
│   └── utils/               # Helpers
│       ├── __init__.py
│       ├── text_splitter.py
│       └── token_counter.py
├── data/                    # Raw documents (gitignored)
├── notebooks/               # EDA, eval notebooks
├── tests/
│   ├── test_rag.py
│   └── test_agents.py
├── Dockerfile
├── requirements.txt
├── pyproject.toml
├── .env
└── .env.example
```

## Key Decisions

| Decision | Recommendation | Why |
|----------|---------------|------|
| Embedding model | text-embedding-3-small | 15x cheaper than ada-002, better quality |
| Chunk size | 500-1000 tokens | Balances context relevance + retrieval speed |
| Chunk overlap | 100-200 tokens | Preserves context across chunk boundaries |
| Top-K | 3-5 chunks | Enough context without diluting relevance |
| LLM model | gpt-4o-mini for cheap, gpt-4o for quality | 10x cost difference |
| Re-ranking | Cohere / BGE-reranker | +10-20% retrieval accuracy |

## Testing Strategy

| Layer | Tool | What to Test |
|-------|------|-------------|
| Unit | pytest / Vitest | Token counting, text splitting, prompt templates, tool functions |
| RAG pipeline | pytest + test embeddings | Retrieval accuracy, chunk overlap behavior, reranking quality |
| LLM integration | pytest + mock LLM | Structured output parsing, tool call handling, error recovery |
| E2E | Playwright / pytest | Full user flow: ask question → retrieve context → generate answer → display |
| Eval | LangSmith / MLflow | Response quality scoring, hallucination detection, latency tracking |
| Load | locust / k6 | RAG pipeline throughput, embedding generation speed, DB query performance |

## When NOT to Choose Each Stack

### Stack A (LangChain + Python)
- **Avoid when**: App is a simple chatbot with no RAG (Vercel AI SDK is simpler)
- **Avoid when**: Team prefers TypeScript throughout (LangChain.js exists but trails Python version)
- **Avoid when**: Latency-critical at scale (LangChain adds ~100-500ms overhead per call — use raw API)

### Stack B (Vercel AI SDK)
- **Avoid when**: Complex agent loops needed (LangGraph is more mature)
- **Avoid when**: Need local/open-source models (Vercel AI SDK is cloud-centric)
- **Avoid when**: GPU-based fine-tuning or training is core requirement

### Stack C (Hugging Face)
- **Avoid when**: Speed of development > model control (hosted APIs are faster to start)
- **Avoid when**: Budget is very low (GPU hosting is expensive — use API-based stack)
- **Avoid when**: Team has no ML background (transformers have steep learning curve)

## Scaling Limits

| Stack | Breaks At | Upgrade Path |
|-------|-----------|-------------|
| LangChain + Railway | ~100 concurrent RAG requests | More Railway workers → Modal GPU → dedicated infra |
| Vercel AI SDK + Pro | 30s function timeout, 1MB code | Vercel Enterprise → dedicated backend for heavy AI |
| Hugging Face + Modal | GPU memory (model-specific) | Bigger GPU → multi-GPU → distributed inference (vLLM) |

## Cost Profile

| Stack | Free Tier | Typical Monthly | Notes |
|-------|-----------|----------------|-------|
| LangChain + OpenAI | No | $50-200+ | OpenAI API costs dominate; Railway is cheap |
| Vercel AI SDK + OpenAI | No | $100-500+ | Vercel Pro ($20) + OpenAI API ($80-500+) |
| Hugging Face (open models) | Some (HF Inference API) | $100-1000+ | GPU hosting (Modal/RunPod) is expensive |
| Self-hosted (vLLM + OSS) | N/A | $500-5000+ | GPU rental (A100: ~$1-3/hr) |
