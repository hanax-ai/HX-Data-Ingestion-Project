# Create New Azure DevOps Project "Citadel" and Epic 1

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

Write-Host "Creating New Azure DevOps Project: Citadel" -ForegroundColor Cyan
Write-Host "Organization: $organization" -ForegroundColor Green
Write-Host "Project Name: $projectName" -ForegroundColor Green

# Step 1: Create the project
Write-Host "Creating new project..." -ForegroundColor Yellow

$projectBody = @{
    name = $projectName
    description = "Citadel V2 - Enterprise Agent-First Data Ingestion Platform"
    visibility = "private"
    capabilities = @{
        versioncontrol = @{
            sourceControlType = "Git"
        }
        processTemplate = @{
            templateTypeId = "6b724908-ef14-45cf-84f8-768b5384da45"
        }
    }
} | ConvertTo-Json -Depth 10

$projectUri = "https://dev.azure.com/$organization/_apis/projects?api-version=$apiVersion"

try {
    $projectResponse = Invoke-RestMethod -Uri $projectUri -Method 'POST' -Headers $headers -Body $projectBody
    
    Write-Host "Project created successfully!" -ForegroundColor Green
    Write-Host "Project ID: $($projectResponse.id)" -ForegroundColor White
    Write-Host "Project Name: $($projectResponse.name)" -ForegroundColor White
    
    $projectId = $projectResponse.id
    
    # Wait for project initialization
    Write-Host "Waiting for project initialization..." -ForegroundColor Yellow
    Start-Sleep -Seconds 30
    
} catch {
    Write-Host "Failed to create project: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Step 2: Create Epic 1
Write-Host "Creating Epic 1: Infrastructure Foundation..." -ForegroundColor Yellow

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
    "value": "15-server canonical deployment with complete monitoring and security infrastructure. Foundation for all Citadel V2 services. Timeline: 4 weeks. Tasks: 58 (T001-T058). Priority: Critical."
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
    
    Write-Host "Epic 1 created successfully!" -ForegroundColor Green
    Write-Host "Work Item ID: #$($epicResponse.id)" -ForegroundColor White
    Write-Host "Title: $($epicResponse.fields.'System.Title')" -ForegroundColor White
    Write-Host "Priority: $($epicResponse.fields.'Microsoft.VSTS.Common.Priority')" -ForegroundColor White
    Write-Host "Business Value: $($epicResponse.fields.'Microsoft.VSTS.Common.BusinessValue')" -ForegroundColor White
    
    # Save data
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
    Write-Host "Project data saved to out/citadel-project-data.json" -ForegroundColor Green
    
} catch {
    Write-Host "Failed to create Epic 1: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "SUCCESS! Citadel Project Created!" -ForegroundColor Green
Write-Host "Project: https://dev.azure.com/$organization/$projectName" -ForegroundColor Cyan
Write-Host "Epic Board: https://dev.azure.com/$organization/$projectName/_boards/board/t/$projectName%20Team/Epics" -ForegroundColor Cyan
Write-Host "Epic 1: $($epicResponse._links.html.href)" -ForegroundColor Cyan
