# Check Citadel project status and work item types

$organization = "hana-x"
$projectName = "Citadel"
$projectId = "d995504d-579d-4b28-8327-37fb8a303328"
$pat = "3IbP1DkWs12aNa3Qq6P7PZVwnjEyrvDquojqPLlfDkxor0U8P6mtJQQJ99BJACAAAAAAX1qVAAASAZDO1Wp2"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

$headers = @{
    "Authorization"  = "Basic $base64AuthInfo"
    "Content-Type"   = "application/json"
}

Write-Host "Checking Citadel project status..." -ForegroundColor Cyan

# Check project status
Write-Host "1. Checking project status..." -ForegroundColor Yellow
try {
    $projectUri = "https://dev.azure.com/$organization/_apis/projects/$projectId?api-version=7.1-preview.4"
    $projectResponse = Invoke-RestMethod -Uri $projectUri -Method 'GET' -Headers $headers
    
    Write-Host "Project Status:" -ForegroundColor Green
    Write-Host "  Name: $($projectResponse.name)" -ForegroundColor White
    Write-Host "  State: $($projectResponse.state)" -ForegroundColor White
    Write-Host "  Visibility: $($projectResponse.visibility)" -ForegroundColor White
    Write-Host "  Process Template: $($projectResponse.capabilities.processTemplate.templateName)" -ForegroundColor White
    
} catch {
    Write-Host "Failed to get project status: $($_.Exception.Message)" -ForegroundColor Red
}

# Check work item types
Write-Host "`n2. Checking work item types..." -ForegroundColor Yellow
try {
    $witUri = "https://dev.azure.com/$organization/$projectName/_apis/wit/workitemtypes?api-version=7.1-preview.3"
    $witResponse = Invoke-RestMethod -Uri $witUri -Method 'GET' -Headers $headers
    
    Write-Host "Available Work Item Types:" -ForegroundColor Green
    foreach ($wit in $witResponse.value) {
        Write-Host "  - $($wit.name)" -ForegroundColor White
    }
    
} catch {
    Write-Host "Failed to get work item types: $($_.Exception.Message)" -ForegroundColor Red
}

# Try creating a simple Task first
Write-Host "`n3. Testing simple Task creation..." -ForegroundColor Yellow
try {
    $taskUri = "https://dev.azure.com/$organization/_apis/wit/workitems/`$Task?api-version=7.1-preview.3"
    
    $taskBody = @"
[
  {
    "op": "add",
    "path": "/fields/System.Title",
    "value": "Test Task - Delete Me"
  },
  {
    "op": "add",
    "path": "/fields/System.TeamProject",
    "value": "$projectName"
  }
]
"@
    
    $taskResponse = Invoke-RestMethod -Uri $taskUri -Method 'POST' -Headers $headers -Body $taskBody
    
    Write-Host "Task created successfully: #$($taskResponse.id)" -ForegroundColor Green
    Write-Host "Title: $($taskResponse.fields.'System.Title')" -ForegroundColor White
    
    # Clean up
    $deleteUri = "https://dev.azure.com/$organization/_apis/wit/workitems/$($taskResponse.id)?destroy=true&api-version=7.1-preview.3"
    Invoke-RestMethod -Uri $deleteUri -Method 'DELETE' -Headers $headers
    Write-Host "Test task cleaned up" -ForegroundColor Green
    
} catch {
    Write-Host "Failed to create test task: $($_.Exception.Message)" -ForegroundColor Red
}

# Try creating Epic
Write-Host "`n4. Testing Epic creation..." -ForegroundColor Yellow
try {
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
    "path": "/fields/System.TeamProject",
    "value": "$projectName"
  },
  {
    "op": "add",
    "path": "/fields/System.Description",
    "value": "15-server canonical deployment with complete monitoring and security infrastructure"
  }
]
"@
    
    $epicResponse = Invoke-RestMethod -Uri $epicUri -Method 'POST' -Headers $headers -Body $epicBody
    
    Write-Host "Epic created successfully: #$($epicResponse.id)" -ForegroundColor Green
    Write-Host "Title: $($epicResponse.fields.'System.Title')" -ForegroundColor White
    Write-Host "URL: $($epicResponse._links.html.href)" -ForegroundColor Cyan
    
} catch {
    Write-Host "Failed to create Epic: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $errorResponse = $_.Exception.Response.GetResponseStream()
        $streamReader = New-Object System.IO.StreamReader($errorResponse)
        $errorMessage = $streamReader.ReadToEnd()
        Write-Host "Error Details: $errorMessage" -ForegroundColor Yellow
    }
}

Write-Host "`nDiagnostic complete!" -ForegroundColor Cyan
