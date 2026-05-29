# ClaimWise AI

ClaimWise AI is a production-aware Generative AI assistant for synthetic insurance claim analysis. It combines retrieval-augmented generation, structured claim extraction, deterministic business rules, and a LangGraph-based workflow to help answer policy questions and analyze claim submissions.

## Project Goals 

- Answer insurance policy questions with source-grounded citations 
- Extract structured claim information from free-text descriptions
- Check missing required documents using deterministic rules
- Generate customer-facing email drafts
- Demonstrate RAG, LangChain, LangGraph, evaluation, Docker, and AWS-ready architecture

## Current Status

This repository is currently at the end of Day 1:

- Project scaffold, planning docs, dependency list, and environment templates are in place.
- Synthetic policy documents and sample claim JSON files are available under `data/`.
- Implementation modules are still placeholders. RAG, claim extraction, LangGraph, Streamlit, FastAPI, and evaluation runners are planned next steps, not working features yet.

### What Works Today

- The project structure is initialized.
- The Python version is pinned to 3.11 in `.python-version`.
- Dependencies are listed in `requirements.txt`.
- Environment variables are documented in `.env.example`.
- Synthetic source documents and sample claims are ready for the ingestion pipeline.

### Planned Next

- Day 2: load Markdown documents, split them into chunks, attach metadata, and save an inspection output.
- Day 3: embed chunks and build a local Chroma vector store.
- Day 4: add basic RAG Q&A with citations.

### Not Runnable Yet

The Streamlit app, FastAPI service, LangGraph workflow, RAG pipeline, and evaluation runner are not implemented yet. Commands such as `make run-ui`, `make run-api`, and `make eval` are planned interfaces for later project days and are not expected to work at the end of Day 1.

## Why This Project?

Most simple RAG demos only answer questions over documents. ClaimWise AI goes further by combining:
- RAG for policy understanding
- structured extraction for claim intake
- deterministic rule checks for compliance
- agentic workflow routing
- evaluation and production-aware design

## Planned Core Features

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

## Portfolio Skill Map

| Skill | Planned Project Evidence |
| --- | --- |
| RAG pipeline | Document chunking, Chroma retrieval, grounded answers, citations |
| LangChain | Retriever and LLM orchestration utilities |
| LangGraph | Explicit state machine for policy Q&A, claim analysis, and email drafting |
| Structured extraction | Pydantic claim schema and LLM-assisted claim intake |
| Deterministic tools | Missing document checker and manual review rules |
| Evaluation | Custom retrieval, citation, fallback, and rule accuracy metrics |
| Product UI | Streamlit demo for policy Q&A, claim analysis, email drafting, and evaluation |
| Service layer | FastAPI endpoints that reuse the same project services |
| Deployment design | Docker and AWS-ready architecture notes |


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

## Repository Structure

```text
claimwise-ai/
|-- data/
|   |-- raw_docs/          # Synthetic policy, FAQ, and guideline documents
|   `-- sample_claims/     # Synthetic claim examples with expected outcomes
|-- docs/                  # Architecture, data, evaluation, demo, and deployment notes
|-- app/                   # Future Streamlit and FastAPI entrypoints
|-- evaluation/            # Evaluation datasets and future result outputs
|-- src/                   # Placeholder Python packages for implementation modules
|   |-- agent/
|   |-- evaluation/
|   |-- ingestion/
|   |-- rag/
|   `-- utils/
|-- tests/                 # Future pytest coverage
|-- .env.example           # Local environment variable template
|-- .python-version        # Python 3.11 pin
|-- Makefile               # Planned local workflow commands
|-- PROJECT_PLAN.md        # 14-day project roadmap
|-- README.md
`-- requirements.txt
```

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

Copy the environment template and fill in your local values:

```powershell
Copy-Item .env.example .env
```

On macOS/Linux:

```bash
cp .env.example .env
```

Do not commit `.env`.

## Useful Commands

At the end of Day 1, only setup and static inspection are expected to work:

```powershell
python --version
uv pip install -r requirements.txt
```

Planned commands for later days:

```powershell
make run-ui    # planned for the Streamlit app
make run-api   # planned for the FastAPI service
make eval      # planned for the evaluation runner
pytest         # useful once tests are added
```

## Example Questions

These are target demo questions for the future RAG and claim-analysis flows:

- Is a 5-hour travel delay covered?
- What documents are required for lost baggage?
- What happens if home water damage is declared after 5 days?
- What documents are needed for a car accident claim?
- Can ClaimWise approve my claim automatically?

## Evaluation Status

Evaluation results are not available yet. The evaluation dataset, custom metrics, and saved reports are planned for Day 11.

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

Recommended end-of-day assistant order:

1. Project Plan Maintainer
2. Documentation Reviewer
3. Testing Reviewer
4. Code Reviewer, only if implementation code changed
5. Git Commit Assistant

## Supporting Documentation

- `PROJECT_PLAN.md` - 14-day roadmap and current project status
- `docs/architecture.md` - intended MVP architecture and production direction
- `docs/data_design.md` - synthetic data, metadata, chunking, and rule design
- `docs/agent_workflow.md` - planned LangGraph state machine and tool contracts
- `docs/evaluation_plan.md` - custom evaluation approach and future RAGAS option
- `docs/limitations.md` - project limitations and safety caveats
- `docs/aws_deployment.md` - AWS-ready deployment architecture
- `docs/demo_script.md` - target finished-MVP demo flow
- `docs/codex_daily_workflow.md` - recommended workflow for using Codex while learning

## Limitations

- The project currently uses only synthetic documents and claims.
- The Day 1 repository is a scaffold, not a working assistant.
- The assistant must not provide legal advice, binding coverage decisions, or final claim approvals.
- The local MVP will use a small Chroma vector store, which does not represent production-scale retrieval.
- Evaluation starts with small custom metrics; broader human evaluation or RAGAS is planned later.

## Future Improvements

- Add richer synthetic claims with edge cases and conflicting information.
- Add reranking and compare retrieval quality against baseline Chroma search.
- Add RAGAS or another automated evaluation layer after custom metrics are stable.
- Add Docker Compose for local Streamlit, FastAPI, and Chroma workflows.
- Expand AWS design with authentication, audit logging, monitoring, and cost notes.

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
