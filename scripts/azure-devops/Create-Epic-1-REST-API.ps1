# Create Epic 1 using Azure DevOps REST API with Service Principal
# Based on: https://learn.microsoft.com/en-us/azure/devops/integrate/how-to/call-rest-api?view=azure-devops

$organization = "hana-x"
$projectName = "HX-Citadel-Delta"
$clientId = "74bcb950-ec53-4672-a936-602babb8fb66"
$clientSecret = "YOUR_AZURE_AD_CLIENT_SECRET_HERE"
$tenantId = "0487600e-01cb-4a3a-b857-362ca50ea92c"

Write-Host "Creating Epic 1 using Azure DevOps REST API with Service Principal..." -ForegroundColor Cyan

# Step 1: Get access token for Azure DevOps
Write-Host "1. Getting access token for Azure DevOps..." -ForegroundColor Yellow

$tokenBody = @{
    client_id = $clientId
    client_secret = $clientSecret
    scope = "499b84ac-1321-427f-97c4-7e2d95f85bad/.default"
    grant_type = "client_credentials"
}

$tokenUri = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"

try {
    $tokenResponse = Invoke-RestMethod -Uri $tokenUri -Method 'POST' -Body $tokenBody -ContentType "application/x-www-form-urlencoded"
    $accessToken = $tokenResponse.access_token
    
    Write-Host "✅ Access token obtained for Azure DevOps" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Failed to get access token: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Step 2: Set up headers with Bearer token
$headers = @{
    "Authorization" = "Bearer $accessToken"
    "Content-Type" = "application/json-patch+json"
}

# Step 3: Verify project exists
Write-Host "`n2. Verifying project exists..." -ForegroundColor Yellow

try {
    $projectUri = "https://dev.azure.com/$organization/_apis/projects/$projectName?api-version=7.2"
    $projectResponse = Invoke-RestMethod -Uri $projectUri -Method 'GET' -Headers $headers
    
    Write-Host "✅ Project found: $($projectResponse.name) (ID: $($projectResponse.id))" -ForegroundColor Green
    Write-Host "State: $($projectResponse.state)" -ForegroundColor White
    
} catch {
    Write-Host "❌ Project not found: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Step 4: Check work item types
Write-Host "`n3. Checking work item types..." -ForegroundColor Yellow

try {
    $witUri = "https://dev.azure.com/$organization/$projectName/_apis/wit/workitemtypes?api-version=7.2"
    $witResponse = Invoke-RestMethod -Uri $witUri -Method 'GET' -Headers $headers
    
    Write-Host "✅ Available work item types:" -ForegroundColor Green
    foreach ($wit in $witResponse.value) {
        Write-Host "  - $($wit.name)" -ForegroundColor White
    }
    
    # Check if Epic type exists
    $epicType = $witResponse.value | Where-Object { $_.name -eq "Epic" }
    if ($epicType) {
        Write-Host "✅ Epic work item type found!" -ForegroundColor Green
    } else {
        Write-Host "❌ Epic work item type not found!" -ForegroundColor Red
        exit 1
    }
    
} catch {
    Write-Host "❌ Failed to get work item types: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Step 5: Create Epic 1 using REST API
Write-Host "`n4. Creating Epic 1..." -ForegroundColor Yellow

$epicUri = "https://dev.azure.com/$organization/_apis/wit/workitems/`$Epic?api-version=7.2"

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
    "value": "infrastructure;foundation;critical;citadel-v2;15-servers"
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
        Method = "Service Principal - REST API v7.2"
    }
    
    $epicData | ConvertTo-Json | Out-File "out/epic-1-rest-api-success.json"
    Write-Host "Epic data saved to out/epic-1-rest-api-success.json" -ForegroundColor Green
    
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
    
    Write-Host "`n✅ API INTEGRATION WORKING! Epic 1 is now on the board!" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Failed to create Epic 1: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $errorResponse = $_.Exception.Response.GetResponseStream()
        $streamReader = New-Object System.IO.StreamReader($errorResponse)
        $errorMessage = $streamReader.ReadToEnd()
        Write-Host "Error Details: $errorMessage" -ForegroundColor Yellow
    }
}

Write-Host "`nEpic Creation Complete!" -ForegroundColor Cyan

