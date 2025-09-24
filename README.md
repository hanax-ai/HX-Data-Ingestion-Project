# Citadel - AI-Powered Information Access

**This project demos how modern AI can transform information access. Using a documentation crawler with retrieval-augmented generation (RAG), it collects content from websites, text or Markdown files, and sitemaps. The material is then organized and stored in a searchable knowledge base, which can be explored through an easy-to-use web interface.**

## Project Status

🎯 **Explore Phase** - Building Citadel demo to socialize and gather feedback on our AI-powered information access approach.

**Phase Progression:**
- ✅ **Discovery Phase** - Completed comprehensive As-Is analysis of prototype
- 🔄 **Explore Phase** - Current: Building Citadel demo for stakeholder feedback
- 📋 **Realize Phase** - Future: Implementation based on demo feedback

## Quick Start

### Current Phase: Citadel Demo Development
Navigate to Explore phase planning and demo development:
- **[Citadel Demo PRD](./Explore/2025-09-24--citadel-demo--prd.md)** - Product requirements for demo development
- **[Phase Reality Check](./Explore/2025-09-24--phase-reality-check.md)** - Current phase constraints and focus
- **[Deliverables Tracker](./Explore/2025-09-24--explore-phase--deliverables-tracker.md)** - Demo development progress

### Discovery Phase Results
Review completed Discovery phase analysis:
- **[Final Report](./Discovery/2025-09-24--discovery-phase--final-report.md)** - Comprehensive Discovery findings
- **[V2 Backlog](./Discovery/2025-09-24--v2-backlog--product-backlog.md)** - 25 evidence-based backlog items
- **[Consolidated Audit](./Discovery/2025-09-24--consolidated-audit--report.md)** - Engineering audit results

### For Development Work
Navigate to the Spec Kit workspace for feature development:
```bash
cd "spec kit"
```

### For Project Understanding
Explore the knowledge base for comprehensive project documentation:
- **[Project Overview](./knowledge-base/overview/2025-09-24--hx-data-ingestion--project-overview.md)** - High-level project goals and approach
- **[SDD Workflow Guide](./knowledge-base/guides/2025-09-24--sdd-workflow--guide.md)** - Step-by-step development process
- **[Latest Updates](./knowledge-base/updates/CHANGELOG.md)** - Recent changes and milestones

## What Citadel Does

Citadel demonstrates modern AI-powered information access through:

**🕷️ Intelligent Crawling**
- Crawls websites, documentation sites, and sitemaps
- Processes text files and Markdown documents
- Handles various content formats and structures

**🧠 AI-Powered Processing**
- Uses retrieval-augmented generation (RAG) for intelligent content understanding
- Chunks and organizes content for optimal searchability
- Maintains context and relationships between information

**🔍 Smart Search & Discovery**
- Natural language queries against collected content
- Contextual responses with source attribution
- Interactive web interface for easy exploration

**📚 Knowledge Base Creation**
- Automatically organizes content into searchable knowledge base
- Maintains source links and metadata
- Enables rapid information discovery and access

## Methodology

This project follows **Spec-Driven Development (SDD)** using the GitHub Spec Kit, where specifications become executable and drive implementation rather than just guiding it.

### Enhanced Workflow

1. **`/constitution`** - Establish project principles and guidelines
2. **`/specify`** - Define requirements and user stories (WHAT and WHY)
3. **`/clarify`** - Resolve ambiguities and under-specifications ⭐ NEW
4. **`/plan`** - Create technical implementation plan (HOW)
5. **`/tasks`** - Break down into actionable tasks
6. **`/analyze`** - Cross-check consistency before implementation ⭐ NEW
7. **`/implement`** - Execute the implementation

## Repository Structure

```
HX-Data-Ingestion-Project/
├── Discovery/                   # ✅ Completed Discovery phase analysis
│   ├── 2025-09-24--discovery-phase--final-report.md
│   ├── 2025-09-24--v2-backlog--product-backlog.md
│   └── 2025-09-24--consolidated-audit--report.md
├── Explore/                     # 🔄 Current: Citadel demo development
│   ├── 2025-09-24--citadel-demo--prd.md
│   ├── 2025-09-24--phase-reality-check.md
│   └── 2025-09-24--explore-phase--deliverables-tracker.md
├── prototype/                   # 🔬 Original prototype and analysis
│   └── crawl4ai/               # Crawl4AI prototype with As-Is documentation
│       ├── docs/               # As-Is specifications and audit results
│       ├── examples/           # 5 example scripts analyzed
│       ├── src/                # Core modules (utils, doc_ingest, rag_agent)
│       └── app/                # Streamlit web interface
├── knowledge-base/              # 📚 Organized project documentation
│   ├── overview/               # High-level project understanding
│   ├── guides/                 # How-to guides and procedures
│   ├── analyses/               # Research and analytical documents
│   ├── updates/                # Changelogs and status updates
│   └── adr/                    # Architecture Decision Records
├── spec kit/                   # 🎯 Spec-Driven Development workspace
│   ├── .specify/              # Spec Kit templates and scripts
│   ├── memory/                # Project constitution and principles
│   ├── specs/                 # Feature specifications workspace
│   └── docs/                  # SDD-specific documentation
├── src/                        # Source code (created during implementation)
├── tests/                      # Test files (created during implementation)
└── README.md                   # This file
```

