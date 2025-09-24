---
title: "Guide: Production Secret Management"
owner: "@manus-ai"
date: "2025-09-24"
status: "draft"
tags: ["security", "secret-management", "production-readiness", "guide"]
sdd_phase: "design"
---

# Guide: Production Secret Management

**Date:** 2025-09-24  
**Status:** Draft

## 1. Introduction

This guide provides the official policy and recommended practices for managing secrets within the HX Data Ingestion Project. The secure handling of sensitive information, such as API keys, database credentials, and other confidential data, is critical for the security and integrity of the system.

This document addresses the security concerns raised in the `2025-09-24--consolidated-audit--report.md` regarding the use of `.env` files and the `HX_DIP_SECRET` environment variable.

## 2. Policy

- **NEVER** commit secrets directly to the Git repository.
- **NEVER** store plaintext secrets in configuration files.
- **ALWAYS** use a dedicated secret management solution for production environments.
- **ALWAYS** follow the principle of least privilege when granting access to secrets.

## 3. Secret Management in Development

For local development, it is acceptable to use `.env` files to store secrets. The `prototype/crawl4ai/.env.example` file provides a template for the required environment variables.

To use this file:

1.  Make a copy of `.env.example` and name it `.env`.
2.  Fill in the required values for the environment variables.
3.  Ensure that `.env` is listed in the `.gitignore` file to prevent it from being committed to the repository.

**Example `.env.example`:**

```
# Secret Management Guidance:
# This file is a template for development purposes only.
# DO NOT use this method for production environments.
# For production, use a dedicated secret management solution like HashiCorp Vault or AWS Secrets Manager.

# OpenAI API Key
OPENAI_API_KEY="your_openai_api_key_here"

# Example of the project-specific secret mentioned in the audit
HX_DIP_SECRET="your_project_secret_here"
```

## 4. Secret Management in Production

For production environments, a dedicated secret management solution is **mandatory**. The use of `.env` files in production is strictly prohibited.

The V2 architecture, as defined in `ADR-0002`, will incorporate a centralized secret management solution, such as:

*   **HashiCorp Vault**
*   **AWS Secrets Manager**
*   **Google Cloud Secret Manager**
*   **Azure Key Vault**

The choice of a specific solution will be determined during the V2 Design phase. The system will be designed to integrate with the chosen secret manager to dynamically fetch secrets at runtime.

## 5. The `HX_DIP_SECRET` Variable

The `HX_DIP_SECRET` variable, identified in the audit, should be treated with the same level of security as any other secret. It should be managed through the production secret management solution and injected into the application environment at runtime.

