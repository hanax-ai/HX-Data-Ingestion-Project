# Create Epic 1 using Azure CLI to get token

$organization = "hana-x"
$projectName = "Citadel"

Write-Host "Creating Epic 1 using Azure CLI token..." -ForegroundColor Cyan

# Get access token using Azure CLI
Write-Host "1. Getting access token via Azure CLI..." -ForegroundColor Yellow

try {
    $tokenResponse = az account get-access-token --resource "499b84ac-1321-427f-97c4-7e2d95f85bad" --output json | ConvertFrom-Json
    $accessToken = $tokenResponse.accessToken
    
    Write-Host "✅ Access token obtained via Azure CLI" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Failed to get access token: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Set up headers with Bearer token
$headers = @{
    "Authorization" = "Bearer $accessToken"
    "Content-Type" = "application/json-patch+json"
}

# Create Epic 1
Write-Host "`n2. Creating Epic 1..." -ForegroundColor Yellow

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
    $epicResponse = Invoke-RestMethod -Uri $epicUri -Method 'POST' -Headers $headers -Body $epicBody
    
    Write-Host "🎉 EPIC 1 CREATED SUCCESSFULLY!" -ForegroundColor Green
    Write-Host "Work Item ID: #$($epicResponse.id)" -ForegroundColor White
    Write-Host "Title: $($epicResponse.fields.'System.Title')" -ForegroundColor White
    Write-Host "State: $($epicResponse.fields.'System.State')" -ForegroundColor White
    Write-Host "Priority: $($epicResponse.fields.'Microsoft.VSTS.Common.Priority')" -ForegroundColor White
    Write-Host "Business Value: $($epicResponse.fields.'Microsoft.VSTS.Common.BusinessValue')" -ForegroundColor White
    Write-Host "Tags: $($epicResponse.fields.'System.Tags')" -ForegroundColor White
    Write-Host "URL: $($epicResponse._links.html.href)" -ForegroundColor Cyan
    
    # Save epic data
    $epicData = @{
        Id = $epicResponse.id
        Title = $epicResponse.fields.'System.Title'
        Url = $epicResponse._links.html.href
        ProjectName = $projectName
        Organization = $organization
        CreatedDate = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        Method = "Azure CLI Token"
    }
    
    $epicData | ConvertTo-Json | Out-File "out/epic-1-success.json"
    Write-Host "Epic data saved to out/epic-1-success.json" -ForegroundColor Green
    
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
    
    Write-Host "`n✅ API Integration Fixed! Epic 1 is now on the board!" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Failed to create Epic 1: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $errorResponse = $_.Exception.Response.GetResponseStream()
        $streamReader = New-Object System.IO.StreamReader($errorResponse)
        $errorMessage = $streamReader.ReadToEnd()
        Write-Host "Error Details: $errorMessage" -ForegroundColor Yellow
    }
    
    Write-Host "`nThe service principal needs to be granted access to Azure DevOps." -ForegroundColor Yellow
    Write-Host "Add the service principal to the project contributors group in Azure DevOps." -ForegroundColor Yellow
}

Write-Host "`nAzure CLI Token Epic Creation Complete!" -ForegroundColor Cyan
