---
title: "Scope & Deliverables: [Project Name]"
date: "YYYY-MM-DD"
owner: "[Product Lead/PM]"
status: "draft"
phase: "explore"
---

# Scope & Deliverables: [Project Name]

**Document Owner:** [Name]  
**Last Updated:** [Date]  
**Status:** [Draft/Review/Approved]  
**Reviewers:** [Engineering Lead, Design Lead, Sponsor]

## 1. Objectives & Business Outcomes

### **Primary Objectives**
- [Objective 1 - tied to business KPI/OKR]
- [Objective 2 - tied to business KPI/OKR]
- [Objective 3 - tied to business KPI/OKR]

### **Success Metrics**
| **Metric** | **Baseline** | **Target** | **Measurement Method** |
|------------|--------------|------------|------------------------|
| [Metric 1] | [Current] | [Goal] | [How measured] |
| [Metric 2] | [Current] | [Goal] | [How measured] |
| [Metric 3] | [Current] | [Goal] | [How measured] |

### **Business Outcomes**
- [Outcome 1 - business value delivered]
- [Outcome 2 - business value delivered]
- [Outcome 3 - business value delivered]

## 2. In-Scope / Out-of-Scope

### **In-Scope**
- [Capability 1 - with rationale]
- [Capability 2 - with rationale]
- [Capability 3 - with rationale]

### **Out-of-Scope**
- [Excluded item 1 - with rationale]
- [Excluded item 2 - with rationale]
- [Excluded item 3 - with rationale]

### **Deferred to Future Phases**
- [Future capability 1 - with timeline]
- [Future capability 2 - with timeline]
- [Future capability 3 - with timeline]

## 3. Assumptions & Constraints

### **Assumptions**
| **Assumption** | **Impact if Wrong** | **Validation Method** | **Owner** | **Due Date** |
|----------------|---------------------|----------------------|-----------|--------------|
| [Assumption 1] | [Impact] | [How to validate] | [Name] | [Date] |
| [Assumption 2] | [Impact] | [How to validate] | [Name] | [Date] |
| [Assumption 3] | [Impact] | [How to validate] | [Name] | [Date] |

### **Constraints**
- **Budget:** [Budget limitations and impact]
- **Timeline:** [Time constraints and impact]
- **Resources:** [Resource limitations and impact]
- **Technology:** [Technology constraints and impact]
- **Compliance:** [Regulatory/compliance requirements]
- **Data Residency:** [Data location/sovereignty requirements]

## 4. Dependencies

### **Internal Dependencies**
| **Dependency** | **Owner** | **Required By** | **Status** | **Risk Level** |
|----------------|-----------|-----------------|------------|----------------|
| [Dependency 1] | [Team/Person] | [Date] | [Status] | [H/M/L] |
| [Dependency 2] | [Team/Person] | [Date] | [Status] | [H/M/L] |
| [Dependency 3] | [Team/Person] | [Date] | [Status] | [H/M/L] |

### **External Dependencies**
| **Dependency** | **Vendor/Partner** | **Required By** | **Status** | **Risk Level** |
|----------------|-------------------|-----------------|------------|----------------|
| [Dependency 1] | [External party] | [Date] | [Status] | [H/M/L] |
| [Dependency 2] | [External party] | [Date] | [Status] | [H/M/L] |
| [Dependency 3] | [External party] | [Date] | [Status] | [H/M/L] |

## 5. Risks & Mitigations

### **Top 10 Risks**
| **Risk ID** | **Description** | **Probability** | **Impact** | **Risk Score** | **Mitigation** | **Owner** |
|-------------|-----------------|-----------------|------------|----------------|----------------|-----------|
| R-001 | [Risk description] | [H/M/L] | [H/M/L] | [Score] | [Mitigation plan] | [Name] |
| R-002 | [Risk description] | [H/M/L] | [H/M/L] | [Score] | [Mitigation plan] | [Name] |
| R-003 | [Risk description] | [H/M/L] | [H/M/L] | [Score] | [Mitigation plan] | [Name] |
| R-004 | [Risk description] | [H/M/L] | [H/M/L] | [Score] | [Mitigation plan] | [Name] |
| R-005 | [Risk description] | [H/M/L] | [H/M/L] | [Score] | [Mitigation plan] | [Name] |

