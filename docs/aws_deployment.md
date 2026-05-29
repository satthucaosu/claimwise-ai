# AWS Deployment

## Goal

This document describes an AWS-ready architecture for ClaimWise AI. The MVP does not need to be deployed on AWS during the first build, but the design should be credible enough to discuss in interviews.

## Local MVP

```text
Streamlit or FastAPI
-> LangGraph workflow
-> Chroma local vector store
-> Ollama Cloud model
-> local synthetic documents
```

## AWS-Ready Architecture

```text
User
-> Application Load Balancer
-> ECS Fargate service running FastAPI
-> LangGraph application layer
-> S3 document storage
-> RDS PostgreSQL with pgvector
-> Ollama Cloud or Amazon Bedrock
-> CloudWatch logs and metrics
-> Secrets Manager
```

## AWS Services

### ECS Fargate

Runs the FastAPI container without managing servers. Streamlit can be deployed separately or kept as a local demo interface.

### S3

Stores uploaded policy documents, processed documents, and evaluation artifacts.

### RDS PostgreSQL with pgvector

Production alternative to Chroma. Stores embeddings, chunk metadata, document IDs, and retrieval indexes.

### Secrets Manager

Stores API keys and provider credentials such as `OLLAMA_API_KEY`.

### CloudWatch

Collects logs, latency metrics, error rates, and application health data.

### Bedrock Optional Alternative

Amazon Bedrock can replace Ollama Cloud in a production AWS-native version. This would simplify enterprise governance but may require adapting prompts, structured output handling, and evaluation baselines.

## Deployment Notes

- Keep local Chroma for the MVP.
- Document pgvector as the production vector store.
- Keep secrets outside Docker images.
- Use environment variables for model and vector store configuration.
- Add health checks before deployment.
- Log request IDs, model names, retrieval counts, and validation failures.

## Production Risks

- Synthetic policy documents are not real insurance contracts.
- LLM answers must not be treated as legal or claim approval decisions.
- Human review is required for ambiguous, high-value, or disputed claims.
- Prompt and retrieval changes should be evaluated before deployment.
