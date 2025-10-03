# Create Epic 1 in the existing Citadel project

$organization = "hana-x"
$projectName = "Citadel"
$projectId = "d995504d-579d-4b28-8327-37fb8a303328"
$pat = "YOUR_AZURE_DEVOPS_PAT_TOKEN_HERE"

# Set up authentication
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

$headers = @{
    "Authorization"  = "Basic $base64AuthInfo"
    "Content-Type"   = "application/json-patch+json"
}

Write-Host "Creating Epic 1 in Citadel project..." -ForegroundColor Cyan
Write-Host "Project: $projectName (ID: $projectId)" -ForegroundColor Green

# Wait a bit more for project to be fully ready
Write-Host "Waiting for project to be fully ready..." -ForegroundColor Yellow
Start-Sleep -Seconds 60

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
    
    Write-Host "Epic 1 created successfully!" -ForegroundColor Green
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
    
    Write-Host "SUCCESS! Epic 1 is now on the board!" -ForegroundColor Green
    Write-Host "Epic Board: https://dev.azure.com/$organization/$projectName/_boards/board/t/$projectName%20Team/Epics" -ForegroundColor Cyan
    Write-Host "Epic 1: $($epicResponse._links.html.href)" -ForegroundColor Cyan
    
} catch {
    Write-Host "Failed to create Epic 1: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $errorResponse = $_.Exception.Response.GetResponseStream()
        $streamReader = New-Object System.IO.StreamReader($errorResponse)
        $errorMessage = $streamReader.ReadToEnd()
        Write-Host "Error Details: $errorMessage" -ForegroundColor Yellow
    }
}
