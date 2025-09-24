---
title: "V2 Product Backlog"
date: "2025-09-24"
---

# V2 Product Backlog: HX Data Ingestion Project

**Date:** 2025-09-24  
**Status:** Evidence-Based Only  
**Last Updated:** 2025-09-24

## ⚠️ PROCESS FAILURE ACKNOWLEDGMENT

**This backlog was initially created as a generic template dump rather than evidence-based requirements. It has been reset to contain only items directly supported by Discovery phase findings.**

**Lesson Learned:** Backlogs must be living documents maintained in real-time as insights emerge, not end-of-phase theoretical exercises.

## 1. Evidence-Based Backlog Items

**Source Constraint:** Only items with direct evidence from Discovery phase analysis are included.

### **Critical Items from Tech Stack Analysis**

#### **BL-001: Dependency Reduction**
**Evidence:** `2025-09-24--tech-stack--as-is.md` - "204 dependencies with ~2.5GB total footprint"
**Requirement:** Reduce dependency count to manageable core set
**Priority:** High (Production Critical)
**Added:** 2025-09-24

#### **BL-002: Replace ChromaDB for Production**
**Evidence:** `2025-09-24--tech-stack--as-is.md` - "ChromaDB not designed for distributed deployments"
**Requirement:** Replace with production-grade vector database
**Priority:** High (Scalability Critical)
**Added:** 2025-09-24

### **Critical Items from Consolidated Audit**

#### **BL-003: Network Timeout/Retry Implementation**
**Evidence:** `2025-09-24--consolidated-audit--report.md` - "Critical Risk: requests.get calls lack timeouts and retry logic"
**Requirement:** Implement timeout and retry logic for all external network calls
**Priority:** Critical (Tier 1)
**Added:** 2025-09-24

#### **BL-004: Robots.txt Compliance**
**Evidence:** `2025-09-24--consolidated-audit--report.md` - "High Risk: Crawlers bypass robots.txt checking"
**Requirement:** Add robots.txt compliance checking with configurable enforcement
**Priority:** High (Tier 2)
**Added:** 2025-09-24

#### **BL-005: Error Handling & Exit Codes**
**Evidence:** `2025-09-24--consolidated-audit--report.md` - "Scripts can fail silently while returning success exit code (0)"
**Requirement:** Implement proper error propagation with non-zero exit codes
**Priority:** High (Tier 2)
**Added:** 2025-09-24

#### **BL-006: Replace Print Statements with Structured Logging**
**Evidence:** `2025-09-24--consolidated-audit--report.md` - "Prototype relies exclusively on print statements"
**Requirement:** Implement structured JSON logging with performance metrics
**Priority:** Medium (Tier 2)
**Added:** 2025-09-24

### **Security Items from Audit**

#### **BL-007: Formal Secret Management**
**Evidence:** `2025-09-24--consolidated-audit--report.md` - "HX_DIP_SECRET environment variable without formal secure management guidance"
**Requirement:** Document and implement formal secret management strategy
**Priority:** Medium (Tier 1 - Documentation, Tier 2 - Implementation)
**Added:** 2025-09-24

### **Architecture Items from Tech Stack Analysis**

#### **BL-008: Modular Architecture for doc_ingest.py**
**Evidence:** `2025-09-24--consolidated-audit--report.md` - "Monolithic Ingestor: single large module with tight coupling"
**Requirement:** Refactor into modular components with separation of concerns
**Priority:** Medium (Tier 2)
**Added:** 2025-09-24

## 2. Backlog Management Process

### **Real-Time Addition Rules**
- Items added immediately when discovered during analysis
- Each item must reference specific Discovery evidence
- No generic or assumed requirements without backing evidence
- Stakeholder validation required before acceptance

### **Evidence Requirements**
- **Direct Quote:** Exact reference to source document
- **Risk Level:** Based on audit severity assessment
- **Discovery Date:** When the need was identified
- **Validation Status:** Stakeholder confirmation required

## 3. Next Steps

### **Immediate Validation Required**
- [ ] Stakeholder review of all 8 evidence-based items
- [ ] Priority confirmation based on business impact
- [ ] Resource allocation planning for critical items

### **Process Improvement**
- [ ] Implement real-time backlog updates for future phases
- [ ] Create validation checklist for new backlog items
- [ ] Document lessons learned from this process failure

---

**Current Status:** 8 evidence-based items identified from Discovery phase  
**Validation Required:** All items pending stakeholder confirmation  
**Process Status:** Corrected to evidence-based approach only


## 4. Feature Enhancement Items from As-Is Specifications

**Source:** Optional Enhancements sections documented during Discovery phase

### **From Streamlit App Specification**

#### **BL-009: Persistent Chat History**
**Evidence:** `2025-09-24--streamlit-app--as-is.md` - "Integrate a database (e.g., SQLite, Redis) to store and retrieve conversation histories"
**Requirement:** Add database-backed chat history persistence across sessions
**Priority:** Medium (User Experience)
**Added:** 2025-09-24

#### **BL-010: Multi-User Support**
**Evidence:** `2025-09-24--streamlit-app--as-is.md` - "Implement user authentication and a multi-tenant architecture"
**Requirement:** Add user authentication and multi-tenant chat histories
**Priority:** Medium (Scalability)
**Added:** 2025-09-24

