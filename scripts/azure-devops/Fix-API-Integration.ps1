# Fix API Integration - Debug and Create Epic 1

$organization = "hana-x"
$projectName = "Citadel"
$pat = "3IbP1DkWs12aNa3Qq6P7PZVwnjEyrvDquojqPLlfDkxor0U8P6mtJQQJ99BJACAAAAAAX1qVAAASAZDO1Wp2"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

Write-Host "Fixing API Integration..." -ForegroundColor Cyan

# Test 1: Check if PAT has work item permissions
Write-Host "1. Testing PAT permissions..." -ForegroundColor Yellow

$headers = @{
    "Authorization" = "Basic $base64AuthInfo"
    "Content-Type" = "application/json"
}

try {
    # Try to get work item types first
    $witUri = "https://dev.azure.com/$organization/$projectName/_apis/wit/workitemtypes?api-version=7.1-preview.3"
    $witResponse = Invoke-RestMethod -Uri $witUri -Method 'GET' -Headers $headers
    
    Write-Host "✅ PAT has work item read permissions" -ForegroundColor Green
    Write-Host "Available work item types:" -ForegroundColor White
    foreach ($wit in $witResponse.value) {
        Write-Host "  - $($wit.name)" -ForegroundColor Gray
    }
    
} catch {
    Write-Host "❌ PAT lacks work item permissions: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Need to create a PAT with Work Items (Read, Write) scope" -ForegroundColor Yellow
    exit 1
}

# Test 2: Try different API endpoints
Write-Host "`n2. Testing different API endpoints..." -ForegroundColor Yellow

$endpoints = @(
    "https://dev.azure.com/$organization/_apis/wit/workitems/`$Epic?api-version=7.1-preview.3",
    "https://dev.azure.com/$organization/$projectName/_apis/wit/workitems/`$Epic?api-version=7.1-preview.3",
    "https://dev.azure.com/$organization/_apis/wit/workitems/`$Epic?api-version=6.0",
    "https://dev.azure.com/$organization/$projectName/_apis/wit/workitems/`$Epic?api-version=6.0"
)

foreach ($endpoint in $endpoints) {
    Write-Host "Testing: $endpoint" -ForegroundColor Gray
    
    $testBody = @"
[
  {
    "op": "add",
    "path": "/fields/System.Title",
    "value": "Test Epic - Delete Me"
  },
  {
    "op": "add",
    "path": "/fields/System.TeamProject",
    "value": "$projectName"
  }
]
"@
    
    try {
        $testResponse = Invoke-RestMethod -Uri $endpoint -Method 'POST' -Headers $headers -Body $testBody
        
        Write-Host "✅ SUCCESS with endpoint: $endpoint" -ForegroundColor Green
        Write-Host "Created test epic: #$($testResponse.id)" -ForegroundColor White
        
        # Clean up test epic
        $deleteUri = "https://dev.azure.com/$organization/_apis/wit/workitems/$($testResponse.id)?destroy=true&api-version=7.1-preview.3"
        Invoke-RestMethod -Uri $deleteUri -Method 'DELETE' -Headers $headers
        Write-Host "Test epic cleaned up" -ForegroundColor Green
        
        # Now create the real Epic 1
        Write-Host "`n3. Creating Epic 1: Infrastructure Foundation..." -ForegroundColor Yellow
        
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
        
        $epicResponse = Invoke-RestMethod -Uri $endpoint -Method 'POST' -Headers $headers -Body $epicBody
        
        Write-Host "🎉 EPIC 1 CREATED SUCCESSFULLY!" -ForegroundColor Green
        Write-Host "Work Item ID: #$($epicResponse.id)" -ForegroundColor White
        Write-Host "Title: $($epicResponse.fields.'System.Title')" -ForegroundColor White
        Write-Host "Priority: $($epicResponse.fields.'Microsoft.VSTS.Common.Priority')" -ForegroundColor White
        Write-Host "Business Value: $($epicResponse.fields.'Microsoft.VSTS.Common.BusinessValue')" -ForegroundColor White
        Write-Host "URL: $($epicResponse._links.html.href)" -ForegroundColor Cyan
        
        # Save epic data
        $epicData = @{
            Id = $epicResponse.id
            Title = $epicResponse.fields.'System.Title'
            Url = $epicResponse._links.html.href
            ProjectName = $projectName
            Organization = $organization
            CreatedDate = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            WorkingEndpoint = $endpoint
        }
        
        $epicData | ConvertTo-Json | Out-File "out/epic-1-success.json"
        Write-Host "Epic data saved to out/epic-1-success.json" -ForegroundColor Green
        
        Write-Host "`nEpic Board: https://dev.azure.com/$organization/$projectName/_boards/board/t/$projectName%20Team/Epics" -ForegroundColor Cyan
        
        exit 0
        
    } catch {
        Write-Host "❌ Failed with endpoint: $endpoint" -ForegroundColor Red
        Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

Write-Host "`n❌ All endpoints failed. Need to check PAT permissions." -ForegroundColor Red
Write-Host "Create a new PAT with Work Items (Read, Write) scope at:" -ForegroundColor Yellow
Write-Host "https://dev.azure.com/$organization/_usersSettings/tokens" -ForegroundColor Cyan
