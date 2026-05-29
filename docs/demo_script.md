# Demo Script

## Demo Goal

Show that ClaimWise AI is more than a chat-with-documents app. The demo should highlight RAG, citations, structured extraction, deterministic rules, LangGraph routing, evaluation, and production awareness.

Current status: this is the target demo script for the finished MVP. At the end of Day 1, the repository contains scaffolded modules and synthetic data, but the Streamlit UI, RAG pipeline, claim analyzer, email draft flow, and evaluation runner are not ready to demo yet.

## Day 1 Mini-Demo

Before the app exists, the Day 1 demo is a short walkthrough of project readiness:

1. Show `README.md` and explain the problem, scope, and current status.
2. Show `PROJECT_PLAN.md` and explain the 14-day build path.
3. Show `docs/architecture.md` and describe the planned Streamlit, FastAPI, LangGraph, RAG, and Chroma flow.
4. Show `docs/data_design.md` and the synthetic files under `data/raw_docs/` and `data/sample_claims/`.
5. Explain that implementation packages under `src/` are placeholders and Day 2 starts with ingestion and chunking.

This keeps the Day 1 presentation truthful while still showing architecture, planning, and data readiness.

## Demo Setup

Before running the demo, make sure the local environment is ready.
The project expects Python 3.11 from the root `.python-version` file. If `.venv` was created with another Python version, recreate it before the demo.

Windows PowerShell:

```powershell
uv python pin 3.11
uv venv
.\.venv\Scripts\Activate.ps1
python --version
uv pip install -r requirements.txt
```

macOS/Linux:

```bash
uv python pin 3.11
uv venv
source .venv/bin/activate
python --version
uv pip install -r requirements.txt
```

Confirm `.env` exists and contains the local Ollama configuration. Do not show secret values during the demo.

## Finished MVP Demo Flow

### 1. Introduce the Problem

Claim handlers need to answer policy questions, understand claim descriptions, request missing documents, and communicate clearly with customers.

### 2. Show Policy Q&A

Example question:

```text
Is a 5-hour travel delay covered?
```

Expected behavior:

- retrieves travel policy context
- answers that the delay must be greater than 6 hours
- includes citation
- avoids unsupported claims

### 3. Show Claim Analyzer

Use:

```text
data/sample_claims/lost_baggage_missing_docs.json
```

Expected behavior:

- extracts claim type and key facts
- identifies missing documents
- flags manual review for high-value item evidence
- explains next action

### 4. Show Email Draft

Ask the system to draft a customer email for the missing lost baggage documents.

Expected behavior:

- professional tone
- asks for specific documents
- does not promise approval

### 5. Show Evaluation

Show a small evaluation result with:

- retrieval hit rate
- citation presence
- fallback correctness
- rule accuracy

### 6. Discuss Architecture

Briefly explain:

- Streamlit for demo
- FastAPI for service layer
- Chroma local for MVP
- pgvector as production alternative
- Ollama Cloud model provider
- LangGraph as explicit workflow engine

## Interview Talking Points

- RAG answers are grounded in retrieved policy chunks.
- Deterministic rules handle compliance-sensitive decisions.
- LangGraph makes routing and state inspectable.
- Evaluation catches regressions before prompt or retriever changes.
- AWS design separates storage, compute, secrets, and observability.
