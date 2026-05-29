# Architecture

## Purpose

ClaimWise AI is a portfolio-oriented Gen AI assistant for synthetic insurance claim analysis. It combines retrieval-augmented generation, structured claim extraction, deterministic business rules, and a LangGraph state machine.

The architecture is intentionally simple enough to finish in two weeks while still showing production awareness.

## High-Level Flow

```text
User
-> Streamlit UI or FastAPI endpoint
-> LangGraph Agent Orchestrator
-> RAG pipeline and claim tools
-> Final response with citations, confidence, missing information, and next action
```

## Main Components

### Streamlit UI

The Streamlit app is the primary demo interface. It should expose:

- Policy Q&A
- Claim Analyzer
- Email Draft Generator
- Evaluation Dashboard

The UI should call project services rather than contain business logic directly.

### FastAPI

FastAPI is the API layer for portfolio and deployment readiness. It can expose endpoints for:

- policy questions
- claim analysis
- email draft generation
- health checks

FastAPI should reuse the same RAG and agent modules used by Streamlit.

### Document Ingestion

The ingestion pipeline loads synthetic Markdown policy documents, splits them into chunks, and attaches metadata.

Key metadata fields:

- source
- document_type
- policy_type
- section
- chunk_id

### Vector Store

Chroma is used as the local vector store for the MVP.

Responsibilities:

- store document embeddings
- support semantic search
- return chunks with metadata
- persist local indexes under `data/vector_store/`

Production alternative: pgvector on Amazon RDS or Aurora PostgreSQL.

### RAG Pipeline

The RAG pipeline retrieves relevant policy context and generates grounded answers.

Responsibilities:

- retrieve top-k chunks
- optionally apply metadata filtering
- optionally apply reranking
- generate an answer using retrieved context
- provide citations
- return a fallback when context is insufficient

### LLM Provider

The MVP uses Ollama Cloud.

Two access modes are possible:

- local Ollama runtime with cloud models, such as `gpt-oss:20b-cloud`
- direct API access through `https://ollama.com/api` using `OLLAMA_API_KEY`

For this project, keep provider configuration in environment variables and isolate provider-specific code in config or model factory utilities.

### Agent Orchestrator

LangGraph coordinates the workflow through explicit nodes rather than an unconstrained autonomous loop.

Planned nodes:

- classify_intent
- retrieve_policy_context
- extract_claim_info
- check_missing_documents
- generate_grounded_answer
- generate_email_draft
- validate_answer

### Business Rule Tools

Business rules should be deterministic and auditable. The LLM may extract claim facts, but rules such as required documents and manual review triggers should be implemented in normal Python logic.

Examples:

- travel delay is covered only if delay is greater than 6 hours
- lost baggage requires baggage tag, airline irregularity report, and supporting evidence
- home water damage declaration after 5 days requires manual review

### Evaluation

Start with custom metrics before adding RAGAS.

Suggested MVP metrics:

- retrieval hit rate
- citation presence
- answer groundedness check
- fallback correctness
- missing document rule accuracy

## Agent State

The agent state should include:

- user_input
- intent
- chat_history
- retrieved_contexts
- claim_info
- missing_documents
- final_answer
- draft_email
- confidence
- errors

## Deployment Direction

Local MVP:

```text
Activated .venv
-> Streamlit/FastAPI
-> LangGraph
-> Chroma local
-> Ollama Cloud
```

Local development should use Python 3.11, pinned by the repository-level `.python-version` file. Create the environment with `uv venv`, activate it, confirm `python --version`, and install dependencies with `uv pip install -r requirements.txt`. The `.venv` directory is local-only and should not be committed.

AWS-ready direction:

```text
Application Load Balancer
-> ECS Fargate service
-> FastAPI app
-> S3 for documents
-> RDS PostgreSQL with pgvector
-> CloudWatch logs and metrics
-> Secrets Manager for API keys
```

## Design Principles

- Keep the MVP small and demonstrable
- Use source-grounded answers with citations
- Keep deterministic rules outside the LLM
- Keep RAG, agent, UI, and evaluation code separate
- Make uncertainty visible instead of hiding it
- Prefer testable modules over clever abstractions
