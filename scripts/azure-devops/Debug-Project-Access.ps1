# Debug project access with full admin PAT

$organization = "hana-x"
$pat = "3IbP1DkWs12aNa3Qq6P7PZVwnjEyrvDkWs12aNa3Qq6P7PZVwnjEyrvDquojqPLlfDkxor0U8P6mtJQQJ99BJACAAAAAAX1qVAAASAZDO1Wp2"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

$headers = @{
    "Authorization" = "Basic $base64AuthInfo"
    "Content-Type" = "application/json"
}

Write-Host "Debugging project access with full admin PAT..." -ForegroundColor Cyan

# Step 1: List all projects to get exact names
Write-Host "1. Listing all projects..." -ForegroundColor Yellow
try {
    $projectsUri = "https://dev.azure.com/$organization/_apis/projects?api-version=7.1-preview.4"
    $projectsResponse = Invoke-RestMethod -Uri $projectsUri -Method 'GET' -Headers $headers
    
    Write-Host "Found $($projectsResponse.count) projects:" -ForegroundColor Green
    foreach ($project in $projectsResponse.value) {
        Write-Host "  - '$($project.name)' (ID: $($project.id))" -ForegroundColor White
        Write-Host "    State: $($project.state)" -ForegroundColor Gray
    }
    
} catch {
    Write-Host "❌ Failed to list projects: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Step 2: Try different project name variations
$projectVariations = @("Citadel", "citadel", "CITADEL")

foreach ($projectName in $projectVariations) {
    Write-Host "`n2. Testing project name: '$projectName'..." -ForegroundColor Yellow
    
    # Test work item types
    try {
        $witUri = "https://dev.azure.com/$organization/$projectName/_apis/wit/workitemtypes?api-version=7.1-preview.3"
        $witResponse = Invoke-RestMethod -Uri $witUri -Method 'GET' -Headers $headers
        
        Write-Host "✅ Found work item types for '$projectName'" -ForegroundColor Green
        Write-Host "Available types:" -ForegroundColor White
        foreach ($wit in $witResponse.value) {
            Write-Host "  - $($wit.name)" -ForegroundColor Gray
        }
        
        # If we found work item types, try creating an Epic
        Write-Host "`n3. Creating Epic 1 with project name '$projectName'..." -ForegroundColor Yellow
        
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
    "value": "15-server canonical deployment with complete monitoring and security infrastructure. Foundation for all Citadel V2 services."
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
        
        $epicResponse = Invoke-RestMethod -Uri $epicUri -Method 'POST' -Headers $headers -Body $epicBody
        
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
        }
        
        $epicData | ConvertTo-Json | Out-File "out/epic-1-success.json"
        Write-Host "Epic data saved to out/epic-1-success.json" -ForegroundColor Green
        
        Write-Host "`nEpic Board: https://dev.azure.com/$organization/$projectName/_boards/board/t/$projectName%20Team/Epics" -ForegroundColor Cyan
        
        exit 0
        
    } catch {
        Write-Host "❌ Failed with project name '$projectName': $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n❌ All project name variations failed" -ForegroundColor Red
Write-Host "The project might not be accessible or there's an issue with the API endpoint" -ForegroundColor Yellow
