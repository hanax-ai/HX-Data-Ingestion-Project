---
title: SDD Workflow Guide for HX Data Ingestion Project
owner: @jarvisr
status: Approved
tags: [sdd, workflow, guide, cursor, data-ingestion]
summary: Step-by-step guide for applying Spec-Driven Development methodology in the HX Data Ingestion Project.
sdd_phase: general
related_specs: []
constitutional_impact: high
---

# SDD Workflow Guide for HX Data Ingestion Project

## Overview

This guide provides the specific workflow for applying Spec-Driven Development methodology to the HX Data Ingestion Project using Cursor as our AI agent and the enhanced Spec Kit with `/clarify` and `/analyze` commands.

## Prerequisites

### Environment Setup
- **Cursor AI Agent**: Configured and ready for SDD commands
- **Repository Access**: HX Data Ingestion Project with Spec Kit integration
- **Working Directory**: Navigate to `spec kit/` directory for all SDD work

### Required Knowledge
- Understanding of [Spec-Driven Development methodology](./2025-09-24--spec-driven-methodology--guide.md)
- Familiarity with [Spec Kit commands](../overview/2025-09-24--spec-kit--overview.md)
- Project [constitutional principles](../../spec%20kit/memory/constitution.md) (once established)

## Enhanced 7-Step Workflow

### Step 1: `/constitution` - Establish Project Principles

**Purpose**: Define non-negotiable governing principles that guide all development decisions.

**When to Use**: 
- At project start (before any feature development)
- When fundamental project direction changes
- When team composition or constraints change significantly

**Process**:
1. Navigate to `spec kit/` directory
2. Execute `/constitution` command in Cursor
3. Define principles covering:
   - Code quality standards
   - Performance expectations
   - Security requirements
   - Data handling principles
   - Architecture constraints
   - Testing requirements

**Output**: `memory/constitution.md` with project governing principles

**Quality Check**: Ensure principles are specific, measurable, and enforceable

---

### Step 2: `/specify` - Define Requirements

**Purpose**: Transform feature ideas into structured specifications with clear requirements and user stories.

**When to Use**:
- Starting any new feature development
- When requirements need clarification or expansion
- For major feature enhancements

**Process**:
1. Ensure you're in `spec kit/` directory
2. Execute `/specify` command with feature description
3. Focus on WHAT and WHY, not HOW
4. Include:
   - User stories and personas
   - Functional requirements
   - Success criteria
   - Out-of-scope items

**Output**: 
- New feature directory: `specs/###-feature-name/`
- Feature specification: `specs/###-feature-name/spec.md`
- Feature branch creation

**Quality Check**: Specification should be clear about user value and measurable outcomes

---

### Step 3: `/clarify` - Resolve Ambiguities ⭐ NEW

**Purpose**: Interactive ambiguity resolution through targeted questioning to address under-specification.

**When to Use**:
- After `/specify` but before `/plan`
- When specifications seem unclear or incomplete
- To validate assumptions and fill gaps

**Process**:
1. Execute `/clarify` command in the feature directory
2. Answer up to 5 targeted questions with multiple-choice options
3. Questions cover:
   - Functional scope and behavior
   - Data models and relationships
   - User experience flows
   - Performance requirements
   - Integration needs

**Output**: Updated `spec.md` with clarifications section and refined requirements

**Quality Check**: All major ambiguities resolved, requirements testable

---

### Step 4: `/plan` - Create Technical Implementation Plan

**Purpose**: Transform business requirements into technical architecture and implementation approach.

**When to Use**:
- After specification is complete and clarified
- When technical approach needs definition
- For architecture decision documentation

**Process**:
1. Execute `/plan` command with tech stack and architectural preferences
2. Ensure constitutional compliance
3. Define:
   - Technical architecture
   - Data models and schemas
   - API contracts and interfaces
   - Technology choices and rationale

**Output**:
- Implementation plan: `plan.md`
- Data models: `data-model.md`
- API contracts: `contracts/` directory
- Research notes: `research.md`
- Validation scenarios: `quickstart.md`

**Quality Check**: Plan aligns with constitution and addresses all specification requirements

---

### Step 5: `/tasks` - Break Down Implementation

