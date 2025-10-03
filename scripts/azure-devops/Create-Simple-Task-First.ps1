# Create a simple Task first to verify API works

$organization = "hana-x"
$projectName = "Citadel"
$pat = "3IbP1DkWs12aNa3Qq6P7PZVwnjEyrvDquojqPLlfDkxor0U8P6mtJQQJ99BJACAAAAAAX1qVAAASAZDO1Wp2"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

$headers = @{
    "Authorization" = "Basic $base64AuthInfo"
    "Content-Type" = "application/json-patch+json"
}

Write-Host "Creating simple Task first to verify API works..." -ForegroundColor Cyan

# Try creating a simple Task
$taskUri = "https://dev.azure.com/$organization/_apis/wit/workitems/`$Task?api-version=7.1-preview.3"

$taskBody = @"
[
  {
    "op": "add",
    "path": "/fields/System.Title",
    "value": "Test Task - API Verification"
  },
  {
    "op": "add",
    "path": "/fields/System.TeamProject",
    "value": "$projectName"
  },
  {
    "op": "add",
    "path": "/fields/System.Description",
    "value": "This is a test task to verify API integration works"
  }
]
"@

try {
    Write-Host "Creating test task..." -ForegroundColor Yellow
    $taskResponse = Invoke-RestMethod -Uri $taskUri -Method 'POST' -Headers $headers -Body $taskBody
    
    Write-Host "✅ Task created successfully!" -ForegroundColor Green
    Write-Host "Work Item ID: #$($taskResponse.id)" -ForegroundColor White
    Write-Host "Title: $($taskResponse.fields.'System.Title')" -ForegroundColor White
    Write-Host "URL: $($taskResponse._links.html.href)" -ForegroundColor Cyan
    
    # Now try to create Epic 1
    Write-Host "`nNow creating Epic 1..." -ForegroundColor Yellow
    
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
    
    # Clean up test task
    $deleteUri = "https://dev.azure.com/$organization/_apis/wit/workitems/$($taskResponse.id)?destroy=true&api-version=7.1-preview.3"
    Invoke-RestMethod -Uri $deleteUri -Method 'DELETE' -Headers $headers
    Write-Host "Test task cleaned up" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Failed: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $errorResponse = $_.Exception.Response.GetResponseStream()
        $streamReader = New-Object System.IO.StreamReader($errorResponse)
        $errorMessage = $streamReader.ReadToEnd()
        Write-Host "Error Details: $errorMessage" -ForegroundColor Yellow
    }
}

Write-Host "`nAPI Integration test complete!" -ForegroundColor Cyan
