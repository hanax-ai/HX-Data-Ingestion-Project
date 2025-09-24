---
title: {{TITLE}} — As‑Is Execution & Flow
owner: {{OWNER}}
status: Draft
tags: [prototype, crawl, execution-flow, as-is]
summary: As‑is functional/flow spec for {{SCRIPT_NAME}} with sequence & data‑flow diagrams.
discovery_date: {{DISCOVERY_DATE}}
script_version: {{SCRIPT_VERSION}}
analyst: {{ANALYST}}
---

> **How to use**: Replace all `{{…}}` tokens with real values. Paste the exact code under **Code (As‑Is)**. Keep this template strictly **as‑is** (no future‑state design) unless you intentionally add an "Enhancements" section at the end.

---

## Scope
This spec captures the **current behavior** of `{{SCRIPT_NAME}}` under `{{LOCATION}}`. It documents **what/where/when/why/how** and includes **Mermaid diagrams** (sequence + data‑flow) for clear understanding.

---

## 1) What: Functional Purpose
{{BRIEF_FUNCTIONAL_PURPOSE}}

**Primary Goal:** {{PRIMARY_GOAL}}

---

## 2) Where: System Context & Dependencies
- **Directory:** `{{LOCATION}}`
- **Execution Context:** {{EXECUTION_CONTEXT}}  
- **Key Dependencies:**
  - **Python:** {{PYTHON_VERSION}}
  - **Runtime libs:** {{RUNTIME_LIBS}}  
  - **Project libs:** {{PROJECT_LIBS}}  
- **Relationship to App/Subsystem:** {{RELATION_TO_APP}}

---

## 3) When: Use Cases & Triggers
- {{USE_CASE_1}}
- {{USE_CASE_2}}
- {{USE_CASE_3}}
- {{USE_CASE_4}}

---

## 4) Why: Engineering Rationale
- {{RATIONALE_1}}
- {{RATIONALE_2}}
- {{RATIONALE_3}}
- {{RATIONALE_4}}

---

## 5) How: Technical Implementation Deep‑Dive
{{HIGH_LEVEL_TECH_SUMMARY}}

### Code (As‑Is)
```python
{{PASTE_VERBATIM_CODE_HERE}}
```

### Execution Flow Analysis
1. {{STEP_1}}
2. {{STEP_2}}
3. {{STEP_3}}
4. {{STEP_4}}
5. {{STEP_5}}

### Mermaid — Sequence Diagram (as‑is)
```mermaid
sequenceDiagram
    participant User as {{SEQ_USER_LABEL}}
    participant Script as {{SCRIPT_NAME}}
    participant Crawler as {{SEQ_CRAWLER_LABEL}}
    participant Target as {{SEQ_TARGET_LABEL}}
    {{SEQ_ADDITIONAL_PARTICIPANTS}}

    User->>Script: {{SEQ_USER_TO_SCRIPT}}
    Script->>Crawler: {{SEQ_SCRIPT_TO_CRAWLER_1}}
    Script->>Crawler: {{SEQ_SCRIPT_TO_CRAWLER_2}}
    Crawler->>Target: {{SEQ_CRAWLER_TO_TARGET}}
    Target-->>Crawler: {{SEQ_TARGET_TO_CRAWLER}}
    {{SEQ_CONDITIONAL_FLOWS}}
    Crawler-->>Crawler: {{SEQ_INTERNAL_PROCESS}}
    {{SEQ_LOOP_REPRESENTATIONS}}
    Crawler-->>Script: {{SEQ_RESULT_TO_SCRIPT}}
    Script->>User: {{SEQ_OUTPUT_TO_USER}}
    Script->>Crawler: {{SEQ_TEARDOWN}}
    {{SEQ_ERROR_HANDLING}}
```

