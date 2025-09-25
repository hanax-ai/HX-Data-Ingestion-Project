---
title: "Citadel Workshop: Stakeholder Requirements & Vision"
date: "2025-09-25"
source: "Product Owner & Key Stakeholders Workshop"
type: "requirements-capture"
phase: "explore"
---

# Citadel Workshop: Stakeholder Requirements & Vision

**Document Purpose:** Capture of stakeholder workshop outputs defining Citadel's product vision, technical requirements, and architectural direction for V2 development.

**Workshop Participants:** Product Owner and Key Stakeholders  
**Workshop Date:** 2025-09-24  
**Document Status:** Requirements captured for Explore phase deliverable population

## 1. Product Vision & Positioning

### **Core Problem Statement**
Foundational LLMs suffer from knowledge limitations that restrict their enterprise applicability. Their knowledge is often too general, quickly becomes outdated, and lacks domain-specific expertise. This creates a critical gap for organizations needing AI systems that can leverage current, specialized information.

### **Solution Approach**
**Citadel** addresses this challenge through intelligent data acquisition and retrieval-augmented generation (RAG). The system enables organizations to supply curated external knowledge to LLMs, transforming them into domain experts with access to current, relevant information.

### **Product Definition**
Citadel is an intelligent data acquisition and RAG system designed to collect, organize, and make data from diverse sources easily searchable. The system bridges the gap between static LLM knowledge and dynamic enterprise information needs.

## 2. Current Capabilities (V1 Prototype)

### **Core Functional Capabilities**
The existing prototype demonstrates strong foundational capabilities that validate the core approach and provide a solid base for V2 development.

**Data Acquisition Features:**
- **Flexible Documentation Crawling:** Supports websites, plain text/Markdown pages (including llms.txt format), and XML sitemaps
- **Parallel and Recursive Crawling:** Efficiently processes large document collections using memory-adaptive batching for optimal resource utilization
- **Smart Content Chunking:** Implements hierarchical Markdown chunking based on header structure, ensuring optimal chunk sizes for vector search operations

**Data Processing & Storage:**
- **Vector Database Integration:** Utilizes ChromaDB for storing document chunks and associated metadata with fast semantic retrieval capabilities
- **Semantic Search Infrastructure:** Enables efficient similarity-based document retrieval through vector embeddings

**User Interface:**
- **Streamlit RAG Interface:** Provides web-based querying capabilities with LLM-powered semantic search functionality
- **Extensible Architecture:** Modular script design supports different crawling and RAG workflows

### **Technical Architecture Foundation**
The V1 prototype establishes several architectural patterns that will inform V2 development:
- **Async-First Design:** Modern asynchronous architecture optimized for I/O-bound operations
- **AI-Native Approach:** Flexible multi-LLM RAG pipeline with pluggable components
- **Modular Component Structure:** Clear separation between acquisition, processing, and retrieval layers

## 3. V2 Vision & Requirements

### **User Experience Transformation**
V2 introduces significant user experience improvements that make Citadel accessible to both technical and non-technical users.

**Graphical User Interface:**
- **Direct Data Acquisition Initiation:** Users can trigger data acquisition processes directly through the UI, eliminating command-line dependencies
- **Named Collections:** Users specify vector collection names and descriptions during ingestion (e.g., collection: "MZ-10K", description: "Mazda Motors 10-K reports for the past 10 years")
- **Provenance in Responses:** System includes source references, timestamps, and collection relationships in all responses for full transparency

**Progress Monitoring & Feedback:**
- **Real-Time Progress Indicators:** Live status displays with progress bars during data acquisition operations
- **Comprehensive Status Updates:** Real-time feedback showing fetching, vectorizing, and analysis stages
- **Automated Reporting:** End-of-acquisition summaries including pages crawled, time elapsed, and success rates

