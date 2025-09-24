# Front Matter Template for HX Data Ingestion Project

## Standard Template

Use this YAML front matter at the beginning of every Markdown document in the knowledge-base:

```yaml
---
title: Short Human Title
owner: @jarvisr
status: Draft   # Draft | In Review | Approved | Deprecated
tags: [spec-kit, ingestion]
summary: One-sentence "why this exists."
sdd_phase: specify  # specify | clarify | plan | tasks | analyze | implement | general
related_specs: []   # Links to related feature specs (e.g., ["001-data-ingestion-core"])
constitutional_impact: none  # none | low | medium | high
---
```

## Field Definitions

### **Standard Fields**
- **`title`**: Human-readable title for the document
- **`owner`**: GitHub username of the document owner (with @)
- **`status`**: Current lifecycle status of the document
- **`tags`**: Array of relevant tags for categorization
- **`summary`**: One-sentence explanation of the document's purpose

### **SDD Enhancement Fields**
- **`sdd_phase`**: Which phase of Spec-Driven Development this relates to
  - `specify` - Requirements definition
  - `clarify` - Ambiguity resolution
  - `plan` - Technical implementation planning
  - `tasks` - Task breakdown
  - `analyze` - Consistency validation
  - `implement` - Implementation execution
  - `general` - Not specific to any phase

- **`related_specs`**: Array of feature specification directories this document relates to
  - Format: `["001-feature-name", "002-other-feature"]`
  - Links to `spec kit/specs/` directories

- **`constitutional_impact`**: How much this document affects project constitution
  - `none` - No constitutional implications
  - `low` - Minor alignment considerations
  - `medium` - Moderate constitutional relevance
  - `high` - Major constitutional implications requiring review

## Document Type Examples

### **Overview Document**
```yaml
---
title: HX Data Ingestion Project Overview
owner: @jarvisr
status: Approved
tags: [project, overview, data-ingestion]
summary: High-level overview of the HX Data Ingestion Project goals and approach.
sdd_phase: general
related_specs: []
constitutional_impact: medium
---
```

### **Guide Document**
```yaml
---
title: Spec-Driven Development Workflow Guide
owner: @jarvisr
status: Approved
tags: [sdd, workflow, guide]
summary: Step-by-step guide for following SDD methodology in this project.
sdd_phase: general
related_specs: []
constitutional_impact: high
---
```

### **Analysis Document**
```yaml
---
title: Spec Kit Updates Analysis
owner: @jarvisr
status: Approved
tags: [spec-kit, analysis, updates]
summary: Analysis of new /clarify and /analyze commands in latest Spec Kit release.
sdd_phase: general
related_specs: []
constitutional_impact: low
---
```

### **ADR Document**
```yaml
---
title: Choose Repository Structure Standard
owner: @jarvisr
status: Approved
tags: [adr, repository, structure]
summary: Decision to implement knowledge-base structure with standardized naming.
sdd_phase: general
related_specs: []
constitutional_impact: medium
---
```

## Usage Guidelines

1. **Always include front matter** - Every document must start with the YAML block
2. **Keep summaries concise** - One sentence maximum
3. **Update status regularly** - Reflect current document state
4. **Link related specs** - Maintain traceability to feature work
5. **Consider constitutional impact** - Flag documents that affect project principles

## Validation

Documents should be validated for:
- ✅ Front matter present and complete
- ✅ Filename follows `YYYY-MM-DD--scope--doc-type.md` pattern
- ✅ All required fields populated
- ✅ Status reflects current state
- ✅ Related specs exist and are correctly referenced
