# Daily Workflow With Codex

## Purpose

This document defines a repeatable working process for using Codex on ClaimWise AI. The goal is to help you learn while building, keep the project focused, and avoid letting the coding agent take over the implementation unless you explicitly want that.

## Core Principle

You write most of the implementation code.

Codex should act as:

- technical mentor
- architecture reviewer
- debugging partner
- code reviewer
- documentation assistant
- project manager for the 14-day roadmap

Codex should write implementation code only when you explicitly ask for exact code.

## Start-of-Day Routine

At the beginning of each project day, tell Codex:

- the day number
- the feature you want to work on
- whether you want guidance, review, debugging, or implementation
- the files involved, if known
- whether your `.venv` is already created and active, if commands need to be run

Example:

```text
Day 3. I am working on embeddings and Chroma.
Please explain the implementation steps and acceptance criteria.
Do not write code yet.
```

Codex should respond with:

- objective of the day
- expected deliverables
- checklist
- design decisions
- acceptance criteria
- common mistakes
- suggested tests
- end-of-day review checklist

## Environment Setup Routine

Use this once at the beginning of local development, and repeat the activation step whenever you open a new terminal.

The project should use Python 3.11. The `.python-version` file at the repository root tells `uv` which Python version to use when creating `.venv`.

Windows PowerShell:

```powershell
uv python pin 3.11
uv venv
.\.venv\Scripts\Activate.ps1
python --version
uv pip install -r requirements.txt
Copy-Item .env.example .env
```

macOS/Linux:

```bash
uv python pin 3.11
uv venv
source .venv/bin/activate
python --version
uv pip install -r requirements.txt
cp .env.example .env
```

If `.venv` was created with Python 3.14 or another wrong version, remove it first, then run the setup again:

```powershell
Remove-Item -Recurse -Force .venv
uv venv
```

After copying `.env.example`, fill in your local `OLLAMA_API_KEY` and model settings. Do not commit `.env`.

## Recommended Work Loop

Use this loop for each feature:

1. Ask Codex for the objective and plan.
2. Write the first version yourself.
3. Ask Codex to review the design or code.
4. Fix issues yourself where possible.
5. Ask Codex for debugging help if blocked.
6. Add or update tests.
7. Ask Codex to review portfolio readiness.
8. Update docs if the feature changes architecture or usage.
9. Ask Codex to run a plan sync if the actual work differs from the original roadmap.

## Prompt Types To Use

### Planning Prompt

Use when starting a task.

```text
I am starting Day X: <feature>.
Give me the objective, deliverables, checklist, design decisions, acceptance criteria, common mistakes, and tests.
Do not write implementation code.
```

### Architecture Prompt

Use before writing a complex feature.

```text
Please review this architecture idea for <feature>.
Compare trade-offs and recommend the simplest MVP approach.
Do not write code.
```

### Code Review Prompt

Use after you write code.

```text
Please review <files>.
Use .codex/reviewer.md.
Do not modify files.
```

### Debugging Prompt

Use when something breaks.

```text
I am getting this error: <paste error>.
The command was: <command>.
The relevant files are: <files>.
Help me identify the likely cause and smallest fix.
Do not rewrite everything.
```

### Testing Review Prompt

Use before calling a feature done.

```text
Please review my tests for <feature>.
Use .codex/testing_reviewer.md.
Tell me missing coverage and the top 3 tests to add.
Do not write test code.
```

### Documentation Review Prompt

Use after changing architecture or behavior.

```text
Please review the docs for <feature>.
Use .codex/documentation_reviewer.md.
Tell me what is missing or unclear.
```

### Plan Maintenance Prompt

Use after a day or feature changes the roadmap, scope, setup, architecture, dependencies, or demo path.

```text
Please act as my Project Plan Maintainer.
Use .codex/project_plan_maintainer.md.
Compare today's actual changes with the original plan and update related docs if needed.
Do not modify implementation code.
```

### Implementation Prompt

Use only when you want Codex to write code.

```text
Please implement <file or function>.
Use the existing project style.
Keep it simple and add basic tests if appropriate.
```

## Daily End-of-Day Routine

Before ending each day, ask Codex:

```text
Please do an end-of-day review for Day X.
Check deliverables, gaps, tests, docs, and next steps.
Do not write code unless I ask.
```

Codex should check:

- whether the day objective was met
- whether acceptance criteria are satisfied
- whether tests or manual checks exist
- whether docs need updates
- whether scope is creeping
- what to do first tomorrow

If the day changed the original plan, also ask:

```text
Please act as my Project Plan Maintainer.
Use .codex/project_plan_maintainer.md.
Update all related planning and documentation files so they match the actual project state.
```

## When To Let Codex Write Code

It is reasonable to ask Codex for exact code when:

- you are stuck after trying a fix
- boilerplate is blocking progress
- you need a clean reference implementation
- the task is not the main learning objective
- you want to compare your version with a suggested version

Even then, ask Codex to explain assumptions and verification steps.

## When To Avoid Exact Code

Prefer guidance instead of exact code when:

- you are learning a new concept
- the feature is central to your interview story
- you want to practice implementation
- the design is not yet clear
- you have not written a first attempt

## File-Specific Guidance

Use `.codex/reviewer.md` for code review.

Use `.codex/testing_reviewer.md` for test strategy.

Use `.codex/documentation_reviewer.md` for README and docs review.

Use `.codex/git_commit_assistant.md` before committing.

Use `.codex/project_plan_maintainer.md` after each day when the actual work differs from the original roadmap.

Use `AGENTS.md` as the overall project collaboration contract.

## Consistency Rules

- Keep requests small and specific.
- Include file paths whenever possible.
- Paste the exact error message when debugging.
- Ask for trade-offs before adding complexity.
- Ask for tests before considering a feature complete.
- Keep deterministic business rules outside the LLM.
- Update docs when architecture or commands change.
- Keep `PROJECT_PLAN.md` aligned with actual progress after each day.
- Do not commit secrets, `.env`, vector stores, or large generated outputs.

## Good Daily Outcome

A good day ends with:

- one focused feature or project layer improved
- a short review of what works
- known gaps written down
- at least one verification step
- docs updated if behavior changed
- tomorrow's first task clear
