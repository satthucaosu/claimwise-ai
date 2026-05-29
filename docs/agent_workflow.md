# Agent Workflow

## Goal

The agent should behave like a controlled state machine, not a free-form autonomous agent. LangGraph is used to make routing, state updates, and tool calls explicit and easy to explain in interviews.

## Intent Types

The system should classify user input into:

1. `policy_question`
2. `claim_analysis`
3. `email_draft`
4. `unknown`

Optional later intents:

- `evaluation_request`
- `follow_up_question`
- `feedback`

## Core State

The agent state should include:

- user_input
- intent
- chat_history
- retrieved_contexts
- claim_info
- missing_documents
- draft_email
- final_answer
- confidence
- errors

## Workflow: Policy Question

```text
START
-> classify_intent
-> retrieve_policy_context
-> generate_grounded_answer
-> validate_answer
-> END
```

Expected output:

- answer
- citations
- confidence
- fallback message when context is insufficient

## Workflow: Claim Analysis

```text
START
-> classify_intent
-> extract_claim_info
-> check_missing_documents
-> retrieve_policy_context
-> generate_claim_assessment
-> validate_answer
-> END
```

Expected output:

- structured claim summary
- missing required documents
- manual review flag
- relevant policy citations
- recommended next action

## Workflow: Email Draft

```text
START
-> classify_intent
-> extract_claim_info, if needed
-> check_missing_documents, if needed
-> retrieve_policy_context
-> generate_email_draft
-> validate_answer
-> END
```

Expected output:

- customer-facing email draft
- missing document list
- careful language that avoids approval promises

## Tool Contracts

### retrieve_policy_context

Input:

- user question or claim summary
- optional policy type
- optional metadata filters

Output:

- relevant chunks
- source metadata
- citations

### extract_claim_info

Input:

- free-text claim description

Output:

- structured claim fields
- unknown or missing fields
- extraction confidence

### check_missing_documents

Input:

- claim type
- provided documents
- claim facts

Output:

- missing documents
- manual review flag
- rule explanation

### generate_grounded_answer

Input:

- user question
- retrieved policy context

Output:

- answer grounded in retrieved context
- citations
- confidence

### generate_email_draft

Input:

- claim info
- missing documents
- policy context

Output:

- professional customer email
- no claim approval promise

### validate_answer

Input:

- generated answer
- retrieved context
- citations
- safety flags

Output:

- validated final answer
- errors or fallback if needed

## Routing Rules

- Questions about policy coverage route to policy Q&A.
- Free-text incident descriptions route to claim analysis.
- Requests to write or rewrite a customer message route to email draft.
- Ambiguous requests route to `unknown` and ask for clarification.

## Safety Rules

- Do not guarantee claim acceptance.
- Do not invent policy clauses.
- Do not invent submitted documents.
- If context is insufficient, say so.
- Deterministic rules override LLM guesses.
- High-risk or ambiguous cases should be marked for manual review.
