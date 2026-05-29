# Evaluation Plan

## Goal

Evaluate whether ClaimWise AI retrieves the right context, answers with citations, applies deterministic rules correctly, and falls back when it lacks enough information.

## Evaluation Scope

Start with custom metrics. Add RAGAS later if time allows.

## Evaluation Inputs

Create an evaluation CSV under `evaluation/test_questions.csv` with columns such as:

- question
- expected_answer_points
- expected_sources
- expected_policy_type
- should_fallback

For claim tests, use the JSON files under `data/sample_claims/`.

## Local Evaluation Setup

Run evaluation commands from an activated `.venv`.
The project expects Python 3.11 from the root `.python-version` file. If `.venv` was created with another Python version, recreate it before running evaluations.

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

Evaluation output should be written under `evaluation/results/`, which is ignored by git.

## MVP Metrics

### Retrieval Hit Rate

Checks whether the expected source document appears in the top retrieved chunks.

### Citation Presence

Checks whether final answers include at least one citation when answering policy questions.

### Groundedness Heuristic

Checks whether the answer uses information found in retrieved context and avoids unsupported approval claims.

### Fallback Correctness

Checks whether the assistant says it cannot answer confidently when the retrieved context is insufficient.

### Rule Accuracy

Checks whether deterministic claim rules return the expected missing documents and manual review flags.

## Example Test Cases

- Is a 5-hour travel delay covered?
- What documents are required for lost baggage?
- What documents are required for a car accident?
- What happens if home water damage is declared after 5 days?
- Can ClaimWise approve my claim automatically?

## Later RAGAS Metrics

If time allows, add RAGAS metrics such as:

- faithfulness
- answer relevancy
- context precision
- context recall

## Acceptance Criteria

- Test questions run from one command.
- Results are saved under `evaluation/results/`.
- Failures are understandable.
- Evaluation can be explained clearly in the README and demo.