#### **BL-011: Advanced UI Features**
**Evidence:** `2025-09-24--streamlit-app--as-is.md` - "Add features for managing conversations (e.g., new chat, delete chat, rename chat)"
**Requirement:** Implement conversation management and settings UI
**Priority:** Low (User Experience)
**Added:** 2025-09-24

#### **BL-012: Configuration UI**
**Evidence:** `2025-09-24--streamlit-app--as-is.md` - "Allow users to change settings like the model, collection, or number of retrieved documents"
**Requirement:** Add runtime configuration interface
**Priority:** Low (User Experience)
**Added:** 2025-09-24

### **From RAG Agent Specification**

#### **BL-013: Multi-LLM Support**
**Evidence:** `2025-09-24--rag-agent--as-is.md` - "Abstract the LLM client to support local models (e.g., via Ollama) or other providers"
**Requirement:** Implement provider-agnostic LLM interface
**Priority:** Medium (Flexibility)
**Added:** 2025-09-24

#### **BL-014: Streaming Responses**
**Evidence:** `2025-09-24--rag-agent--as-is.md` - "Implement response streaming to provide a much better user experience"
**Requirement:** Add streaming response capability to RAG agent
**Priority:** Medium (User Experience)
**Added:** 2025-09-24

#### **BL-015: Advanced RAG Strategies**
**Evidence:** `2025-09-24--rag-agent--as-is.md` - "Explore more sophisticated RAG techniques, such as query expansion, document re-ranking"
**Requirement:** Implement advanced RAG techniques for better retrieval
**Priority:** Low (Performance)
**Added:** 2025-09-24

#### **BL-016: Stateful Conversations**
**Evidence:** `2025-09-24--rag-agent--as-is.md` - "Add memory to the agent to allow for follow-up questions and conversational context"
**Requirement:** Implement conversation memory and context tracking
**Priority:** Medium (User Experience)
**Added:** 2025-09-24

### **From Utils Specification**

#### **BL-017: Specific Exception Handling**
**Evidence:** `2025-09-24--utils--as-is.md` - "Replace broad except Exception with specific ChromaDB exceptions"
**Requirement:** Implement specific exception handling for ChromaDB operations
**Priority:** Medium (Reliability)
**Added:** 2025-09-24

#### **BL-018: Input Validation**
**Evidence:** `2025-09-24--utils--as-is.md` - "Add Pydantic models for input validation"
**Requirement:** Implement input validation using Pydantic models
**Priority:** Medium (Data Quality)
**Added:** 2025-09-24

#### **BL-019: Dependency Injection**
**Evidence:** `2025-09-24--utils--as-is.md` - "Use dependency injection for ChromaDB client and collection objects to improve testability"
**Requirement:** Refactor for dependency injection pattern
**Priority:** Low (Testing)
**Added:** 2025-09-24

### **From Environment Configuration Specification**

#### **BL-020: Configuration Validation**
**Evidence:** `2025-09-24--env-example--as-is.md` - "Use a library like Pydantic's BaseSettings to load and validate environment variables"
**Requirement:** Implement configuration validation with clear error messages
**Priority:** Medium (Reliability)
**Added:** 2025-09-24

#### **BL-021: Hierarchical Configuration**
**Evidence:** `2025-09-24--env-example--as-is.md` - "Implement a system that allows for environment-specific overrides"
**Requirement:** Add support for environment-specific configuration files
**Priority:** Low (Operations)
**Added:** 2025-09-24

### **From Crawling Examples**

#### **BL-022: Dynamic Concurrency**
**Evidence:** `2025-09-24--3-crawl_sitemap_in_parallel--as-is.md` - "Adjust the max_concurrent value based on system specs"
**Requirement:** Implement dynamic concurrency based on system resources
**Priority:** Low (Performance)
**Added:** 2025-09-24

#### **BL-023: Configurable Dispatcher**
**Evidence:** `2025-09-24--3-crawl_sitemap_in_parallel--as-is.md` - "Expose dispatcher settings as command-line arguments"
**Requirement:** Make dispatcher settings configurable via CLI
**Priority:** Low (Usability)
**Added:** 2025-09-24

#### **BL-024: Domain Scoping**
**Evidence:** `2025-09-24--5-crawl_site_recursively--as-is.md` - "Add an explicit check to ensure that discovered links belong to the allowed domain(s)"
**Requirement:** Implement domain boundary enforcement for recursive crawling
**Priority:** Medium (Security)
**Added:** 2025-09-24

#### **BL-025: Persistent Queue**
**Evidence:** `2025-09-24--5-crawl_site_recursively--as-is.md` - "Implement a persistent queue (e.g., using Redis or a database) to allow the crawl to be resumed"
**Requirement:** Add persistent queue for resumable large crawls
**Priority:** Low (Reliability)
**Added:** 2025-09-24

---

**Updated Status:** 25 evidence-based items identified from Discovery phase  
**Critical Items:** 8 (from audit findings)  
**Enhancement Items:** 17 (from As-Is specifications)  
**Validation Required:** All items pending stakeholder confirmation