**Terminology & Workflow Alignment:**
- **Consistent Terminology:** Replace "crawl type" references with "data acquisition type" throughout product and documentation
- **Guided User Workflows:** Step-by-step interface guiding users through: select acquisition type → set parameters → name collection → launch acquisition → monitor progress → review summary

### **Enhanced Data Acquisition Capabilities**
V2 expands data acquisition options with configurable parameters and specialized agents.

**Acquisition Methods:**
- **Multiple Ingestion Types:** Sitemap processing, recursive web crawling, file-based ingestion, local directory processing
- **Data Acquisition Agents:** Specialized agents optimized for different acquisition types with sensible defaults and tunable parameters

**Configurable Parameters:**
- **Chunk Size Control:** Adjustable content segment sizes optimized for retrieval performance
- **Batch Size Optimization:** Configurable processing batch sizes balancing speed and resource efficiency
- **Search Depth Configuration:** Definable exploration depth (1-6 layers) for recursive site crawling

**Transparency & Validation:**
- **End-to-End Pipeline Visibility:** Complete transparency across ingestion pipeline for accuracy and performance validation
- **Quality Assurance Integration:** Built-in validation and reliability checks throughout the acquisition process

## 4. Future Roadmap & Multi-Modal Expansion

### **Data Source Expansion**
Future iterations will extend Citadel's capabilities to support comprehensive enterprise data ecosystems.

**Additional Data Types:**
- **Structured Data Sources:** SQL databases, Excel spreadsheets, CSV files
- **Document Formats:** PDF processing, Word documents, presentation files
- **Media Content:** Image analysis, audio transcripts, video content processing
- **Real-Time Sources:** API integrations, streaming data feeds

**Continuous Update Pipeline:**
- **Automated Refresh Mechanisms:** Regular data source updates ensuring current information availability
- **Evergreen Knowledge Pipeline:** Automated systems maintaining up-to-date information without manual intervention

### **Advanced User Interface Features**
Long-term vision includes sophisticated interaction patterns and personalization capabilities.

**Conversational Interfaces:**
- **Context-Aware Interactions:** Multi-turn dialogue capabilities with conversation memory
- **Natural Language Configuration:** Plain language parameter setting replacing technical controls
- **Intelligent Suggestions:** Context-aware query suggestions and refinement recommendations

**Visualization & Analytics:**
- **Data Relationship Graphs:** Visual representation of content relationships and provenance
- **Confidence Indicators:** Response confidence scoring and uncertainty communication
- **Usage Analytics:** Query patterns, collection utilization, and system performance insights

**Personalization Features:**
- **Workspace Customization:** Saved queries, favorite collections, personalized dashboards
- **Role-Based Interfaces:** Tailored experiences for business users, analysts, and developers
- **Notification Systems:** Alerts for new data ingestion, system updates, and relevant content

## 5. Target Architecture & Technology Stack

### **Infrastructure Alignment**
V2 architecture aligns with HX-Infrastructure standards while maintaining flexibility for future evolution.

**Core Technology Migrations:**
| **Component** | **V1 (As-Is)** | **V2 (To-Be)** | **Rationale** |
|---------------|-----------------|-----------------|---------------|
| Vector Database | ChromaDB | Qdrant | Production scalability, distributed architecture |
| LLM Client | OpenAI/Anthropic mix | LiteLLM | Unified interface, multi-provider support |
| Web UI | Streamlit | Open Web-UI | Enhanced user experience, production-ready |
| Python Runtime | Python 3.11+ | Python 3.12 | Latest features, performance improvements |
| Hosting | Local Machine | Orchestration Server | Production deployment, scalability |

### **Service Architecture**
V2 implements a distributed service architecture with clear boundaries and responsibilities.

**Core Services:**
- **hx-orchestrator-server:** Central hub for AI logic and data processing
- **hx-llm01-server & hx-llm02-server:** Dedicated LLM inference services providing gpt-oss:20b and phi3:3.8b models
- **hx-postgres-server:** Data persistence and caching via PostgreSQL and Redis

