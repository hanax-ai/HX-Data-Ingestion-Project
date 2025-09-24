---
title: New Spec Kit Updates Analysis - /clarify and /analyze Commands
owner: @jarvisr
status: Approved
tags: [spec-kit, analysis, clarify, analyze, commands]
summary: Detailed analysis of new /clarify and /analyze commands added to Spec Kit workflow.
sdd_phase: general
related_specs: []
constitutional_impact: low
---

# New Spec Kit Updates Analysis

## Summary of Video Transcript Updates

Based on the video transcript, **two major new commands** have been added to the Spec Kit workflow:

### 1. `/clarify` Command - **Addresses Under-Specification**

**Purpose**: Solves the problem of "under-specification" by asking up to 5 targeted clarification questions about ambiguous or missing requirements in the spec.

**Key Features**:
- **Interactive Q&A**: Presents one question at a time with multiple choice options (A, B, C, etc.)
- **Maximum 5 Questions**: Limited to prevent overwhelming the user
- **Automatic Spec Updates**: Records clarifications directly in the spec file as you answer
- **Living Document**: Updates functional requirements based on clarifications
- **Optional Step**: Can be skipped if desired, but recommended to avoid downstream rework

**Workflow Integration**:
- **OLD**: `/specify` → `/plan` → `/tasks`
- **NEW**: `/specify` → `/clarify` → `/plan` → `/tasks`

**Example Questions from Video**:
- "What specific episode metadata should be displayed on the episode pages?"
- "Which social sharing platforms should be supported for episode sharing?"
- "What are the specific performance requirements for load times?"
- "Content requirement for the episode descriptions?"
- "How should the website handle audio playback?"

### 2. `/analyze` Command - **Cross-Artifact Consistency Analysis**

**Purpose**: Analyzes spec, technical plan, and task breakdown files to find inconsistencies, constitutional violations, and alignment issues before implementation.

**Key Features**:
- **Cross-File Analysis**: Compares spec.md, plan.md, and tasks.md for consistency
- **Constitutional Compliance**: Ensures all artifacts align with project constitution (non-negotiable)
- **Severity Classification**: Categorizes issues as Critical, High, Medium, Low
- **Pre-Implementation Gate**: Runs after `/tasks` but before implementation
- **Discrepancy Detection**: Finds mismatches like framework conflicts, structural inconsistencies

**Example Issues Found in Video**:
- **Inconsistency**: "Project structure mismatch - plan shows assets/pages structure but task uses app/components Next.js structure"
- **Constitutional Violation**: "Next.js framework violates static HTML, CSS and vanilla JavaScript only constitution requirement"

## File Locations in Spec Kit Repository

### Command Templates
Located in `/templates/commands/` in the GitHub repository:

- **`/templates/commands/clarify.md`** - Template for the `/clarify` command
- **`/templates/commands/analyze.md`** - Template for the `/analyze` command

### Supporting Scripts
Located in `/scripts/` directory:
- **`/scripts/bash/check-prerequisites.sh`** - Bash version of prerequisite checking
- **`/scripts/powershell/check-prerequisites.ps1`** - PowerShell version

## Files Copied to HX Data Ingestion Project

I've copied all the necessary files to our project structure:

```
HX-Data-Ingestion-Project/
├── .specify/
│   ├── templates/
│   │   ├── commands/
│   │   │   ├── clarify.md          # NEW: /clarify command template
│   │   │   ├── analyze.md          # NEW: /analyze command template
│   │   │   ├── constitution.md     # /constitution command
│   │   │   ├── specify.md          # /specify command
│   │   │   ├── plan.md             # /plan command
│   │   │   ├── tasks.md            # /tasks command
│   │   │   └── implement.md        # /implement command
│   │   ├── spec-template.md        # Feature specification template
│   │   ├── plan-template.md        # Implementation plan template
│   │   ├── tasks-template.md       # Task breakdown template
│   │   └── agent-file-template.md  # Agent-specific instructions
│   └── scripts/
│       ├── bash/                   # Bash scripts for Linux/macOS
│       │   ├── check-prerequisites.sh
│       │   ├── common.sh
│       │   ├── create-new-feature.sh
│       │   ├── setup-plan.sh
│       │   └── update-agent-context.sh
│       └── powershell/             # PowerShell scripts for Windows
│           ├── check-prerequisites.ps1
│           ├── common.ps1
│           ├── create-new-feature.ps1
│           ├── setup-plan.ps1
│           └── update-agent-context.ps1
```

## Updated Workflow for HX Data Ingestion Project

### Enhanced 6-Step Process
1. **`/constitution`** - Establish project principles (optional but recommended)
2. **`/specify`** - Define requirements and user stories
3. **`/clarify`** - **NEW**: Resolve ambiguities and under-specifications
4. **`/plan`** - Create technical implementation plan
5. **`/tasks`** - Break down into actionable tasks
6. **`/analyze`** - **NEW**: Cross-check consistency before implementation
7. **`/implement`** - Execute the implementation

### Key Benefits for Our Project

1. **Reduced Ambiguity**: `/clarify` will help us identify and resolve unclear data ingestion requirements
2. **Better Alignment**: `/analyze` will ensure our spec, plan, and tasks are consistent
3. **Constitutional Compliance**: Ensures we stay aligned with project principles throughout
4. **Faster Iteration**: Interactive clarification prevents downstream rework
5. **Quality Gates**: Built-in validation before implementation begins

## Installation Updates Mentioned

The video also mentioned new installation flags:
- **`--force`** flag: Automatically overrides files without prompts
- **`uv tool install`** vs **`uvx`** options for different installation preferences

## Ready for Cursor Integration

All templates and scripts are now available in our project structure. **Cursor should now have access to the `/clarify` and `/analyze` commands** when we begin our Spec-Driven Development workflow for the HX Data Ingestion Project.

The enhanced workflow will help us build a more robust and well-specified data ingestion system by catching ambiguities early and ensuring consistency across all our artifacts.
