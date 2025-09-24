---
title: GitHub Spec Kit Overview and Commands
owner: @jarvisr
status: Approved
tags: [spec-kit, overview, sdd, commands]
summary: Comprehensive overview of GitHub Spec Kit methodology and available commands for SDD.
sdd_phase: general
related_specs: []
constitutional_impact: high
---

# GitHub Spec Kit Knowledge Summary

## Overview
The GitHub Spec Kit implements **Spec-Driven Development (SDD)** - a methodology that inverts traditional development by making specifications executable and the primary source of truth, with code as generated output.

## Core Philosophy
- **Specifications as Lingua Franca**: Specs become the primary artifact, code serves specifications
- **Executable Specifications**: Precise, complete specs that generate working systems
- **Intent-Driven Development**: Focus on WHAT and WHY, not HOW
- **Continuous Refinement**: AI-powered consistency validation throughout the process

## Key Commands Available in Cursor/AI Agents

### `/constitution`
Creates project governing principles and development guidelines that guide all subsequent development phases.

### `/specify` 
Transforms feature descriptions into complete, structured specifications with:
- Automatic feature numbering (001, 002, etc.)
- Branch creation with semantic names
- Template-based generation
- Proper directory structure in `specs/[branch-name]/`

### `/clarify` (formerly `/quizme`)
Clarifies underspecified areas - must be run before `/plan` unless explicitly skipped.

### `/plan`
Creates comprehensive implementation plans from specifications:
- Analyzes feature requirements and user stories
- Ensures constitutional compliance
- Converts business requirements to technical architecture
- Generates supporting documents (data models, API contracts, test scenarios)

### `/tasks`
Generates executable task lists from implementation plans by analyzing:
- `plan.md` (required)
- `data-model.md`, `contracts/`, `research.md` (if present)

### `/analyze`
Cross-artifact consistency & coverage analysis (run after /tasks, before /implement)

### `/implement`
Executes all tasks to build the feature according to the plan

## Project Structure

### Documentation Structure
```
specs/[###-feature]/
├── spec.md              # Feature specification
├── plan.md              # Implementation plan
├── research.md          # Research findings
├── data-model.md        # Data models
├── quickstart.md        # Validation scenarios
├── contracts/           # API contracts
└── tasks.md             # Executable task list
```

### Source Code Structure Options
1. **Single Project** (default)
2. **Web Application** (frontend + backend)
3. **Mobile + API** (iOS/Android + backend)

## Templates Available
- `spec-template.md` - Feature specification structure
- `plan-template.md` - Implementation plan structure  
- `tasks-template.md` - Task breakdown structure
- `agent-file-template.md` - Agent-specific instructions
- Command templates in `templates/commands/`

## Key Principles for HX Data Ingestion Project
1. Start with `/constitution` to establish project principles
2. Use `/specify` to define WHAT we're building (data sources, workflows, requirements)
3. Use `/clarify` to resolve any ambiguities
4. Use `/plan` to define HOW we'll implement it (tech stack, architecture)
5. Use `/tasks` to break down into actionable items
6. Use `/implement` to execute the plan

## Benefits for Data Ingestion Project
- Systematic approach to defining data sources and transformation requirements
- Clear separation between business requirements and technical implementation
- Built-in validation and consistency checking
- Support for iterative refinement and parallel implementations
- Proper documentation and traceability from requirements to code
