# Limitations

## Synthetic Data

ClaimWise AI uses synthetic insurance documents and sample claims. It is not trained or tested on real customer data, real policies, or real claim systems.

## Not Legal or Insurance Advice

The assistant can explain policy-like text and identify missing documents, but it cannot provide legal advice, final coverage decisions, or binding claim approvals.

## LLM Reliability

LLMs may hallucinate, omit important caveats, or misunderstand ambiguous claim descriptions. The system reduces this risk with retrieval, citations, validation, and deterministic rules, but it does not eliminate the risk.

## Manual Review Required

High-value, ambiguous, disputed, late, injury-related, or inconsistent claims should be routed to human review.

## Retrieval Limits

The initial vector store uses local Chroma and a small synthetic corpus. Retrieval behavior may not represent production-scale document collections.

## Evaluation Limits

The first evaluation phase uses custom metrics and a small test set. RAGAS or broader human evaluation can be added later for stronger quality signals.

## Deployment Limits

The AWS architecture is documented as deployment-ready design, but the initial MVP is local. A production deployment would need authentication, authorization, audit logging, monitoring, rate limiting, privacy review, and security testing.
