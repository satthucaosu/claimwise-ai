# Data Design

## Dataset Purpose

The project uses synthetic insurance documents so the RAG pipeline can be developed and evaluated without real customer data. The documents are designed to include concrete rules, required documents, exclusions, and manual review triggers.

## Raw Policy Documents

The raw Markdown documents live in `data/raw_docs/`.

Required documents:

1. `travel_insurance_policy.md`
2. `car_insurance_policy.md`
3. `home_insurance_policy.md`
4. `claim_submission_guidelines.md`
5. `reimbursement_rules.md`
6. `customer_faq.md`

## Sample Claims

Sample JSON claims live in `data/sample_claims/`.

Initial examples:

- `travel_delay_covered.json`
- `travel_delay_not_covered.json`
- `lost_baggage_missing_docs.json`
- `car_accident_complete.json`
- `home_water_damage_late.json`
- `ambiguous_manual_review.json`

Each sample claim should include:

- claim_id
- policy_number
- claim_type
- description
- incident_date
- submission_date
- incident_location
- submitted_documents
- claimed_amount
- currency
- expected_outcome

## Sample Claim Schema

The first implementation can keep the schema simple and readable:

| Field | Type | Notes |
| --- | --- | --- |
| claim_id | string | Stable sample identifier |
| policy_number | string | Synthetic policy number |
| claim_type | string | Example values: `travel_delay`, `lost_baggage`, `car_accident`, `home_water_damage` |
| description | string | Free-text claim description used for extraction |
| incident_date | string | ISO date, or unknown when the claimant does not provide it |
| submission_date | string | ISO date, or unknown when not provided |
| incident_location | string | City, airport, road, home, or unknown |
| submitted_documents | list[string] | Documents the claimant already provided |
| claimed_amount | number | Claimed amount when known |
| currency | string | Example: `EUR`, `USD`, `GBP` |
| expected_outcome | object | Test oracle for rules and manual review |

Suggested `expected_outcome` shape:

```json
{
  "coverage_signal": "covered | not_covered | needs_review",
  "missing_documents": ["document name"],
  "manual_review_required": true,
  "reason_codes": ["short_machine_readable_reason"],
  "notes": "Human-readable explanation for tests and demo."
}
```

This field is not the assistant's final answer. It is a small test oracle so deterministic rules and evaluation checks can compare actual behavior against an expected result.

## Policy Rules

### Travel Insurance

- Travel delay is covered only if delay is greater than 6 hours.
- Meals and refreshments for covered travel delays are capped at 50 EUR per day.
- Lost baggage reimbursement is capped at 1,500 EUR.
- Lost baggage requires baggage tag, airline irregularity report, and final airline confirmation of loss.
- High-value baggage items without receipts should trigger manual review.

### Car Insurance

- Car accident claims require accident report, damage photos, repair invoice or estimate, driver's license, and vehicle registration.
- Theft and vandalism require a police report.
- Injury, disputed liability, or unauthorized drivers require manual review.
- Intentional damage and illegal driving are excluded.

### Home Insurance

- Water damage must be declared within 5 days of discovery.
- Water damage requires photos, damage report, repair invoice or estimate, incident date, and declaration date.
- Gradual leakage and poor maintenance are excluded.
- Emergency repair before adjuster review is capped at 500 EUR.

## Metadata Schema

Each document chunk should include:

- source: original filename
- document_type: policy, guideline, reimbursement_rules, faq
- policy_type: travel, car, home, general
- section: Markdown heading or section name
- chunk_id: stable unique chunk identifier
- text: chunk content

Optional metadata:

- effective_date
- product_name
- rule_type
- created_at

## Chunking Guidance

Start with section-aware chunking for Markdown:

- split by headings first
- keep section titles with chunk text
- target medium chunks, roughly 500 to 900 tokens
- avoid splitting rule lists away from their headings
- preserve source filename and section metadata

## Evaluation Data Ideas

Create test questions that verify:

- exact rule retrieval
- citations from the right document
- fallback for unsupported questions
- claim rule checks
- manual review triggers

Example questions:

- Is a 5-hour travel delay covered?
- What documents are required for lost baggage?
- What happens if home water damage is declared late?
- Can the assistant approve my claim?
- What documents are needed for a car accident?
