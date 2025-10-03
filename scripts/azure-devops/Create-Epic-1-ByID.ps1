# ===================================================================
# Script to Create Epic 1: Infrastructure Foundation using Project ID
# ===================================================================

$organization = "hana-x"
$projectId = "e484b4e7-3589-47ed-aa51-56f963d22013"  # HX-Data-Ingestion-Project Public
$pat = "YOUR_AZURE_DEVOPS_PAT_TOKEN_HERE"

$apiVersion = "7.1-preview.3"
$workItemType = "Epic"

# Set up authentication
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

$headers = @{
    "Authorization"  = "Basic $base64AuthInfo"
    "Content-Type"   = "application/json-patch+json"
}

# Construct the API URL using project ID
$uri = "https://dev.azure.com/$($organization)/_apis/wit/workitems/`$$($workItemType)?api-version=$($apiVersion)"

# Create the JSON body for Epic 1
$body = @"
[
  {
    "op": "add",
    "path": "/fields/System.Title",
    "from": null,
    "value": "Epic 1: Infrastructure Foundation"
  },
  {
    "op": "add",
    "path": "/fields/System.Description",
    "from": null,
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
    "from": null,
    "value": "Critical"
  },
  {
    "op": "add",
    "path": "/fields/Microsoft.VSTS.Common.BusinessValue",
    "from": null,
    "value": "10"
  },
  {
    "op": "add",
    "path": "/fields/System.Tags",
    "from": null,
    "value": "infrastructure;foundation;critical"
  },
  {
    "op": "add",
    "path": "/fields/System.TeamProject",
    "from": null,
    "value": "HX-Data-Ingestion-Project Public"
  }
]
"@

Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "  Creating Epic 1: Infrastructure Foundation" -ForegroundColor Cyan
Write-Host "===========================================================" -ForegroundColor Cyan

Write-Host "Organization: $organization" -ForegroundColor Green
Write-Host "Project ID: $projectId" -ForegroundColor Green
Write-Host "Project Name: HX-Data-Ingestion-Project Public" -ForegroundColor Green
Write-Host "Work Item Type: $workItemType" -ForegroundColor Green

try {
    Write-Host "`nAttempting to create Epic 1..." -ForegroundColor Yellow
    
    $response = Invoke-RestMethod -Uri $uri -Method 'POST' -Headers $headers -Body $body
    
    Write-Host "`n✅ SUCCESS! Epic 1 created successfully!" -ForegroundColor Green
    Write-Host "   Work Item ID: #$($response.id)" -ForegroundColor White
    Write-Host "   Title: $($response.fields.'System.Title')" -ForegroundColor White
    Write-Host "   State: $($response.fields.'System.State')" -ForegroundColor White
    Write-Host "   Priority: $($response.fields.'Microsoft.VSTS.Common.Priority')" -ForegroundColor White
    Write-Host "   Business Value: $($response.fields.'Microsoft.VSTS.Common.BusinessValue')" -ForegroundColor White
    Write-Host "   Tags: $($response.fields.'System.Tags')" -ForegroundColor White
    
    Write-Host "`n📋 Epic 1 Details:" -ForegroundColor Yellow
    Write-Host "   • 58 Infrastructure Tasks (T001-T058)" -ForegroundColor White
    Write-Host "   • 4-Week Timeline (Sprints 1-2)" -ForegroundColor White
    Write-Host "   • Critical Priority" -ForegroundColor White
    Write-Host "   • Business Value: 10/10" -ForegroundColor White
    Write-Host "   • Foundation for all Citadel V2 services" -ForegroundColor White
    
    Write-Host "`n🔗 Azure DevOps URLs:" -ForegroundColor Yellow
    Write-Host "   Epic Board: https://dev.azure.com/$organization/HX-Data-Ingestion-Project%20Public/_boards/board/t/HX-Data-Ingestion-Project%20Public%20Team/Epics" -ForegroundColor Cyan
    Write-Host "   Work Item: $($response._links.html.href)" -ForegroundColor Cyan
    
    # Save epic data for future use
    $epicData = @{
        Id = $response.id
        Title = $response.fields.'System.Title'
        Url = $response._links.html.href
        CreatedDate = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        Organization = $organization
        Project = "HX-Data-Ingestion-Project Public"
        ProjectId = $projectId
    }
    
    $epicData | ConvertTo-Json | Out-File "out/epic-1-created.json"
    Write-Host "`n✅ Epic data saved to out/epic-1-created.json" -ForegroundColor Green
    
    Write-Host "`n===========================================================" -ForegroundColor Cyan
    Write-Host "  🎉 EPIC 1 SUCCESSFULLY CREATED! 🎉" -ForegroundColor Green
    Write-Host "===========================================================" -ForegroundColor Cyan
    
    Write-Host "`nNext Steps:" -ForegroundColor Yellow
    Write-Host "1. Review Epic 1 in Azure DevOps Boards" -ForegroundColor White
    Write-Host "2. Create Features under Epic 1:" -ForegroundColor White
    Write-Host "   • F1.1: Network & Control Plane Setup" -ForegroundColor Gray
    Write-Host "   • F1.2: Application Server Provisioning" -ForegroundColor Gray
    Write-Host "   • F1.3: Data Services Infrastructure" -ForegroundColor Gray
    Write-Host "   • F1.4: AI Services Configuration" -ForegroundColor Gray
    Write-Host "   • F1.5: Monitoring Infrastructure" -ForegroundColor Gray
    Write-Host "   • F1.6: Security Infrastructure" -ForegroundColor Gray
    Write-Host "   • F1.7: Container & Orchestration" -ForegroundColor Gray
    Write-Host "   • F1.8: Database Schema Initialization" -ForegroundColor Gray
    Write-Host "3. Create User Stories and Tasks" -ForegroundColor White
    Write-Host "4. Assign team members and plan Sprint 1" -ForegroundColor White
    
}
catch {
    Write-Host "`n❌ ERROR: Failed to create Epic 1." -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $errorResponse = $_.Exception.Response.GetResponseStream()
        $streamReader = New-Object System.IO.StreamReader($errorResponse)
        $errorMessage = $streamReader.ReadToEnd()
        
        Write-Host "`nAPI Error Details:" -ForegroundColor Yellow
        Write-Host $errorMessage -ForegroundColor White
        
        # Try to parse JSON error for better formatting
        try {
            $errorJson = $errorMessage | ConvertFrom-Json
            if ($errorJson.message) {
                Write-Host "`nError Message: $($errorJson.message)" -ForegroundColor Red
            }
            if ($errorJson.typeKey) {
                Write-Host "Error Type: $($errorJson.typeKey)" -ForegroundColor Red
            }
        } catch {
            # If not JSON, just show the raw error
            Write-Host "Raw Error: $errorMessage" -ForegroundColor Red
        }
    } else {
        Write-Host "Exception: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    Write-Host "`nTroubleshooting:" -ForegroundColor Yellow
    Write-Host "1. Verify PAT token has Work Items (Write) scope" -ForegroundColor White
    Write-Host "2. Check that project exists and is accessible" -ForegroundColor White
    Write-Host "3. Ensure PAT token is not expired" -ForegroundColor White
    Write-Host "4. Verify you have permissions to create work items" -ForegroundColor White
}
