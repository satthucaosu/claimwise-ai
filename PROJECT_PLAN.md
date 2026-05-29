# Project Plan

## Goal

Build ClaimWise AI in 14 days as a portfolio-ready Gen AI Engineering project.

The project should demonstrate RAG, LangGraph workflow orchestration, structured claim extraction, deterministic rule checks, evaluation, Docker, and AWS-ready architecture.

## Plan Maintenance

This plan is a living document. After each project day, compare the actual repository changes with this roadmap.

Use `.codex/project_plan_maintainer.md` when the implementation, scope, setup, dependencies, architecture, or schedule differs from the original plan.

The goal is not to preserve the original plan perfectly. The goal is to keep the plan truthful, useful, and aligned with the current project.

## Current Status

Status after Day 1 sync on 2026-05-29:

- Repository scaffold, collaboration rules, planning docs, dependency list, Makefile, `.env.example`, and `.python-version` are in place.
- End-of-day assistant workflow guidance is documented across `AGENTS.md`, `.codex/`, `README.md`, and `docs/codex_daily_workflow.md`.
- Synthetic raw policy documents and sample claim JSON files have been created.
- `evaluation/test_questions.csv` exists as a placeholder, but the evaluation dataset has not been populated yet.
- Implementation modules are still empty scaffolds. RAG ingestion, Chroma indexing, claim extraction, LangGraph workflow, Streamlit UI, FastAPI API, and evaluation runners are planned but not implemented yet.
- Next project task: Day 2 document loading, Markdown chunking, metadata extraction, and a small inspection output.

## Day 1 - Project Setup and Scope

Deliverables:

- Repository initialized
- Collaboration rules documented in `AGENTS.md`
- README skeleton created
- Project structure created
- Synthetic documents created
- Sample claim JSON files created
- Local `.venv` setup instructions documented
- Initial architecture and data design written

Acceptance criteria:

- Project scope is clear.
- Synthetic data is concrete enough for RAG and rule checks.
- Design decisions are recorded.
- README explains `uv venv`, activation, and `uv pip install -r requirements.txt`.

## Day 2 - Document Loading and Chunking

Deliverables:

- Load synthetic Markdown documents
- Split documents into chunks
- Attach metadata
- Save processed chunks for inspection

Acceptance criteria:

- Each chunk has source, document type, policy type, section, and chunk ID.
- Chunking preserves rule lists with their headings.

## Day 3 - Embeddings and Vector Store

Deliverables:

- Build local Chroma vector store
- Embed chunks
- Test similarity search

Acceptance criteria:

- A question about travel delay retrieves travel policy chunks.
- A question about water damage retrieves home policy chunks.

## Day 4 - Basic RAG Q&A

Deliverables:

- Question answering over documents
- Grounded prompt
- Citations
- Fallback when context is insufficient

Acceptance criteria:

- Answers include citations.
- Unsupported questions do not produce confident hallucinations.

## Day 5 - Retrieval Improvements

Deliverables:

- Metadata filtering
- Optional reranking
- Retrieval comparison notes

Acceptance criteria:

- Retrieval behavior can be compared with a small test set.

## Day 6 - Claim Extraction

Deliverables:

- Pydantic claim schema
- Structured claim extraction
- Handling for unknown or missing fields

Acceptance criteria:

- Sample claim descriptions produce structured JSON.
- Missing fields are not guessed.

## Day 7 - Missing Document Checker

Deliverables:

- Deterministic business rules
- Missing document output
- Manual review flags

Acceptance criteria:

- Sample claim expected outcomes are reproduced by tests.

## Day 8 - LangGraph Agent

Deliverables:

- Agent state
- Nodes
- Conditional routing

Acceptance criteria:

- Policy questions, claim analysis, and email draft requests route correctly.

## Day 9 - Memory and Feedback

Deliverables:

- Streamlit session state or lightweight memory
- Feedback logging

Acceptance criteria:

- Follow-up questions can use recent context.
- User feedback is stored locally.

## Day 10 - Streamlit UI

Deliverables:

- Policy Q&A tab
- Claim Analyzer tab
- Email Draft tab
- Evaluation tab

Acceptance criteria:

- Demo can be run from one command.
- UI exposes the main portfolio features.

## Day 11 - RAG Evaluation

Deliverables:

- Populate evaluation dataset
- Custom metrics
- Optional RAGAS experiment
- Evaluation report

Acceptance criteria:

- Evaluation results are saved and explainable.

## Day 12 - API and Docker

Deliverables:

- FastAPI endpoints
- Dockerfile
- docker-compose

Acceptance criteria:

- API health check works.
- Docker build and local run are documented.

## Day 13 - AWS Architecture

Deliverables:

- AWS deployment document
- Architecture diagram
- Production trade-offs

Acceptance criteria:

- Architecture explains S3, ECS, Secrets Manager, CloudWatch, and pgvector.

## Day 14 - Polish

Deliverables:

- Final README
- Screenshots
- Demo script
- Limitations
- CV bullets

Acceptance criteria:

- Project can be explained in a 5-minute interview walkthrough.
- README clearly distinguishes MVP, limitations, and future improvements.
