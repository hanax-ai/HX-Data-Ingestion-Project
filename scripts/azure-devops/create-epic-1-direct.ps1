#!/usr/bin/env pwsh
# Direct Epic 1 Creation Script
# Creates Epic 1: Infrastructure Foundation directly via REST API

[CmdletBinding()]
param(
    [string]$PatToken = $env:AZDO_PAT,
    [string]$Organization = "hana-x",
    [string]$Project = "HX-Data-Ingestion-Project"
)

$ErrorActionPreference = "Stop"

Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "  Creating Epic 1: Infrastructure Foundation" -ForegroundColor Cyan
Write-Host "===========================================================" -ForegroundColor Cyan

if (-not $PatToken) {
    Write-Host "❌ Azure DevOps PAT token required" -ForegroundColor Red
    Write-Host "   Set with: `$env:AZDO_PAT = 'your-pat-token'" -ForegroundColor Yellow
    Write-Host "   Or pass with: -PatToken 'your-pat-token'" -ForegroundColor Yellow
    exit 1
}

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

Write-Host "Organization: $Organization" -ForegroundColor Green
Write-Host "Project: $Project" -ForegroundColor Green
Write-Host "Epic Title: $($epic1.Title)" -ForegroundColor Green

# Azure DevOps REST API endpoint
$baseUrl = "https://dev.azure.com/$Organization/$Project/_apis"
$headers = @{
    "Authorization" = "Basic $([Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$PatToken")))"
    "Content-Type" = "application/json"
}

# Get project ID first
Write-Host "`nGetting project information..." -ForegroundColor Yellow
try {
    $projectUrl = "$baseUrl/projects/$Project"
    $projectResponse = Invoke-RestMethod -Uri $projectUrl -Headers $headers -Method Get
    
    Write-Host "✅ Project found: $($projectResponse.name)" -ForegroundColor Green
    Write-Host "   Project ID: $($projectResponse.id)" -ForegroundColor White
    Write-Host "   Process Template: $($projectResponse.capabilities.processTemplate.templateName)" -ForegroundColor White
    
} catch {
    Write-Host "❌ Failed to get project: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Create Epic work item
Write-Host "`nCreating Epic work item..." -ForegroundColor Yellow

$workItemUrl = "$baseUrl/wit/workitems/`$Epic"
$workItemBody = @(
    @{
        op = "add"
        path = "/fields/System.Title"
        value = $epic1.Title
    },
    @{
        op = "add"
        path = "/fields/System.Description"
        value = $epic1.Description
    },
    @{
        op = "add"
        path = "/fields/Microsoft.VSTS.Common.Priority"
        value = $epic1.Priority
    },
    @{
        op = "add"
        path = "/fields/Microsoft.VSTS.Common.BusinessValue"
        value = $epic1.BusinessValue
    },
    @{
        op = "add"
        path = "/fields/System.Tags"
        value = $epic1.Tags
    }
) | ConvertTo-Json -Depth 10

try {
    $epicResponse = Invoke-RestMethod -Uri $workItemUrl -Headers $headers -Method Post -Body $workItemBody
    
    Write-Host "✅ Epic created successfully!" -ForegroundColor Green
    Write-Host "   Work Item ID: #$($epicResponse.id)" -ForegroundColor White
    Write-Host "   Title: $($epicResponse.fields.'System.Title')" -ForegroundColor White
    Write-Host "   State: $($epicResponse.fields.'System.State')" -ForegroundColor White
    Write-Host "   Priority: $($epicResponse.fields.'Microsoft.VSTS.Common.Priority')" -ForegroundColor White
    Write-Host "   Business Value: $($epicResponse.fields.'Microsoft.VSTS.Common.BusinessValue')" -ForegroundColor White
    
    # Save epic ID for later use
    $epicData = @{
        Id = $epicResponse.id
        Title = $epicResponse.fields.'System.Title'
        Url = $epicResponse._links.html.href
        CreatedDate = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    }
    
    $epicData | ConvertTo-Json | Out-File "out/epic-1-data.json"
    Write-Host "✅ Epic data saved to out/epic-1-data.json" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Failed to create epic: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $errorStream = $_.Exception.Response.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($errorStream)
        $errorBody = $reader.ReadToEnd()
        Write-Host "   Error details: $errorBody" -ForegroundColor Yellow
    }
    
    exit 1
}

Write-Host "`n===========================================================" -ForegroundColor Cyan
Write-Host "  ✅ EPIC 1 CREATION COMPLETE!" -ForegroundColor Green
Write-Host "===========================================================" -ForegroundColor Cyan

Write-Host "`nEpic Details:" -ForegroundColor Yellow
Write-Host "  Work Item ID: #$($epicResponse.id)" -ForegroundColor White
Write-Host "  Title: $($epic1.Title)" -ForegroundColor White
Write-Host "  Business Value: $($epic1.BusinessValue)/10" -ForegroundColor White
Write-Host "  Priority: $($epic1.Priority)" -ForegroundColor White
Write-Host "  Task Count: 58 tasks (T001-T058)" -ForegroundColor White
Write-Host "  Timeline: 4 weeks" -ForegroundColor White

Write-Host "`nAzure DevOps URLs:" -ForegroundColor Yellow
Write-Host "  Epic Board: https://dev.azure.com/$Organization/$Project/_boards/board/t/$Project%20Team/Epics" -ForegroundColor Cyan
Write-Host "  Work Item: $($epicResponse._links.html.href)" -ForegroundColor Cyan

Write-Host "`nNext Steps:" -ForegroundColor Yellow
Write-Host "  1. Review Epic 1 in Azure DevOps Boards" -ForegroundColor White
Write-Host "  2. Create remaining 9 epics" -ForegroundColor White
Write-Host "  3. Create features under Epic 1" -ForegroundColor White
Write-Host "  4. Create user stories and tasks" -ForegroundColor White

Write-Host "`n🎉 Epic 1: Infrastructure Foundation is now on the board! 🎉" -ForegroundColor Green