### **Risk Examples & Common Mitigations**
- **Vendor Lock-in:** Design abstraction layer; ensure export paths
- **Data Quality:** Define source-of-truth and validation gates before integration
- **Environment Drift:** Enforce IaC and environment parity matrix
- **Scope Creep:** Change control process with impact analysis
- **Resource Availability:** Cross-training and backup resource identification

## 6. Deliverables & Acceptance Criteria

### **Phase Deliverables**
| **Deliverable** | **Description** | **Owner** | **Due Date** | **Acceptance Criteria** |
|-----------------|-----------------|-----------|--------------|-------------------------|
| [Deliverable 1] | [Description] | [Owner] | [Date] | [Criteria] |
| [Deliverable 2] | [Description] | [Owner] | [Date] | [Criteria] |
| [Deliverable 3] | [Description] | [Owner] | [Date] | [Criteria] |
| [Deliverable 4] | [Description] | [Owner] | [Date] | [Criteria] |
| [Deliverable 5] | [Description] | [Owner] | [Date] | [Criteria] |

### **Quality Gates**
- [ ] All deliverables meet acceptance criteria
- [ ] Stakeholder sign-off obtained
- [ ] Risk mitigation plans in place
- [ ] Dependencies confirmed or mitigated
- [ ] Success metrics baseline established

## 7. Governance & Decision Rights

### **RACI Matrix**
| **Decision/Activity** | **Responsible** | **Accountable** | **Consulted** | **Informed** |
|----------------------|-----------------|-----------------|---------------|--------------|
| Scope changes | [Role] | [Role] | [Role] | [Role] |
| Technical decisions | [Role] | [Role] | [Role] | [Role] |
| Resource allocation | [Role] | [Role] | [Role] | [Role] |
| Risk escalation | [Role] | [Role] | [Role] | [Role] |
| Quality approval | [Role] | [Role] | [Role] | [Role] |

### **Decision Rights**
- **Scope Changes:** [Process and approval authority]
- **Technical Decisions:** [Process and approval authority]
- **Budget Decisions:** [Process and approval authority]
- **Timeline Changes:** [Process and approval authority]

### **Escalation Path**
1. **Level 1:** [Role/Person] - [Scope of decisions]
2. **Level 2:** [Role/Person] - [Scope of decisions]
3. **Level 3:** [Role/Person] - [Scope of decisions]

## 8. Timeline & Milestones

### **Phase Timeline**
```mermaid
gantt
    title Explore Phase Timeline
    dateFormat  YYYY-MM-DD
    section Planning
    Scope & Deliverables      :active,  s1, [start-date], [duration]
    section Definition
    Feature Specification     :         s2, [start-date], [duration]
    Target Architecture       :         s3, [start-date], [duration]
    section Approach & QA
    Development Approach      :         s4, [start-date], [duration]
    Testing Strategy          :         s5, [start-date], [duration]
    section Governance
    Phase Sign-off            :milestone, ms1, [date], 0d
```

### **Key Milestones**
| **Milestone** | **Date** | **Deliverables** | **Success Criteria** |
|---------------|----------|------------------|----------------------|
| [Milestone 1] | [Date] | [Deliverables] | [Criteria] |
| [Milestone 2] | [Date] | [Deliverables] | [Criteria] |
| [Milestone 3] | [Date] | [Deliverables] | [Criteria] |

## 9. Sign-off Checklist

### **Scope Approval**
- [ ] Objectives mapped to OKRs/KPIs
- [ ] In/Out of scope signed by stakeholders
- [ ] Success metrics defined and measurable
- [ ] Constraints documented and accepted

### **Risk & Dependency Management**
- [ ] Top risks identified with mitigation plans
- [ ] Risk owners assigned and committed
- [ ] Dependencies logged with upstream teams
- [ ] Contingency plans defined for high-risk items

### **Governance**
- [ ] RACI matrix approved by all parties
- [ ] Decision rights clearly defined
- [ ] Escalation path established
- [ ] Change control process agreed

### **Final Approval**
- [ ] **Product Lead:** [Name] - [Date] - [Signature]
- [ ] **Engineering Lead:** [Name] - [Date] - [Signature]
- [ ] **Sponsor:** [Name] - [Date] - [Signature]

---

**Document Control**
- **Template Version:** 1.0
- **Last Updated:** [Date]
- **Next Review:** [Date]
- **Related Documents:** [Links to related artifacts]
