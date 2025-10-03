# Create Epic using project ID and different approaches

$organization = "hana-x"
$projectName = "Citadel"
$projectId = "d6f864ff-302f-494a-9bf5-50a377a65e6c"
$pat = "3IbP1DkWs12aNa3Qq6P7PZVwnjEyrvDquojqPLlfDkxor0U8P6mtJQQJ99BJACAAAAAAX1qVAAASAZDO1Wp2"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

$headers = @{
    "Authorization" = "Basic $base64AuthInfo"
    "Content-Type" = "application/json-patch+json"
}

Write-Host "Creating Epic 1 using project ID approach..." -ForegroundColor Cyan

# Try different API endpoints and approaches
$endpoints = @(
    "https://dev.azure.com/$organization/_apis/wit/workitems/`$Epic?api-version=7.1-preview.3",
    "https://dev.azure.com/$organization/_apis/wit/workitems/`$Epic?api-version=6.0",
    "https://dev.azure.com/$organization/_apis/wit/workitems/`$Epic?api-version=5.1",
    "https://dev.azure.com/$organization/$projectName/_apis/wit/workitems/`$Epic?api-version=7.1-preview.3"
)

foreach ($endpoint in $endpoints) {
    Write-Host "`nTrying endpoint: $endpoint" -ForegroundColor Yellow
    
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
    
    try {
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
            ProjectId = $projectId
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

# If Epic fails, try creating a Feature instead
Write-Host "`nEpic creation failed. Trying Feature instead..." -ForegroundColor Yellow

$featureUri = "https://dev.azure.com/$organization/_apis/wit/workitems/`$Feature?api-version=7.1-preview.3"

$featureBody = @"
[
  {
    "op": "add",
    "path": "/fields/System.Title",
    "value": "Epic 1: Infrastructure Foundation (as Feature)"
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

try {
    $featureResponse = Invoke-RestMethod -Uri $featureUri -Method 'POST' -Headers $headers -Body $featureBody
    
    Write-Host "✅ Feature created as Epic 1 substitute!" -ForegroundColor Green
    Write-Host "Work Item ID: #$($featureResponse.id)" -ForegroundColor White
    Write-Host "Title: $($featureResponse.fields.'System.Title')" -ForegroundColor White
    Write-Host "URL: $($featureResponse._links.html.href)" -ForegroundColor Cyan
    
    Write-Host "`nNote: Created as Feature instead of Epic. You can change the work item type in Azure DevOps UI." -ForegroundColor Yellow
    
} catch {
    Write-Host "❌ Feature creation also failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`nAPI Integration debugging complete!" -ForegroundColor Cyan
