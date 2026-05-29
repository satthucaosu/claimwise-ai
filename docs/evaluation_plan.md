# Evaluation Plan

## Goal

Evaluate whether ClaimWise AI retrieves the right context, answers with citations, applies deterministic rules correctly, and falls back when it lacks enough information.

## Evaluation Scope

Start with custom metrics. Add RAGAS later if time allows.

Current status: `evaluation/test_questions.csv` exists as a placeholder, but it has not been populated yet. Evaluation runners and saved reports are still future work.

## Evaluation Inputs

Populate the evaluation CSV under `evaluation/test_questions.csv` with columns such as:

- question
- expected_answer_points
- expected_sources
- expected_policy_type
- should_fallback

For claim tests, use the JSON files under `data/sample_claims/`.

Recommended CSV schema:

| Column | Type | Purpose |
| --- | --- | --- |
| id | string | Stable test case ID |
| question | string | User question to send to the RAG pipeline |
| expected_answer_points | string | Semicolon-separated facts the answer should include |
| expected_sources | string | Semicolon-separated source filenames expected in retrieved context or citations |
| expected_policy_type | string | `travel`, `car`, `home`, or `general` |
| should_fallback | boolean | Whether the assistant should refuse or ask for more context |
| notes | string | Optional reason this case exists |

Example row:

```csv
id,question,expected_answer_points,expected_sources,expected_policy_type,should_fallback,notes
travel_delay_5h,"Is a 5-hour travel delay covered?","delay must be greater than 6 hours;5 hours is not covered",travel_insurance_policy.md,travel,false,"Exact rule retrieval"
```

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

Evaluation output should be written under `evaluation/results/`, which is ignored by git. The current `make eval` command is a planned interface and should be wired up when the evaluation module exists.

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

## MVP Pass Criteria

Initial thresholds should be modest because the corpus is small and synthetic:

| Metric | Target |
| --- | --- |
| Retrieval hit rate | At least 80% of test questions include an expected source in the top retrieved chunks |
| Citation presence | 100% of answered policy questions include at least one citation |
| Fallback correctness | 100% of unsupported questions trigger a fallback instead of a confident answer |
| Rule accuracy | 100% of sample claims match expected missing documents and manual review flags |
| Failure explainability | Every failed case includes the question or claim ID, expected value, and actual value |

These thresholds can become stricter after the first working RAG pipeline exists.

## Result Format

Save evaluation outputs under `evaluation/results/` with a timestamped filename such as:

```text
evaluation/results/rag_eval_YYYYMMDD_HHMM.json
```

Suggested result shape:

```json
{
  "run_id": "rag_eval_YYYYMMDD_HHMM",
  "retrieval_hit_rate": 0.8,
  "citation_presence_rate": 1.0,
  "fallback_correctness_rate": 1.0,
  "rule_accuracy": 1.0,
  "failures": [
    {
      "id": "case_id",
      "metric": "retrieval_hit_rate",
      "expected": "travel_insurance_policy.md",
      "actual": ["customer_faq.md"]
    }
  ]
}
```

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

## Future Acceptance Criteria

- Test questions run from one command.
- Results are saved under `evaluation/results/`.
- Failures are understandable.
- Evaluation can be explained clearly in the README and demo.
