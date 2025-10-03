# Grant Service Principal Access to Citadel Project

$organization = "hana-x"
$projectName = "Citadel"
$pat = "YOUR_AZURE_DEVOPS_PAT_TOKEN_HERE"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

$headers = @{
    "Authorization" = "Basic $base64AuthInfo"
    "Content-Type" = "application/json"
}

Write-Host "Granting Service Principal access to Citadel project..." -ForegroundColor Cyan

# Step 1: Get project contributors group
Write-Host "1. Getting project contributors group..." -ForegroundColor Yellow

try {
    $groupsUri = "https://dev.azure.com/$organization/_apis/projects/$projectName/teams?api-version=7.1-preview.3"
    $groupsResponse = Invoke-RestMethod -Uri $groupsUri -Method 'GET' -Headers $headers
    
    Write-Host "Available teams:" -ForegroundColor Green
    foreach ($team in $groupsResponse.value) {
        Write-Host "  - $($team.name) (ID: $($team.id))" -ForegroundColor White
    }
    
} catch {
    Write-Host "Failed to get teams: $($_.Exception.Message)" -ForegroundColor Red
}

# Step 2: Try to create work item with different authentication approach
Write-Host "`n2. Trying work item creation with different approach..." -ForegroundColor Yellow

# Try using the project ID directly in the URL
$projectId = "d6f864ff-302f-494a-9bf5-50a377a65e6c"
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

try {
    Write-Host "Creating Epic 1..." -ForegroundColor Yellow
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
    
} catch {
    Write-Host "❌ Failed to create Epic 1: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $errorResponse = $_.Exception.Response.GetResponseStream()
        $streamReader = New-Object System.IO.StreamReader($errorResponse)
        $errorMessage = $streamReader.ReadToEnd()
        Write-Host "Error Details: $errorMessage" -ForegroundColor Yellow
    }
    
    Write-Host "`nThe PAT token needs Work Items (Write) permissions." -ForegroundColor Yellow
    Write-Host "Create a new PAT at: https://dev.azure.com/$organization/_usersSettings/tokens" -ForegroundColor Cyan
    Write-Host "Required scopes: Work Items (Read, Write)" -ForegroundColor Yellow
}
