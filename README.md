# ClaimWise AI

ClaimWise AI is a production-oriented Generative AI assistant for synthetic insurance claim analysis. It combines retrieval-augmented generation, structured claim extraction, deterministic business rules, and a LangGraph-based workflow to help answer policy questions and analyze claim submissions.

## Project Goals 

- Answer insurance policy questions with source-grounded citations 
- Extract structured claim information from free-text descriptions
- Check missing required documents using deterministic rules
- Generate customer-facing email drafts
- Demonstrate RAG, LangChain, LangGraph, evaluation, Docker, and AWS-ready architecture

## Why This Project?

Most simple RAG demos only answer questions over documents. ClaimWise AI goes further by combining:
- RAG for policy understanding
- structured extraction for claim intake
- deterministic rule checks for compliance
- agentic workflow routing
- evaluation and production-aware design

## Core Features

- Policy Q&A with citations
- Claim information extraction
- Missing document checker
- Email draft generation
- LangGraph agent workflow
- Streamlit interface
- FastAPI endpoints
- RAG evaluation report
- Dockerized local setup
- AWS deployment design


## Architecture

User -> Streamlit/FastAPI -> LangGraph Agent -> RAG + Claim Tools -> Final Response

Main nodes: 
- classify_intent
- retrieve_policy_context
- extract_claim_info
- check_missing_documents
- generate_grounded_answer 
- generate_email_draft
- validate_answer

## Tech Stack 

- Python
- LangChain
- LangGraph
- Ollama Cloud model
- Chroma
- FastAPI
- Streamlit
- Pydantic
- RAGAS/custom evaluation 
- Docker

## Data

This project uses synthetic insurance documents covering:
- travel insurance
- car insurance
- home insurance
- claim submission rules
- reimbursement rules
- customer FAQ

## Local Environment Setup

This project uses `uv`, Python 3.11, and a local `.venv` virtual environment.
The repository includes a `.python-version` file so `uv venv` creates the environment with Python 3.11 instead of whichever `python` appears first on your PATH.

Create and activate the environment on Windows PowerShell:

```powershell
uv python pin 3.11
uv venv
.\.venv\Scripts\Activate.ps1
python --version
uv pip install -r requirements.txt
```

Create and activate the environment on macOS/Linux:

```bash
uv python pin 3.11
uv venv
source .venv/bin/activate
python --version
uv pip install -r requirements.txt
```

## Day 1 Design Decisions

- Primary UI: Streamlit
- API: FastAPI
- LLM provider: Ollama Cloud
- Vector store: Chroma local
- Evaluation: start with custom metrics, add RAGAS later
- Agent scope: LangGraph state machine

## Project Workflow

This repository uses Codex guidance files to keep collaboration consistent:

- `.codex/reviewer.md` for code review
- `.codex/testing_reviewer.md` for test review
- `.codex/documentation_reviewer.md` for documentation review
- `.codex/git_commit_assistant.md` for commit planning
- `.codex/project_plan_maintainer.md` for keeping the roadmap and docs aligned with actual progress

After each project day, run a plan sync when the actual work differs from the original roadmap.

## Synthetic Dataset

The initial synthetic dataset lives in `data/raw_docs/` and `data/sample_claims/`.

Raw documents:

- `travel_insurance_policy.md`
- `car_insurance_policy.md`
- `home_insurance_policy.md`
- `claim_submission_guidelines.md`
- `reimbursement_rules.md`
- `customer_faq.md`

Sample claims:

- `travel_delay_covered.json`
- `travel_delay_not_covered.json`
- `lost_baggage_missing_docs.json`
- `car_accident_complete.json`
- `home_water_damage_late.json`
- `ambiguous_manual_review.json`
