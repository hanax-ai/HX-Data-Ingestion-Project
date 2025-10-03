#!/usr/bin/env pwsh
# Epic 1 Simple Setup Script
# Generates Epic 1 data for manual creation

Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "  Epic 1: Infrastructure Foundation" -ForegroundColor Cyan
Write-Host "===========================================================" -ForegroundColor Cyan

# Create output directory
if (-not (Test-Path "out")) {
    New-Item -ItemType Directory -Path "out" | Out-Null
}

# Epic 1 Definition
$epic1 = @{
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

**Success Criteria:**
- All 15 servers provisioned and configured
- Network infrastructure operational
- Data services (Qdrant, PostgreSQL, Redis) running
- AI services (LiteLLM, Pydantic-AI) configured
- Monitoring stack collecting metrics
- Security infrastructure enforcing policies
- All 58 infrastructure tasks completed
"@
    BusinessValue = 10
    Priority = "Critical"
    Tags = "infrastructure;foundation;critical"
}

Write-Host "Epic 1 Data Generated:" -ForegroundColor Green
Write-Host "  Title: $($epic1.Title)" -ForegroundColor White
Write-Host "  Business Value: $($epic1.BusinessValue)/10" -ForegroundColor White
Write-Host "  Priority: $($epic1.Priority)" -ForegroundColor White
Write-Host "  Task Count: 58 tasks" -ForegroundColor White
Write-Host "  Timeline: 4 weeks" -ForegroundColor White

# Save epic data
$epic1 | ConvertTo-Json -Depth 10 | Out-File "out/epic-1-data.json"
Write-Host "Epic 1 data saved to out/epic-1-data.json" -ForegroundColor Green

Write-Host ""
Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "  MANUAL CREATION INSTRUCTIONS" -ForegroundColor Yellow
Write-Host "===========================================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "1. Navigate to Azure DevOps:" -ForegroundColor Cyan
Write-Host "   URL: https://dev.azure.com/hana-x/HX-Data-Ingestion-Project/_boards/board/t/HX-Data-Ingestion-Project%20Team/Epics" -ForegroundColor White

Write-Host ""
Write-Host "2. Create New Epic:" -ForegroundColor Cyan
Write-Host "   - Click New Work Item then Epic" -ForegroundColor White
Write-Host "   - Or click New Epic button on the board" -ForegroundColor White

Write-Host ""
Write-Host "3. Fill in Epic Details:" -ForegroundColor Cyan
Write-Host "   Title: $($epic1.Title)" -ForegroundColor White
Write-Host "   Description: [Copy from description below]" -ForegroundColor White
Write-Host "   Priority: $($epic1.Priority)" -ForegroundColor White
Write-Host "   Business Value: $($epic1.BusinessValue)" -ForegroundColor White
Write-Host "   Tags: $($epic1.Tags)" -ForegroundColor White

Write-Host ""
Write-Host "4. Set Additional Fields:" -ForegroundColor Cyan
Write-Host "   - Area Path: HX-Data-Ingestion-Project" -ForegroundColor White
Write-Host "   - Iteration Path: Citadel V2" -ForegroundColor White
Write-Host "   - Assigned To: [Your name]" -ForegroundColor White
Write-Host "   - State: New" -ForegroundColor White

Write-Host ""
Write-Host "5. Save Epic:" -ForegroundColor Cyan
Write-Host "   - Click Save and Close" -ForegroundColor White
Write-Host "   - Note the Work Item ID (e.g., #12345)" -ForegroundColor White

Write-Host ""
Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "  EPIC 1 DETAILS FOR COPY/PASTE" -ForegroundColor Yellow
Write-Host "===========================================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "Title:" -ForegroundColor Green
Write-Host "$($epic1.Title)" -ForegroundColor White

Write-Host ""
Write-Host "Description:" -ForegroundColor Green
Write-Host $epic1.Description -ForegroundColor White

Write-Host ""
Write-Host "Additional Fields:" -ForegroundColor Green
Write-Host "Priority: $($epic1.Priority)" -ForegroundColor White
Write-Host "Business Value: $($epic1.BusinessValue)" -ForegroundColor White
Write-Host "Tags: $($epic1.Tags)" -ForegroundColor White
Write-Host "Area Path: HX-Data-Ingestion-Project" -ForegroundColor White
Write-Host "Iteration Path: Citadel V2" -ForegroundColor White

Write-Host ""
Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "  NEXT STEPS AFTER CREATION" -ForegroundColor Yellow
Write-Host "===========================================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "After creating Epic 1:" -ForegroundColor Green
Write-Host "1. Verify epic appears on the Epics board" -ForegroundColor White
Write-Host "2. Create Features under Epic 1:" -ForegroundColor White
Write-Host "   - F1.1: Network and Control Plane Setup" -ForegroundColor Gray
Write-Host "   - F1.2: Application Server Provisioning" -ForegroundColor Gray
Write-Host "   - F1.3: Data Services Infrastructure" -ForegroundColor Gray
Write-Host "   - F1.4: AI Services Configuration" -ForegroundColor Gray
Write-Host "   - F1.5: Monitoring Infrastructure" -ForegroundColor Gray
Write-Host "   - F1.6: Security Infrastructure" -ForegroundColor Gray
Write-Host "   - F1.7: Container and Orchestration" -ForegroundColor Gray
Write-Host "   - F1.8: Database Schema Initialization" -ForegroundColor Gray

Write-Host ""
Write-Host "3. Create User Stories under each Feature" -ForegroundColor White
Write-Host "4. Create Tasks under each User Story" -ForegroundColor White
Write-Host "5. Assign team members to work items" -ForegroundColor White
Write-Host "6. Plan Sprint 1 with Epic 1 work" -ForegroundColor White

Write-Host ""
Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "  EPIC 1 READY FOR CREATION!" -ForegroundColor Green
Write-Host "===========================================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "Epic 1 Summary:" -ForegroundColor Yellow
Write-Host "  - 58 Infrastructure Tasks" -ForegroundColor White
Write-Host "  - 4-Week Timeline" -ForegroundColor White
Write-Host "  - Critical Priority" -ForegroundColor White
Write-Host "  - Business Value: 10/10" -ForegroundColor White
Write-Host "  - Foundation for all Citadel V2 services" -ForegroundColor White

Write-Host ""
Write-Host "Ready to build the infrastructure foundation!" -ForegroundColor Green
