# ===================================================================
# Script to Create New Azure DevOps Project "Citadel" and Epic 1
# ===================================================================

$organization = "hana-x"
$projectName = "Citadel"
$pat = "3IbP1DkWs12aNa3Qq6P7PZVwnjEyrvDquojqPLlfDkxor0U8P6mtJQQJ99BJACAAAAAAX1qVAAASAZDO1Wp2"

$apiVersion = "7.1-preview.4"

# Set up authentication
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

$headers = @{
    "Authorization"  = "Basic $base64AuthInfo"
    "Content-Type"   = "application/json"
}

Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "  Creating New Azure DevOps Project: Citadel" -ForegroundColor Cyan
Write-Host "===========================================================" -ForegroundColor Cyan

Write-Host "Organization: $organization" -ForegroundColor Green
Write-Host "Project Name: $projectName" -ForegroundColor Green

# Step 1: Create the project
Write-Host "`n1. Creating new project '$projectName'..." -ForegroundColor Yellow

$projectBody = @{
    name = $projectName
    description = "Citadel V2 - Enterprise Agent-First Data Ingestion Platform"
    visibility = "private"
    capabilities = @{
        versioncontrol = @{
            sourceControlType = "Git"
        }
        processTemplate = @{
            templateTypeId = "6b724908-ef14-45cf-84f8-768b5384da45"  # Agile process template
        }
    }
} | ConvertTo-Json -Depth 10

$projectUri = "https://dev.azure.com/$organization/_apis/projects?api-version=$apiVersion"

try {
    $projectResponse = Invoke-RestMethod -Uri $projectUri -Method 'POST' -Headers $headers -Body $projectBody
    
    Write-Host "✅ Project created successfully!" -ForegroundColor Green
    Write-Host "   Project ID: $($projectResponse.id)" -ForegroundColor White
    Write-Host "   Project Name: $($projectResponse.name)" -ForegroundColor White
    Write-Host "   State: $($projectResponse.state)" -ForegroundColor White
    
    $projectId = $projectResponse.id
    
    # Wait for project to be fully created
    Write-Host "`n2. Waiting for project to be fully initialized..." -ForegroundColor Yellow
    $maxWaitTime = 300  # 5 minutes
    $waitTime = 0
    
    do {
        Start-Sleep -Seconds 10
        $waitTime += 10
        
        try {
            $checkUri = "https://dev.azure.com/$organization/_apis/projects/$projectId?api-version=$apiVersion"
            $checkResponse = Invoke-RestMethod -Uri $checkUri -Method 'GET' -Headers $headers
            
            if ($checkResponse.state -eq "wellFormed") {
                Write-Host "✅ Project fully initialized!" -ForegroundColor Green
                break
            } else {
                Write-Host "   Project state: $($checkResponse.state) (waiting...)" -ForegroundColor Yellow
            }
        } catch {
            Write-Host "   Still initializing... (waiting...)" -ForegroundColor Yellow
        }
        
    } while ($waitTime -lt $maxWaitTime)
    
    if ($waitTime -ge $maxWaitTime) {
        Write-Host "⚠️  Project creation timeout, but continuing..." -ForegroundColor Yellow
    }
    
} catch {
    Write-Host "❌ Failed to create project: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $errorResponse = $_.Exception.Response.GetResponseStream()
        $streamReader = New-Object System.IO.StreamReader($errorResponse)
        $errorMessage = $streamReader.ReadToEnd()
        Write-Host "Error Details: $errorMessage" -ForegroundColor Yellow
    }
    exit 1
}

# Step 2: Create Epic 1
Write-Host "`n3. Creating Epic 1: Infrastructure Foundation..." -ForegroundColor Yellow

$epicUri = "https://dev.azure.com/$organization/_apis/wit/workitems/`$Epic?api-version=7.1-preview.3"

$epicBody = @"
[
  {
    "op": "add",
    "path": "/fields/System.Title",
    "value": "Epic 1: Infrastructure Foundation"
  },
  {
    "op": "add",
    "path": "/fields/System.Description",
    "value": "**Overview:** 15-server canonical deployment with complete monitoring and security infrastructure

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
- All 58 infrastructure tasks completed"
  },
  {
    "op": "add",
    "path": "/fields/Microsoft.VSTS.Common.Priority",
    "value": "Critical"
  },
  {
    "op": "add",
    "path": "/fields/Microsoft.VSTS.Common.BusinessValue",
    "value": "10"
  },
  {
    "op": "add",
    "path": "/fields/System.Tags",
    "value": "infrastructure;foundation;critical"
  },
  {
    "op": "add",
    "path": "/fields/System.TeamProject",
    "value": "$projectName"
  }
]
"@

