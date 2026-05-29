# Demo Script

## Demo Goal

Show that ClaimWise AI is more than a chat-with-documents app. The demo should highlight RAG, citations, structured extraction, deterministic rules, LangGraph routing, evaluation, and production awareness.

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

## Demo Flow

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