**Service Boundaries:**
- **Acquisition Service:** Data ingestion and processing operations
- **Indexing Service:** Vector embedding and database operations  
- **Retrieval Service:** Query processing and response generation
- **UI Service:** User interface and interaction management

### **Integration Framework**
V2 incorporates enterprise-grade integration capabilities for authentication, real-time communication, and event processing.

**Authentication & Security (Clerk v5.77.0):**
- **Enterprise SSO:** SAML, OIDC, and multi-factor authentication support
- **Role-Based Access Control:** Admin, Analyst, Developer roles with collection-level permissions
- **Compliance Features:** Audit logging, robots.txt enforcement, domain allow/deny lists

**Real-Time Communication (LiveKit):**
- **Collaborative Features:** Co-monitoring of acquisition runs, joint troubleshooting
- **Voice Integration:** Voice-driven search and query capabilities
- **Data Synchronization:** Real-time UI updates and collaborative annotation

**Event-Driven Architecture (AG-UI Integration):**
- **Real-Time Feedback:** Streaming progress updates during acquisition operations
- **Provenance Tracking:** Structured events carrying origin metadata and source relationships
- **Interoperability:** Standardized event contracts supporting multiple front-end applications

## 6. Agent-Based Processing Architecture

### **Pydantic-AI Agent Framework**
V2 leverages agent-based processing patterns for specialized data acquisition tasks.

**Agent Specializations:**
- **Single Page Agent:** Basic webpage crawling with markdown conversion
- **Sequential Sitemap Agent:** Resource-efficient sequential processing for large sitemaps
- **Parallel Sitemap Agent:** High-throughput parallel processing with memory-adaptive dispatching
- **Content Chunking Agent:** Semantic content segmentation based on document structure
- **Recursive Exploration Agent:** Autonomous site discovery with configurable depth limits

**Agent Capabilities:**
- **Tool-Based Architecture:** Reusable components with clear interfaces and documentation
- **Natural Language Interfaces:** Agents respond to plain language instructions and parameter specification
- **Error Handling & Resilience:** Robust error handling with graceful degradation and retry mechanisms

### **Processing Workflows**
Agents implement sophisticated processing workflows optimized for different use cases.

**Acquisition Flow:**
1. **User Initiation:** Natural language specification of acquisition requirements
2. **Agent Selection:** Automatic selection of appropriate agent based on source type and parameters
3. **Processing Execution:** Agent-specific crawling, parsing, and chunking operations
4. **Vector Storage:** Embedding generation and database insertion with metadata preservation
5. **Progress Reporting:** Real-time status updates and completion summaries

**Retrieval Flow:**
1. **Query Processing:** Natural language query interpretation and parameter extraction
2. **Vector Search:** Semantic similarity search with metadata filtering
3. **Context Assembly:** Relevant chunk retrieval and context preparation
4. **Response Generation:** LLM-powered answer generation with source attribution
5. **Provenance Delivery:** Complete source tracking and confidence scoring

## 7. Non-Functional Requirements

### **Performance Targets**
V2 establishes specific performance benchmarks for production deployment.

**Latency Requirements:**
- **Retrieval Operations:** P95 ≤ 2.0 seconds (excluding token streaming)
- **Progress Events:** ≤ 500ms end-to-end latency for acquisition status updates
- **UI Responsiveness:** Real-time updates with minimal perceived delay

**Throughput Capabilities:**
- **Concurrent Acquisitions:** Support ≥ 10 simultaneous data acquisition operations
- **Query Processing:** ≥ 200 RPS retrieval queries per cluster (read-heavy workload)
- **Scalability:** Horizontal scaling support for both acquisition and retrieval services

### **Availability & Reliability**
Production deployment requires enterprise-grade availability and reliability characteristics.