## Current Focus: Demo Development

**Goal:** Transform the prototype into **Citadel** - a polished demo that showcases AI-powered information access capabilities.

**Not Production:** This is a demo to socialize our approach and gather feedback, not production-ready software.

**Key Demo Features:**
- Consistent "Citadel" branding and identity
- End-to-end workflow demonstration (crawl → process → query)
- Built-in feedback collection mechanisms
- Simple deployment for stakeholder demonstrations

## Knowledge Base

### 📖 Essential Reading
- **[Project Overview](./knowledge-base/overview/2025-09-24--hx-data-ingestion--project-overview.md)** - Start here for project understanding
- **[Citadel Demo PRD](./Explore/2025-09-24--citadel-demo--prd.md)** - Current phase requirements
- **[SDD Workflow Guide](./knowledge-base/guides/2025-09-24--sdd-workflow--guide.md)** - Development methodology

### 📋 Reference Documentation
- **[Discovery Final Report](./Discovery/2025-09-24--discovery-phase--final-report.md)** - Complete prototype analysis
- **[V2 Backlog](./Discovery/2025-09-24--v2-backlog--product-backlog.md)** - 25 evidence-based items for future development
- **[Architecture Decisions](./knowledge-base/adr/)** - Formal decision records

### 🔍 Analysis & Research
- **[Consolidated Audit Report](./Discovery/2025-09-24--consolidated-audit--report.md)** - Engineering audit with ⭐⭐⭐⭐⭐ ratings
- **[Lessons Learned](./knowledge-base/retrospectives/2025-09-24--discovery-phase--lessons-learned.md)** - Process improvements
- **[Tech Stack Analysis](./prototype/crawl4ai/docs/as-is/2025-09-24--tech-stack--as-is.md)** - 204 dependencies analyzed

## Environment Variables

The project has access to the following environment variables:
- `HX_DIP_VAR` - Project-specific variable
- `HX_DIP_SECRET` - Project-specific secret
- `OPENAI_API_KEY` - Required for RAG functionality

## Getting Started

### Prerequisites

- **Python 3.11+**
- **Git**
- **OpenAI API Key** (for RAG functionality)

### Demo Development Workflow

#### Current Phase: Citadel Demo
1. **Review Demo Requirements**: Check [Citadel Demo PRD](./Explore/2025-09-24--citadel-demo--prd.md)
2. **Stay Phase-Focused**: Reference [Phase Reality Check](./Explore/2025-09-24--phase-reality-check.md) to avoid scope creep
3. **Track Progress**: Use [Deliverables Tracker](./Explore/2025-09-24--explore-phase--deliverables-tracker.md)
4. **Build Demo Features**: Focus on demonstration capabilities, not production features

#### Future Development
1. **Read Documentation**: Start with [Project Overview](./knowledge-base/overview/2025-09-24--hx-data-ingestion--project-overview.md)
2. **Navigate to Workspace**: `cd "spec kit"`
3. **Follow SDD Process**: Use the [SDD Workflow Guide](./knowledge-base/guides/2025-09-24--sdd-workflow--guide.md)
4. **Reference Backlog**: Use evidence-based items from [V2 Backlog](./Discovery/2025-09-24--v2-backlog--product-backlog.md)

## Core Principles

- **Demo-First Approach**: Build to demonstrate value and gather feedback
- **Evidence-Based Development**: All requirements backed by Discovery phase findings
- **Phase Discipline**: Stay focused on current phase, resist jumping ahead
- **Stakeholder Feedback**: Design for socialization and feedback collection
- **Spec-Driven Development**: Specifications drive implementation
- **Documentation Excellence**: Comprehensive, organized, and current documentation

## Contributing

This project uses Spec-Driven Development with phase-focused discipline:

1. **Understand Current Phase**: Review phase-specific documentation and constraints
2. **Follow SDD Workflow**: Use the established 7-step process for feature development
3. **Maintain Phase Focus**: Avoid production concerns during demo development
4. **Document Decisions**: Use ADR process for architectural choices
5. **Collect Feedback**: Build mechanisms to gather stakeholder input

## License

This project is licensed under the MIT License.

---

**Citadel: Demonstrating how modern AI transforms information access through intelligent crawling, processing, and retrieval.**