**Purpose**: Convert implementation plan into actionable, sequenced tasks.

**When to Use**:
- After technical plan is complete
- When ready to begin implementation
- For task estimation and planning

**Process**:
1. Execute `/tasks` command in feature directory
2. Ensure tasks are:
   - Specific and actionable
   - Properly sequenced with dependencies
   - Testable and measurable
   - Aligned with plan and specification

**Output**: Task breakdown: `tasks.md` with sequenced implementation steps

**Quality Check**: Tasks cover all plan elements and are implementable

---

### Step 6: `/analyze` - Validate Consistency ⭐ NEW

**Purpose**: Cross-validate consistency between specification, plan, and tasks while checking constitutional compliance.

**When to Use**:
- After `/tasks` but before `/implement`
- When inconsistencies are suspected
- As quality gate before implementation

**Process**:
1. Execute `/analyze` command in feature directory
2. Review findings categorized by severity:
   - **Critical**: Constitutional violations, missing coverage
   - **High**: Conflicting requirements, ambiguous criteria
   - **Medium**: Terminology drift, minor gaps
   - **Low**: Style improvements, minor redundancy

**Output**: Analysis report with:
- Consistency findings
- Coverage analysis
- Constitutional compliance check
- Remediation recommendations

**Quality Check**: No critical issues, high/medium issues addressed

---

### Step 7: `/implement` - Execute Implementation

**Purpose**: Execute the validated implementation plan according to specifications and tasks.

**When to Use**:
- After successful `/analyze` validation
- When all artifacts are consistent and complete
- Ready for actual development work

**Process**:
1. Execute `/implement` command
2. Follow task sequence from `tasks.md`
3. Maintain traceability to specifications
4. Update documentation as implementation evolves

**Output**: Working implementation with:
- Source code
- Tests
- Documentation
- Deployment artifacts

**Quality Check**: Implementation matches specifications and passes all validation criteria

## Branch Management

### Feature Branch Workflow
1. **Branch Creation**: Automatic during `/specify` with naming `###-feature-name`
2. **Development**: All SDD work happens in feature branch
3. **Validation**: Use `/analyze` before merging
4. **Integration**: Merge to main after completion and review

### Naming Conventions
- **Feature Branches**: `###-feature-name` (matches spec directory)
- **Spec Directories**: `specs/###-feature-name/`
- **Documentation**: Follow knowledge-base naming standards

## Quality Gates

### Before `/plan`
- ✅ Specification complete and reviewed
- ✅ `/clarify` process completed (or explicitly skipped)
- ✅ Requirements are testable and measurable

### Before `/implement`
- ✅ `/analyze` shows no critical issues
- ✅ Constitutional compliance verified
- ✅ All artifacts consistent and complete

### Before Merge
- ✅ Implementation matches specifications
- ✅ All tests passing
- ✅ Documentation updated
- ✅ Code review completed

## Common Patterns for Data Ingestion

### Data Source Integration Features
1. **Specify**: Focus on data source characteristics, volume, format
2. **Clarify**: Resolve data schema ambiguities, error handling requirements
3. **Plan**: Define connector architecture, transformation pipeline
4. **Analyze**: Validate data flow consistency, performance requirements

### Transformation Pipeline Features
1. **Specify**: Define input/output requirements, business rules
2. **Clarify**: Resolve transformation logic, validation criteria
3. **Plan**: Design pipeline architecture, scalability approach
4. **Analyze**: Ensure end-to-end consistency, performance alignment

## Troubleshooting

### Common Issues
- **Under-specification**: Use `/clarify` more thoroughly
- **Constitutional violations**: Review and align with project principles
- **Inconsistent artifacts**: Use `/analyze` to identify and resolve gaps
- **Implementation drift**: Maintain traceability to specifications

### Recovery Strategies
- **Specification gaps**: Return to `/clarify` phase
- **Plan inconsistencies**: Revise `/plan` with constitutional alignment
- **Task coverage issues**: Regenerate `/tasks` after plan updates
- **Implementation misalignment**: Validate against `/analyze` findings

---

**This workflow ensures systematic, high-quality development of data ingestion features while maintaining consistency with project principles and SDD methodology.**