**Service Level Objectives:**
- **Core APIs:** ≥ 99.9% availability
- **Event Bus:** ≥ 99.95% availability for real-time communication
- **Data Consistency:** Strong consistency for metadata, eventual consistency for vector data

**Operational Requirements:**
- **Observability:** Structured logging, metrics collection, distributed tracing
- **Monitoring:** Per-stage dashboards, SLO burn rate alerting
- **Recovery:** Automated failover, backup strategies, disaster recovery procedures

### **Security & Compliance**
V2 implements comprehensive security controls aligned with enterprise requirements.

**Authentication & Authorization:**
- **Multi-Factor Authentication:** Required for all user accounts
- **Token-Based API Access:** Tenant-scoped JWT tokens with time-based expiration
- **Collection-Level RBAC:** Fine-grained permissions with audit trail

**Data Protection:**
- **Encryption:** Data at rest and in transit protection
- **PII Handling:** Configurable redaction policies and consent management
- **Retention Policies:** Automated data lifecycle management with compliance controls

## 8. Implementation Considerations

### **Migration Strategy**
V2 development follows an incremental migration approach preserving existing capabilities while introducing new features.

**Phase 1: Foundation**
- **Core Infrastructure:** Establish orchestration server and service boundaries
- **Authentication Integration:** Implement Clerk-based identity management
- **Basic UI Migration:** Transition from Streamlit to Open Web-UI foundation

**Phase 2: Enhanced Capabilities**
- **Agent Framework:** Deploy pydantic-ai based processing agents
- **Real-Time Events:** Implement AG-UI event streaming architecture
- **Advanced UI Features:** Progress monitoring, collection management, provenance display

**Phase 3: Production Hardening**
- **Performance Optimization:** Implement caching, connection pooling, resource management
- **Security Hardening:** Complete security framework implementation
- **Operational Tooling:** Monitoring, alerting, backup, and recovery systems

### **Quality Assurance**
V2 development incorporates comprehensive quality assurance practices throughout the development lifecycle.

**Testing Strategy:**
- **Unit Testing:** Component-level testing with high coverage requirements
- **Integration Testing:** Service boundary and API contract validation
- **Performance Testing:** Load testing and scalability validation
- **Security Testing:** Vulnerability assessment and penetration testing

**Production Readiness:**
- **Retry & Backoff:** Resilient error handling with exponential backoff
- **Configuration Management:** 12-factor app principles with secure secrets management
- **Observability Integration:** Comprehensive metrics, logging, and tracing
- **Guardrails:** Rate limiting, domain restrictions, resource quotas

## 9. Success Metrics & Validation

### **User Experience Metrics**
V2 success will be measured through quantifiable user experience improvements.

**Usability Indicators:**
- **Time to First Query:** Reduction in setup time for new users
- **Task Completion Rate:** Percentage of successful data acquisition operations
- **User Satisfaction:** Feedback scores and adoption rates across user segments

**Functional Performance:**
- **Acquisition Success Rate:** Percentage of successful data ingestion operations
- **Query Response Quality:** Relevance scoring and user feedback on responses
- **System Reliability:** Uptime metrics and error rate tracking

### **Technical Performance Metrics**
Technical success criteria focus on scalability, performance, and operational excellence.

**System Performance:**
- **Response Time Compliance:** Meeting established latency targets
- **Throughput Achievement:** Concurrent user and operation support
- **Resource Utilization:** Efficient use of computational and storage resources

**Operational Excellence:**
- **Deployment Frequency:** Ability to deploy updates safely and frequently
- **Mean Time to Recovery:** Rapid incident response and resolution
- **Security Posture:** Zero critical vulnerabilities, compliance adherence

---

**Document Control**
- **Source:** Product Owner & Key Stakeholders Workshop
- **Capture Date:** 2025-09-25
- **Usage:** Input for Explore phase deliverable development
- **Next Review:** Upon completion of Scope & Deliverables document
- **Related Documents:** Discovery phase inputs, technical architecture specifications
