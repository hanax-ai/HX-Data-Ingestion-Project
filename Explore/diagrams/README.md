---
title: "Citadel V2 Architecture Diagrams"
date: "2025-09-25"
type: "visual-documentation"
phase: "explore"
---

# Citadel V2 Architecture Diagrams

**Purpose:** Visual documentation of Citadel V2 target architecture, process flows, and component interactions for the Explore phase.

## Diagram Catalog

### **System Architecture**

#### **[2025-09-25--citadel-v2-architecture--system-overview.png](2025-09-25--citadel-v2-architecture--system-overview.png)**
**Type:** System Architecture Diagram  
**Description:** Complete V2 system architecture showing all layers and components including User & API Layer (Open Web-UI, LiveKit, AG-UI Event Bus, API Gateway), Orchestration & Application Services (hx-orchestrator-server, RAGAgent, AcquisitionAgent, Crawl4AI, Copilotkit), AI & Data Layer (Qdrant, PostgreSQL, Redis, LiteLLM Router, hx-llm01/02, Embeddings), and Infrastructure & Operations (CI/CD, Monitoring, Config & Secrets).

**Key Features:**
- Complete technology stack visualization
- Component interaction patterns
- Layer separation and responsibilities
- Infrastructure and operations integration

### **Process Flow Diagrams**

#### **[2025-09-25--acquisition-flow--sequence-diagram.png](2025-09-25--acquisition-flow--sequence-diagram.png)**
**Type:** Sequence Diagram  
**Description:** End-to-end acquisition (ingestion) flow showing user interaction through Open Web-UI, AG-UI event streaming, orchestrator coordination, AcquisitionAgent processing, Crawl4AI content fetching, embedding generation, Qdrant vector storage, and PostgreSQL provenance tracking.

**Key Features:**
- Real-time event streaming (AcquisitionStarted, Progress, Completed)
- Agent-based processing workflow
- Multi-component coordination
- Provenance and metadata tracking

#### **[2025-09-25--retrieval-flow--sequence-diagram.png](2025-09-25--retrieval-flow--sequence-diagram.png)**
**Type:** Sequence Diagram  
**Description:** Complete retrieval (RAG) flow demonstrating user query processing through Open Web-UI, AG-UI events, orchestrator routing, RAGAgent processing, Qdrant vector search, LiteLLM completion generation, and streaming response delivery with provenance.

**Key Features:**
- Query processing and routing
- Vector search with metadata filtering
- LLM completion streaming
- Provenance-rich responses
- Real-time user feedback

#### **[2025-09-25--acquisition-workflow--process-diagram.png](2025-09-25--acquisition-workflow--process-diagram.png)**
**Type:** Process Flow Diagram  
**Description:** Detailed acquisition workflow showing data source type routing (sitemap, sequential, recursive, file/markdown) through parallel/sequential processing, header-aware chunking, embedding generation, Qdrant collection upsert, PostgreSQL provenance writing, and AG-UI progress events.

**Key Features:**
- Multi-source data acquisition patterns
- Parallel and sequential processing options
- Intelligent chunking strategies
- Event-driven progress tracking
- Complete workflow orchestration

### **Component Design**

#### **[2025-09-25--agent-interfaces--class-diagram.png](2025-09-25--agent-interfaces--class-diagram.png)**
**Type:** UML Class Diagram  
**Description:** Agent-first architecture showing AcquisitionAgent and RAGAgent with their interface dependencies (ICrawler, IEmbedder, IVectorStore, IRetriever, ILLM, IEventBus) following SOLID design principles for dependency injection and testability.

**Key Features:**
- SOLID design principle implementation
- Interface-based dependency injection
- Agent composition patterns
- Tool interface specifications
- Testable architecture design

## Usage Guidelines

### **For Architecture Documentation**
- Use system overview diagram for stakeholder presentations
- Reference process flows for technical implementation planning
- Include class diagram for development team guidance

### **For Development Planning**
- Process diagrams inform implementation sequencing
- Interface diagrams guide component development
- Architecture overview validates technology integration

### **For Stakeholder Communication**
- System overview provides complete picture of V2 capabilities
- Process flows demonstrate user experience improvements
- Visual documentation supports decision-making discussions

## Diagram Maintenance

### **Update Triggers**
- Architecture decision changes
- Technology stack modifications
- Process flow refinements
- Interface design evolution

### **Version Control**
- All diagrams stored in version control
- Naming convention: YYYY-MM-DD--component-name--diagram-type.png
- README.md updated with each diagram addition/modification

---

**Document Control**
- **Created:** 2025-09-25
- **Diagram Count:** 5 architectural diagrams
- **Coverage:** System architecture, process flows, component design
- **Next Review:** Upon architecture specification completion
