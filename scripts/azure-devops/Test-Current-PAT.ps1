# Test current PAT permissions

$organization = "hana-x"
$projectName = "Citadel"
$pat = "3IbP1DkWs12aNa3Qq6P7PZVwnjEyrvDquojqPLlfDkxor0U8P6mtJQQJ99BJACAAAAAAX1qVAAASAZDO1Wp2"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

$headers = @{
    "Authorization" = "Basic $base64AuthInfo"
    "Content-Type" = "application/json"
}

Write-Host "Testing current PAT permissions..." -ForegroundColor Cyan

# Test 1: Can we read work item types?
Write-Host "1. Testing work item types read..." -ForegroundColor Yellow
try {
    $witUri = "https://dev.azure.com/$organization/$projectName/_apis/wit/workitemtypes?api-version=7.1-preview.3"
    $witResponse = Invoke-RestMethod -Uri $witUri -Method 'GET' -Headers $headers
    
    Write-Host "✅ Can read work item types" -ForegroundColor Green
    Write-Host "Available types:" -ForegroundColor White
    foreach ($wit in $witResponse.value) {
        Write-Host "  - $($wit.name)" -ForegroundColor Gray
    }
} catch {
    Write-Host "❌ Cannot read work item types: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 2: Can we create a simple Task?
Write-Host "`n2. Testing Task creation..." -ForegroundColor Yellow
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
    
    Write-Host "✅ Can create Tasks! Created: #$($taskResponse.id)" -ForegroundColor Green
    Write-Host "Title: $($taskResponse.fields.'System.Title')" -ForegroundColor White
    
    # Clean up
    $deleteUri = "https://dev.azure.com/$organization/_apis/wit/workitems/$($taskResponse.id)?destroy=true&api-version=7.1-preview.3"
    Invoke-RestMethod -Uri $deleteUri -Method 'DELETE' -Headers $headers
    Write-Host "Test task cleaned up" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Cannot create Tasks: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 3: Can we create an Epic?
Write-Host "`n3. Testing Epic creation..." -ForegroundColor Yellow
try {
    $epicUri = "https://dev.azure.com/$organization/_apis/wit/workitems/`$Epic?api-version=7.1-preview.3"
    
    $epicBody = @"
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
    
    $epicResponse = Invoke-RestMethod -Uri $epicUri -Method 'POST' -Headers $headers -Body $epicBody
    
    Write-Host "✅ Can create Epics! Created: #$($epicResponse.id)" -ForegroundColor Green
    Write-Host "Title: $($epicResponse.fields.'System.Title')" -ForegroundColor White
    
    # Clean up
    $deleteUri = "https://dev.azure.com/$organization/_apis/wit/workitems/$($epicResponse.id)?destroy=true&api-version=7.1-preview.3"
    Invoke-RestMethod -Uri $deleteUri -Method 'DELETE' -Headers $headers
    Write-Host "Test epic cleaned up" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Cannot create Epics: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`nPAT Test Complete!" -ForegroundColor Cyan
