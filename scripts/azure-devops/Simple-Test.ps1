# Simple test to create a basic work item

$organization = "hana-x"
$pat = "YOUR_AZURE_DEVOPS_PAT_TOKEN_HERE"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

$headers = @{
    "Authorization"  = "Basic $base64AuthInfo"
    "Content-Type"   = "application/json-patch+json"
}

Write-Host "Testing simple work item creation..." -ForegroundColor Cyan

# Try to create a simple Task first
$uri = "https://dev.azure.com/$organization/_apis/wit/workitems/`$Task?api-version=7.1-preview.3"

$body = @"
[
  {
    "op": "add",
    "path": "/fields/System.Title",
    "value": "Test Task - Delete Me"
  },
  {
    "op": "add",
    "path": "/fields/System.TeamProject",
    "value": "HX-Data-Ingestion-Project Public"
  }
]
"@

try {
    Write-Host "Creating test task..." -ForegroundColor Yellow
    $response = Invoke-RestMethod -Uri $uri -Method 'POST' -Headers $headers -Body $body
    
    Write-Host "✅ SUCCESS! Test task created: #$($response.id)" -ForegroundColor Green
    Write-Host "   Title: $($response.fields.'System.Title')" -ForegroundColor White
    Write-Host "   Project: $($response.fields.'System.TeamProject')" -ForegroundColor White
    
    # Clean up
    $deleteUri = "https://dev.azure.com/$organization/_apis/wit/workitems/$($response.id)?destroy=true&api-version=7.1-preview.3"
    Invoke-RestMethod -Uri $deleteUri -Method 'DELETE' -Headers $headers
    Write-Host "✅ Test task cleaned up" -ForegroundColor Green
    
    # Now try Epic
    Write-Host "`nNow trying Epic..." -ForegroundColor Yellow
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
    "value": "HX-Data-Ingestion-Project Public"
  },
  {
    "op": "add",
    "path": "/fields/System.Description",
    "value": "15-server canonical deployment with complete monitoring and security infrastructure"
  }
]
"@
    
    $epicResponse = Invoke-RestMethod -Uri $epicUri -Method 'POST' -Headers $headers -Body $epicBody
    
    Write-Host "✅ SUCCESS! Epic 1 created: #$($epicResponse.id)" -ForegroundColor Green
    Write-Host "   Title: $($epicResponse.fields.'System.Title')" -ForegroundColor White
    Write-Host "   Project: $($epicResponse.fields.'System.TeamProject')" -ForegroundColor White
    Write-Host "   URL: $($epicResponse._links.html.href)" -ForegroundColor Cyan
    
} catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $errorResponse = $_.Exception.Response.GetResponseStream()
        $streamReader = New-Object System.IO.StreamReader($errorResponse)
        $errorMessage = $streamReader.ReadToEnd()
        Write-Host "Error Details: $errorMessage" -ForegroundColor Yellow
    }
}
