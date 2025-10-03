# Create Epic 1 in Citadel project with correct project ID

$organization = "hana-x"
$projectName = "Citadel"
$projectId = "d6f864ff-302f-494a-9bf5-50a377a65e6c"  # Correct project ID
$pat = "3IbP1DkWs12aNa3Qq6P7PZVwnjEyrvDquojqPLlfDkxor0U8P6mtJQQJ99BJACAAAAAAX1qVAAASAZDO1Wp2"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

$headers = @{
    "Authorization"  = "Basic $base64AuthInfo"
    "Content-Type"   = "application/json-patch+json"
}

Write-Host "Creating Epic 1: Infrastructure Foundation" -ForegroundColor Cyan
Write-Host "Project: $projectName (ID: $projectId)" -ForegroundColor Green

# Create Epic 1
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
    Write-Host "Creating Epic 1..." -ForegroundColor Yellow
    $epicResponse = Invoke-RestMethod -Uri $epicUri -Method 'POST' -Headers $headers -Body $epicBody
    
    Write-Host "SUCCESS! Epic 1 created!" -ForegroundColor Green
    Write-Host "Work Item ID: #$($epicResponse.id)" -ForegroundColor White
    Write-Host "Title: $($epicResponse.fields.'System.Title')" -ForegroundColor White
    Write-Host "State: $($epicResponse.fields.'System.State')" -ForegroundColor White
    Write-Host "Priority: $($epicResponse.fields.'Microsoft.VSTS.Common.Priority')" -ForegroundColor White
    Write-Host "Business Value: $($epicResponse.fields.'Microsoft.VSTS.Common.BusinessValue')" -ForegroundColor White
    Write-Host "Tags: $($epicResponse.fields.'System.Tags')" -ForegroundColor White
    
    # Save epic data
    $epicData = @{
        Id = $epicResponse.id
        Title = $epicResponse.fields.'System.Title'
        Url = $epicResponse._links.html.href
        ProjectName = $projectName
        ProjectId = $projectId
        Organization = $organization
        CreatedDate = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    }
    
    $epicData | ConvertTo-Json | Out-File "out/epic-1-created.json"
    Write-Host "Epic data saved to out/epic-1-created.json" -ForegroundColor Green
    
    Write-Host "`nEpic 1 Details:" -ForegroundColor Yellow
    Write-Host "  - 58 Infrastructure Tasks (T001-T058)" -ForegroundColor White
    Write-Host "  - 4-Week Timeline (Sprints 1-2)" -ForegroundColor White
    Write-Host "  - Critical Priority" -ForegroundColor White
    Write-Host "  - Business Value: 10/10" -ForegroundColor White
    Write-Host "  - Foundation for all Citadel V2 services" -ForegroundColor White
    
    Write-Host "`nAzure DevOps URLs:" -ForegroundColor Yellow
    Write-Host "Project: https://dev.azure.com/$organization/$projectName" -ForegroundColor Cyan
    Write-Host "Epic Board: https://dev.azure.com/$organization/$projectName/_boards/board/t/$projectName%20Team/Epics" -ForegroundColor Cyan
    Write-Host "Epic 1: $($epicResponse._links.html.href)" -ForegroundColor Cyan
    
    Write-Host "`nNext Steps:" -ForegroundColor Yellow
    Write-Host "1. Review Epic 1 in Azure DevOps Boards" -ForegroundColor White
    Write-Host "2. Create Features under Epic 1 (8 features)" -ForegroundColor White
    Write-Host "3. Create User Stories and Tasks" -ForegroundColor White
    Write-Host "4. Create remaining 9 epics" -ForegroundColor White
    
    Write-Host "`nEpic 1: Infrastructure Foundation is now on the board!" -ForegroundColor Green
    
} catch {
    Write-Host "Failed to create Epic 1: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $errorResponse = $_.Exception.Response.GetResponseStream()
        $streamReader = New-Object System.IO.StreamReader($errorResponse)
        $errorMessage = $streamReader.ReadToEnd()
        Write-Host "Error Details: $errorMessage" -ForegroundColor Yellow
    }
}