### Mermaid — Data Flow Diagram (as‑is)
```mermaid
graph TD
    A[{{DF_A}}] --> B[{{DF_B}}]
    B --> C[{{DF_C}}]
    C --> D[{{DF_D}}]
    D --> E[{{DF_E}}]
    E --> F[{{DF_F}}]
    F --> E
    E --> G[{{DF_G}}]
    G --> H[{{DF_H}}]
    H --> I[{{DF_I}}]
    I --> J[{{DF_J}}]
    {{DF_ADDITIONAL_FLOWS}}
    {{DF_ERROR_PATHS}}
    {{DF_CONDITIONAL_BRANCHES}}
```

---

## Environment & Run Steps (As‑Is)
- **OS / Host:** {{OS_HOST}}
- **Python:** {{PYTHON_VERSION}}
- **Install deps:** `{{INSTALL_DEPS_CMD}}`  
- **Install browsers/tools:** `{{INSTALL_BROWSERS_CMD}}`  
- **Run command:** `{{RUN_COMMAND}}`  
- **Env vars:** {{ENV_VARS}}
- **PYTHONPATH:** {{PYTHONPATH_NEED}}

## Inputs/Outputs & Exit Semantics (As‑Is)
- **Inputs:** {{INPUTS_AS_IS}}  
- **Outputs:** {{OUTPUTS_AS_IS}}  
- **Exit behavior:** {{EXIT_BEHAVIOR_AS_IS}}

## Output Artifacts & Performance (As‑Is)
- **Sample output files:** {{SAMPLE_OUTPUT_FILES}}
- **Output location:** {{OUTPUT_LOCATION}}
- **File naming pattern:** {{FILE_NAMING_PATTERN}}
- **Performance characteristics:** {{PERFORMANCE_CHARACTERISTICS}}
  - **Typical runtime:** {{TYPICAL_RUNTIME}}
  - **Resource usage:** {{RESOURCE_USAGE}}
  - **Throughput:** {{THROUGHPUT}}

## Known Limitations (As‑Is)
- {{LIMITATION_1}}
- {{LIMITATION_2}}
- {{LIMITATION_3}}
- {{LIMITATION_4}}

---

<!-- Optional: only include if you explicitly want forward‑looking notes -->
## (Optional) Enhancements — To Consider Later
- {{ENHANCEMENT_1}}
- {{ENHANCEMENT_2}}
- {{ENHANCEMENT_3}}

---

## Template Usage Notes

### Token Categories
- **{{TITLE}}** - Human-readable document title
- **{{OWNER}}** - Document maintainer (e.g., @username)
- **{{DISCOVERY_DATE}}** - Date when As-Is analysis was performed (YYYY-MM-DD)
- **{{SCRIPT_VERSION}}** - Git commit hash or version reference
- **{{ANALYST}}** - Person who performed the analysis
- **{{SCRIPT_NAME}}** - Actual script filename
- **{{LOCATION}}** - Full path to script file

### Mermaid Diagram Flexibility
- **{{SEQ_ADDITIONAL_PARTICIPANTS}}** - Add more participants as needed
- **{{SEQ_CONDITIONAL_FLOWS}}** - Document conditional execution paths
- **{{SEQ_LOOP_REPRESENTATIONS}}** - Show iterative processing
- **{{SEQ_ERROR_HANDLING}}** - Document error handling flows
- **{{DF_ADDITIONAL_FLOWS}}** - Extra data flow connections
- **{{DF_ERROR_PATHS}}** - Error handling in data flow
- **{{DF_CONDITIONAL_BRANCHES}}** - Conditional data processing paths

### Performance Documentation
- **{{PERFORMANCE_CHARACTERISTICS}}** - Observable performance traits
- **{{TYPICAL_RUNTIME}}** - Expected execution time
- **{{RESOURCE_USAGE}}** - Memory, CPU, network usage patterns
- **{{THROUGHPUT}}** - Processing rate (pages/minute, etc.)

### Output Artifact Tracking
- **{{SAMPLE_OUTPUT_FILES}}** - References to example generated files
- **{{OUTPUT_LOCATION}}** - Where files are written
- **{{FILE_NAMING_PATTERN}}** - How output files are named