try {
    $epicResponse = Invoke-RestMethod -Uri $epicUri -Method 'POST' -Headers $headers -Body $epicBody
    
    Write-Host "✅ Epic 1 created successfully!" -ForegroundColor Green
    Write-Host "   Work Item ID: #$($epicResponse.id)" -ForegroundColor White
    Write-Host "   Title: $($epicResponse.fields.'System.Title')" -ForegroundColor White
    Write-Host "   State: $($epicResponse.fields.'System.State')" -ForegroundColor White
    Write-Host "   Priority: $($epicResponse.fields.'Microsoft.VSTS.Common.Priority')" -ForegroundColor White
    Write-Host "   Business Value: $($epicResponse.fields.'Microsoft.VSTS.Common.BusinessValue')" -ForegroundColor White
    Write-Host "   Tags: $($epicResponse.fields.'System.Tags')" -ForegroundColor White
    
    # Save project and epic data
    $projectData = @{
        ProjectId = $projectId
        ProjectName = $projectName
        Organization = $organization
        Epic1Id = $epicResponse.id
        Epic1Title = $epicResponse.fields.'System.Title'
        Epic1Url = $epicResponse._links.html.href
        CreatedDate = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    }
    
    $projectData | ConvertTo-Json | Out-File "out/citadel-project-data.json"
    Write-Host "`n✅ Project data saved to out/citadel-project-data.json" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Failed to create Epic 1: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $errorResponse = $_.Exception.Response.GetResponseStream()
        $streamReader = New-Object System.IO.StreamReader($errorResponse)
        $errorMessage = $streamReader.ReadToEnd()
        Write-Host "Error Details: $errorMessage" -ForegroundColor Yellow
    }
}

Write-Host "`n===========================================================" -ForegroundColor Cyan
Write-Host "  🎉 CITADEL PROJECT CREATED! 🎉" -ForegroundColor Green
Write-Host "===========================================================" -ForegroundColor Cyan

Write-Host "`n📋 Project Details:" -ForegroundColor Yellow
Write-Host "  • Project Name: $projectName" -ForegroundColor White
Write-Host "  • Project ID: $projectId" -ForegroundColor White
Write-Host "  • Organization: $organization" -ForegroundColor White
Write-Host "  • Process Template: Agile" -ForegroundColor White
Write-Host "  • Visibility: Private" -ForegroundColor White

Write-Host "`n📋 Epic 1 Details:" -ForegroundColor Yellow
Write-Host "  • Work Item ID: #$($epicResponse.id)" -ForegroundColor White
Write-Host "  • Title: Epic 1: Infrastructure Foundation" -ForegroundColor White
Write-Host "  • 58 Infrastructure Tasks (T001-T058)" -ForegroundColor White
Write-Host "  • 4-Week Timeline (Sprints 1-2)" -ForegroundColor White
Write-Host "  • Critical Priority" -ForegroundColor White
Write-Host "  • Business Value: 10/10" -ForegroundColor White

Write-Host "`n🔗 Azure DevOps URLs:" -ForegroundColor Yellow
Write-Host "  Project: https://dev.azure.com/$organization/$projectName" -ForegroundColor Cyan
Write-Host "  Epic Board: https://dev.azure.com/$organization/$projectName/_boards/board/t/$projectName%20Team/Epics" -ForegroundColor Cyan
Write-Host "  Epic 1: $($epicResponse._links.html.href)" -ForegroundColor Cyan

Write-Host "`nNext Steps:" -ForegroundColor Yellow
Write-Host "1. Review Epic 1 in Azure DevOps Boards" -ForegroundColor White
Write-Host "2. Create Features under Epic 1 (8 features)" -ForegroundColor White
Write-Host "3. Create User Stories and Tasks" -ForegroundColor White
Write-Host "4. Create remaining 9 epics" -ForegroundColor White
Write-Host "5. Set up team members and permissions" -ForegroundColor White

Write-Host "`nReady to build Citadel V2!" -ForegroundColor Green
