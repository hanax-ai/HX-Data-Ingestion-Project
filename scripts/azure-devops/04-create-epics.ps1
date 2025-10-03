#!/usr/bin/env pwsh
# Azure DevOps Epic Creation Script
# Step 4: Create 10 Epic work items for Citadel V2

[CmdletBinding()]
param(
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "  Step 4: Create Epic Work Items" -ForegroundColor Cyan
Write-Host "===========================================================" -ForegroundColor Cyan

# Load project configuration
if (-not (Test-Path "out/project-config.json")) {
    Write-Host "❌ Project configuration not found. Run 01-initialize-project.ps1 first." -ForegroundColor Red
    exit 1
}

$projectConfig = Get-Content "out/project-config.json" | ConvertFrom-Json
$AZDO_PROJECT = $projectConfig.Project

Write-Host "Project: $AZDO_PROJECT" -ForegroundColor Green

# Create output directory
if (-not (Test-Path "out")) {
    New-Item -ItemType Directory -Path "out" | Out-Null
}

# Define all 10 Epics
$epics = @(
    @{
        Title = "Epic 1: Infrastructure Foundation"
        Description = @"
**Overview:** 15-server canonical deployment with complete monitoring and security infrastructure

**Scope:** 
- Network infrastructure (192.168.10.0/24)
- Control plane HA cluster (3 servers)
- Application servers (4 servers)
- Data services (Qdrant, PostgreSQL, Redis)
- AI services (LiteLLM, Pydantic-AI)
- Monitoring stack (Prometheus, Grafana, Loki, Jaeger)
- Security infrastructure (Vault, RBAC, TLS)

**Business Value:** Foundation for all Citadel V2 services
**Timeline:** 4 weeks (Sprints 1-2)
**Task Count:** 58 tasks (T001-T058)
**Priority:** Critical
**Constitutional Compliance:** Zero Technical Debt, Security-by-Design, Production Readiness

**Related Documents:**
- Constitution: 1.0-Citadel-Project-Constition.md
- Implementation Plan: 2.0-Citadel_Implemenation-Plan.md
- System Architecture: 3.1-Citadel-System-Architecture.md
- Technology Stack: 3.2-Citadel-Technology-Stack.md
- Task File: 5.1-Infrastructure-Setup-Tasks.md
"@
        BusinessValue = 10
        Priority = "Critical"
        StartDate = "2025-10-15"
        TargetDate = "2025-11-12"
        TaskCount = 58
        Tags = "infrastructure;foundation;critical"
    },
    @{
        Title = "Epic 2: Data Acquisition System"
        Description = @"
**Overview:** Intelligent multi-source data acquisition with 5 specialized Pydantic-AI agents

**Scope:**
- SinglePageAgent (individual web pages)
- SequentialSitemapAgent (XML sitemap processing)
- ParallelSitemapAgent (concurrent sitemap processing)
- FileProcessingAgent (PDF, DOCX, TXT files)
- RecursiveExplorationAgent (deep site crawling)
- Agent orchestration and management
- Acquisition service API
- Progress monitoring and error handling

**Business Value:** Core data collection capability for all content types
**Timeline:** 6 weeks (Sprints 3-4)
**Task Count:** 70 tasks (T059-T128)
**Priority:** Critical
**Constitutional Compliance:** Agent-First Architecture, Spec-Driven Development

**Related Documents:**
- Specification: 4.5-Citadel-Data-Acquisition.md
- Task File: 5.2-Data-Acquisition-Agent-Tasks.md
- Test Cases: 7.1-Data-Acquisition-Test-Cases.md
"@
        BusinessValue = 10
        Priority = "Critical"
        StartDate = "2025-11-12"
        TargetDate = "2025-12-24"
        TaskCount = 70
        Tags = "acquisition;agents;pydantic-ai;critical"
    },
    @{
        Title = "Epic 3: Vector Processing & Indexing"
        Description = @"
**Overview:** Smart content chunking, embedding generation, and Qdrant vector storage

**Scope:**
- Hierarchical Markdown chunking
- Semantic content boundary detection
- Vector embedding generation (via LiteLLM)
- Qdrant vector database integration
- Distributed vector storage
- Optimized chunk sizes (512-1024 tokens)
- Multi-format support (Markdown, HTML, PDF, DOCX)
- Metadata preservation and quality metrics

**Business Value:** Search optimization and accuracy for RAG queries
**Timeline:** 4 weeks (Sprints 5-6)
**Task Count:** 69 tasks (T129-T197)
**Priority:** Critical
**Constitutional Compliance:** Agent-First Architecture, Production Readiness

**Related Documents:**
- Specification: 4.6-Citadel-Vector-Processing.md
- Task File: 5.3-Vector-Processing-Tasks.md
- Test Cases: 7.2-Vector-Processing-Test-Cases.md
"@
        BusinessValue = 9
        Priority = "Critical"
        StartDate = "2025-12-24"
        TargetDate = "2026-01-21"
        TaskCount = 69
        Tags = "vectorization;qdrant;embeddings;critical"
    },
    @{
        Title = "Epic 4: Query & Retrieval System"
        Description = @"
**Overview:** Natural language query processing with RAG-powered response generation via LiteLLM

**Scope:**
- Natural language query processing
- Vector similarity search
- Hybrid search (vector + keyword)
- Context assembly and ranking
- LLM response generation (via LiteLLM)
- Source attribution and provenance
- Multi-turn conversation management
- Query refinement and suggestions
- Cross-collection queries

**Business Value:** User-facing intelligence and natural language interaction
**Timeline:** 5 weeks (Sprints 7-8)
**Task Count:** 111 tasks (T198-T308)
**Priority:** Critical
**Constitutional Compliance:** Agent-First Architecture, Event-Driven Architecture

**Related Documents:**
- Specification: 4.2-Citadel-Query-Interface.md
- Specification: 4.7-Citadel-Semantic-Search.md
- Task File: 5.4-Retrieval-Query-Tasks.md
- Test Cases: 7.3-Query-Retrieval-Test-Cases.md
"@
        BusinessValue = 10
        Priority = "Critical"
        StartDate = "2026-01-21"
        TargetDate = "2026-02-25"
        TaskCount = 111
        Tags = "retrieval;rag;litellm;critical"
    },
    @{
        Title = "Epic 5: Authentication & Security"
        Description = @"
**Overview:** Enterprise SSO with Clerk, MFA, RBAC, collection-level permissions, and comprehensive audit logging

**Scope:**
- Clerk SSO integration
- Multi-factor authentication (MFA)
- Session and token management
- Role-based access control (RBAC)
- Collection-level permissions
- Audit logging and compliance
- Security monitoring and alerting
- Data encryption and protection

**Business Value:** Enterprise readiness and compliance requirements
**Timeline:** 3 weeks (Sprints 9-10)
**Task Count:** 140 tasks (T309-T448)
**Priority:** Critical
**Constitutional Compliance:** Security-by-Design, Zero Technical Debt

**Related Documents:**
- Specification: 4.8-Citadel-Authentication.md
- Task File: 5.5-Authentication-Security-Tasks.md
- Test Cases: 7.4-Authentication-Security-Test-Cases.md
"@
        BusinessValue = 10
        Priority = "Critical"
        StartDate = "2026-02-25"
        TargetDate = "2026-03-18"
        TaskCount = 140
        Tags = "authentication;security;clerk;critical"
    },
    @{
        Title = "Epic 6: Event System & Real-Time Communication"
        Description = @"
**Overview:** AG-UI event bus, LiveKit collaboration, real-time progress updates, and voice integration

**Scope:**
- Kafka event bus setup
- Event publishing and consumption
- AG-UI event bus integration
- Real-time progress updates
- LiveKit collaboration features
- Voice interface integration
- Notification system
- Real-time monitoring and alerts

**Business Value:** Transparency, collaboration, and real-time user experience
**Timeline:** 4 weeks (Sprints 11-12)
**Task Count:** 144 tasks (T449-T592)
**Priority:** High
**Constitutional Compliance:** Event-Driven Architecture, Agent-First Architecture

**Related Documents:**
- Specification: 4.9-Citadel-Event-System.md
- Task File: 5.6-Event-System-RealTime-Tasks.md
- Test Cases: 7.6-Event-System-Test-Cases.md
"@
        BusinessValue = 8
        Priority = "High"
        StartDate = "2026-03-18"
        TargetDate = "2026-04-15"
        TaskCount = 144
        Tags = "events;kafka;livekit;real-time"
    },
    @{
        Title = "Epic 7: User Interface & Experience"
        Description = @"
**Overview:** Open Web-UI frontend with React, real-time updates, voice interface, and collaboration features

**Scope:**
- Open Web-UI foundation and modules
- Dashboard with real-time updates
- Acquisition interface with progress monitoring
- Query interface with natural language
- Collection management interface
- Voice interface integration
- Collaboration features
- State management and hooks

**Business Value:** User adoption and satisfaction
**Timeline:** 6 weeks (Sprints 15-17)
**Task Count:** 208 tasks (T593-T800)
**Priority:** High
**Constitutional Compliance:** Agent-First Architecture, Production Readiness

**Related Documents:**
- Specification: 4.1-Citadel-User-Interface.md
- Specification: 4.3-Citadel-Collection-Management.md
- Specification: 4.4-Citadel-Progress-Monitoring.md
- Task File: 5.7-Frontend-UI-Tasks.md
- Test Cases: 7.7-UI-Frontend-Test-Cases.md
"@
        BusinessValue = 9
        Priority = "High"
        StartDate = "2026-04-15"
        TargetDate = "2026-05-27"
        TaskCount = 208
        Tags = "frontend;react;open-web-ui;user-experience"
    },
    @{
        Title = "Epic 8: Monitoring & Observability"
        Description = @"
**Overview:** Comprehensive logging, metrics, tracing with Prometheus, Grafana, Loki, and Jaeger

**Scope:**
- Structured logging with Loki
- Metrics collection with Prometheus
- Distributed tracing with Jaeger
- Dashboards and visualization
- Alerting and SLO monitoring
- Performance monitoring
- Error tracking and analysis
- Capacity planning and optimization

**Business Value:** Operational excellence and system reliability
**Timeline:** 3 weeks (Parallel with Sprints 11-12)
**Task Count:** 160 tasks (T801-T960)
**Priority:** High
**Constitutional Compliance:** Production Readiness, Zero Technical Debt

**Related Documents:**
- Specification: 4.10-Citadel-Monitoring.md
- Task File: 5.8-Monitoring-Observability-Tasks.md
- Test Cases: 7.8-Performance-Test-Cases.md
"@
        BusinessValue = 8
        Priority = "High"
        StartDate = "2025-11-12"
        TargetDate = "2026-05-27"
        TaskCount = 160
        Tags = "monitoring;observability;prometheus;grafana;parallel"
    },
    @{
        Title = "Epic 9: Quality Assurance & Testing"
        Description = @"
**Overview:** Integration, E2E, performance, security, and accessibility testing for production readiness

**Scope:**
- Integration test suite
- End-to-end test automation
- Performance testing
- Security testing
- Accessibility testing
- User acceptance testing
- Test data management
- Quality gates and metrics

**Business Value:** Production quality assurance and confidence
**Timeline:** 2 weeks (Sprint 18)
**Task Count:** 176 tasks (T961-T1136)
**Priority:** Critical
**Constitutional Compliance:** Production Readiness, Zero Technical Debt

**Related Documents:**
- Test Plan: 6.0-Citadel-Test-Plan.md
- Task File: 5.9-Integration-E2E-Testing-Tasks.md
- Test Cases: 7.1-7.10 (All test case files)
"@
        BusinessValue = 10
        Priority = "Critical"
        StartDate = "2026-05-27"
        TargetDate = "2026-06-10"
        TaskCount = 176
        Tags = "testing;quality;qa;critical"
    },
    @{
        Title = "Epic 10: Production Deployment & Go-Live"
        Description = @"
**Overview:** Blue-green deployment, traffic cutover, validation, and production stabilization

**Scope:**
- Pre-deployment validation
- Blue environment deployment
- Production cutover procedures
- Traffic migration and validation
- Post-go-live support
- Performance monitoring
- Rollback procedures
- Production stabilization

**Business Value:** Successful production launch and system stability
**Timeline:** 1 week (Sprint 19)
**Task Count:** 154 tasks (T1137-T1290)
**Priority:** Critical
**Constitutional Compliance:** Production Readiness, Zero Technical Debt

**Related Documents:**
- Implementation Plan: 2.0-Citadel_Implemenation-Plan.md
- Task File: 5.10-Production-Deployment-Tasks.md
- Test Cases: 7.8-Performance-Test-Cases.md
"@
        BusinessValue = 10
        Priority = "Critical"
        StartDate = "2026-06-10"
        TargetDate = "2026-06-24"
        TaskCount = 154
        Tags = "deployment;production;go-live;critical"
    }
)

# Create epics
$epicIds = @{}
$epicNumber = 1

foreach ($epic in $epics) {
    Write-Host "`nCreating Epic $epicNumber: $($epic.Title)" -ForegroundColor Cyan
    
    if ($DryRun) {
        Write-Host "  [DRY RUN] Would create epic with:" -ForegroundColor Yellow
        Write-Host "    Title: $($epic.Title)" -ForegroundColor White
        Write-Host "    Business Value: $($epic.BusinessValue)" -ForegroundColor White
        Write-Host "    Priority: $($epic.Priority)" -ForegroundColor White
        Write-Host "    Task Count: $($epic.TaskCount)" -ForegroundColor White
        Write-Host "    Tags: $($epic.Tags)" -ForegroundColor White
        continue
    }
    
    try {
        # Create epic work item
        $epicJson = az boards work-item create `
            --type Epic `
            --title $epic.Title `
            --description $epic.Description `
            --area "HX-Data-Ingestion-Project" `
            --iteration "Citadel V2" `
            --output json | ConvertFrom-Json
        
        if ($epicJson) {
            $epicId = $epicJson.id
            $epicIds[$epic.Title] = $epicId
            
            Write-Host "  ✅ Epic created: #$epicId" -ForegroundColor Green
            
            # Add custom fields
            Write-Host "  📝 Adding custom fields..." -ForegroundColor Yellow
            
            # Set priority
            az boards work-item update `
                --id $epicId `
                --fields "Microsoft.VSTS.Common.Priority=$($epic.Priority)" `
                --output table | Out-Null
            
            # Set business value
            az boards work-item update `
                --id $epicId `
                --fields "Microsoft.VSTS.Common.BusinessValue=$($epic.BusinessValue)" `
                --output table | Out-Null
            
            # Add tags
            if ($epic.Tags) {
                az boards work-item update `
                    --id $epicId `
                    --fields "System.Tags=$($epic.Tags)" `
                    --output table | Out-Null
            }
            
            Write-Host "  ✅ Custom fields added" -ForegroundColor Green
            
        } else {
            Write-Host "  ❌ Failed to create epic" -ForegroundColor Red
        }
        
    } catch {
        Write-Host "  ❌ Error creating epic: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Rate limiting
    Start-Sleep -Milliseconds 1000
    
    $epicNumber++
}

# Save epic IDs for later use
if (-not $DryRun) {
    $epicIds | ConvertTo-Json | Out-File "out/epic-ids.json"
    Write-Host "`n✅ Epic IDs saved to out/epic-ids.json" -ForegroundColor Green
}

Write-Host "`n===========================================================" -ForegroundColor Cyan
Write-Host "  ✅ EPIC CREATION COMPLETE" -ForegroundColor Green
Write-Host "===========================================================" -ForegroundColor Cyan

Write-Host "`nCreated Epics:" -ForegroundColor Yellow
foreach ($epic in $epics) {
    $epicId = if ($epicIds.ContainsKey($epic.Title)) { "#$($epicIds[$epic.Title])" } else { "[DRY RUN]" }
    Write-Host "  $epicId - $($epic.Title)" -ForegroundColor White
    Write-Host "    Tasks: $($epic.TaskCount) | Priority: $($epic.Priority) | Value: $($epic.BusinessValue)" -ForegroundColor Gray
}

Write-Host "`nNext Steps:" -ForegroundColor Yellow
Write-Host "  1. Review epics in Azure DevOps Boards" -ForegroundColor White
Write-Host "  2. Run: 05-create-features.ps1" -ForegroundColor White
Write-Host "  3. Run: 06-create-user-stories.ps1" -ForegroundColor White

Write-Host "`nAzure DevOps URL: https://dev.azure.com/hana-x/HX-Data-Ingestion-Project/_boards/board/t/HX-Data-Ingestion-Project%20Team/Epics" -ForegroundColor Cyan
