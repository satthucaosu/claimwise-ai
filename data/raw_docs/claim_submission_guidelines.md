# Claim Submission Guidelines

Document ID: GUIDE-CLAIMS-001
Applies to: Travel, Car, and Home Insurance Claims
Effective date: 2026-01-01

## How to Submit a Claim

Customers may submit a claim through the ClaimWise portal, mobile application, email intake process, or customer support channel. A claim should be submitted as soon as reasonably possible after the incident.

The claim submission should include a clear description of what happened, when it happened, where it happened, which policy is involved, and what reimbursement or assistance is requested. The customer should upload supporting documents as early as possible to avoid delays.

The assistant may help identify missing information and missing documents, but it must not promise claim approval. Final claim decisions are made by the insurer or an authorized claim handler.

## Required Information

Every claim should include:

- policy number
- claim type
- incident date
- declaration or submission date
- incident location
- customer contact details
- free-text incident description
- claimed amount when reimbursement is requested
- list of submitted documents

If the policy number, incident date, claim type, or incident description is missing, the claim is incomplete and the customer should be asked to provide the missing information.

## Document Upload Rules

Uploaded documents must be readable and relevant to the claim. File names should describe the document type when possible.

Acceptable document examples include:

- PDF invoices
- photos of damage
- scanned reports
- airline or provider confirmations
- police reports
- repair estimates
- receipts

Documents may be rejected or require resubmission when:

- the image is blurry or unreadable
- the document is cropped and key details are missing
- the file appears altered
- the document does not match the incident
- the document language cannot be reviewed without translation

The assistant should ask for clearer copies when submitted documents are unreadable.

## Timelines

Customers should submit claims promptly. Some policies contain specific time limits:

- home water damage should be declared within 5 days of discovery
- travel delay should be submitted after the carrier provides delay confirmation
- car theft and home burglary should be reported to police as soon as possible
- reimbursement receipts should be submitted within 30 days when practical

Late claims may still be considered, but they may require manual review.

## Manual Review Conditions

A claim must be routed to manual review when:

- required information is missing
- required documents are missing after customer follow-up
- documents are inconsistent with the claim description
- submitted documents appear altered
- claimed amount exceeds 2,000 EUR for travel claims
- claimed amount exceeds 5,000 EUR for car claims
- claimed amount exceeds 3,000 EUR for home claims
- injury, liability dispute, fraud indicators, or legal involvement is present
- the coverage rule is ambiguous
- the customer requests an exception

Manual review means the claim should be examined by a human claim handler. It does not mean the claim is rejected.

## Communication Expectations

Customer communication should be clear, neutral, and helpful. The assistant should explain:

- what information was found
- which documents are missing
- why each missing document is needed
- whether manual review may be required
- what the recommended next action is

The assistant should avoid legal conclusions, blame, or definitive approval language. It may say that a claim appears eligible for further review if the policy conditions and required documents are satisfied.

## Data Quality Expectations

Structured claim extraction should preserve uncertainty. If the user does not provide a value, the extracted field should be marked as missing or unknown rather than guessed.

Examples:

- If the customer says "last Friday" without a clear date, ask for the exact incident date.
- If the customer says "my bag disappeared" without mentioning checked baggage, ask whether it was checked baggage or cabin baggage.
- If the customer says "water damage happened recently" without dates, ask for both incident date and discovery date.

## Assistant Safety Rules

The assistant must not:

- invent submitted documents
- invent policy numbers
- invent approval decisions
- guarantee reimbursement
- provide legal advice
- ignore deterministic business rules
- override manual review requirements

The assistant should use source-grounded policy answers when answering policy questions and deterministic rule checks when identifying missing claim documents.
