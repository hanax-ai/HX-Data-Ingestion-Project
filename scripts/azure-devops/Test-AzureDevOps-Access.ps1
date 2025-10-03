# ===================================================================
# Script to Test Azure DevOps Access and Project Information
# ===================================================================

$organization = "hana-x"
$project = "HX-Data-Ingestion-Project Public"
$pat = "YOUR_AZURE_DEVOPS_PAT_TOKEN_HERE"

$apiVersion = "7.1-preview.3"

# Set up authentication
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

$headers = @{
    "Authorization"  = "Basic $base64AuthInfo"
    "Content-Type"   = "application/json"
}

Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "  Testing Azure DevOps Access" -ForegroundColor Cyan
Write-Host "===========================================================" -ForegroundColor Cyan

Write-Host "Organization: $organization" -ForegroundColor Green
Write-Host "Project: $project" -ForegroundColor Green
Write-Host "PAT Token: $($pat.Substring(0,10))..." -ForegroundColor Green

# Test 1: Check organization access
Write-Host "`n1. Testing organization access..." -ForegroundColor Yellow
try {
    $orgUri = "https://dev.azure.com/$organization/_apis/projects?api-version=$apiVersion"
    $orgResponse = Invoke-RestMethod -Uri $orgUri -Method 'GET' -Headers $headers
    
    Write-Host "✅ Organization access successful!" -ForegroundColor Green
    Write-Host "   Found $($orgResponse.count) projects" -ForegroundColor White
    
    Write-Host "`nAvailable Projects:" -ForegroundColor Yellow
    foreach ($proj in $orgResponse.value) {
        $status = if ($proj.name -eq $project) { "✅ TARGET" } else { "   " }
        Write-Host "   $status $($proj.name) (ID: $($proj.id))" -ForegroundColor White
    }
    
} catch {
    Write-Host "❌ Organization access failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Test 2: Check specific project
Write-Host "`n2. Testing project access..." -ForegroundColor Yellow
try {
    $projectUri = "https://dev.azure.com/$organization/$project/_apis/projects/$project?api-version=$apiVersion"
    $projectResponse = Invoke-RestMethod -Uri $projectUri -Method 'GET' -Headers $headers
    
    Write-Host "✅ Project access successful!" -ForegroundColor Green
    Write-Host "   Project Name: $($projectResponse.name)" -ForegroundColor White
    Write-Host "   Project ID: $($projectResponse.id)" -ForegroundColor White
    Write-Host "   Process Template: $($projectResponse.capabilities.processTemplate.templateName)" -ForegroundColor White
    Write-Host "   Visibility: $($projectResponse.visibility)" -ForegroundColor White
    Write-Host "   State: $($projectResponse.state)" -ForegroundColor White
    
} catch {
    Write-Host "❌ Project access failed: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $errorResponse = $_.Exception.Response.GetResponseStream()
        $streamReader = New-Object System.IO.StreamReader($errorResponse)
        $errorMessage = $streamReader.ReadToEnd()
        Write-Host "   Error Details: $errorMessage" -ForegroundColor Yellow
    }
    exit 1
}

# Test 3: Check work item types
Write-Host "`n3. Testing work item types..." -ForegroundColor Yellow
try {
    $witUri = "https://dev.azure.com/$organization/$project/_apis/wit/workitemtypes?api-version=$apiVersion"
    $witResponse = Invoke-RestMethod -Uri $witUri -Method 'GET' -Headers $headers
    
    Write-Host "✅ Work item types access successful!" -ForegroundColor Green
    Write-Host "   Available work item types:" -ForegroundColor White
    
    foreach ($wit in $witResponse.value) {
        $status = if ($wit.name -eq "Epic") { "✅ EPIC" } else { "   " }
        Write-Host "   $status $($wit.name)" -ForegroundColor White
    }
    
} catch {
    Write-Host "❌ Work item types access failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 4: Check existing work items
Write-Host "`n4. Testing work item query..." -ForegroundColor Yellow
try {
    $queryUri = "https://dev.azure.com/$organization/$project/_apis/wit/wiql?api-version=$apiVersion"
    $queryBody = @{
        query = "SELECT [System.Id], [System.Title], [System.WorkItemType] FROM WorkItems WHERE [System.TeamProject] = '$project'"
    } | ConvertTo-Json
    
    $queryResponse = Invoke-RestMethod -Uri $queryUri -Method 'POST' -Headers $headers -Body $queryBody
    
    Write-Host "✅ Work item query successful!" -ForegroundColor Green
    Write-Host "   Found $($queryResponse.workItems.Count) existing work items" -ForegroundColor White
    
    if ($queryResponse.workItems.Count -gt 0) {
        Write-Host "`nExisting Work Items:" -ForegroundColor Yellow
        foreach ($wi in $queryResponse.workItems) {
            Write-Host "   #$($wi.id) - $($wi.fields.'System.Title') ($($wi.fields.'System.WorkItemType'))" -ForegroundColor White
        }
    }
    
} catch {
    Write-Host "❌ Work item query failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 5: Test work item creation permissions
Write-Host "`n5. Testing work item creation permissions..." -ForegroundColor Yellow
try {
    $createUri = "https://dev.azure.com/$organization/$project/_apis/wit/workitems/`$Task?api-version=$apiVersion"
    $createBody = @"
[
  {
    "op": "add",
    "path": "/fields/System.Title",
    "value": "Test Work Item - Delete Me"
  }
]
"@
    
    $createResponse = Invoke-RestMethod -Uri $createUri -Method 'POST' -Headers $headers -Body $createBody
    
    Write-Host "✅ Work item creation successful!" -ForegroundColor Green
    Write-Host "   Created test work item: #$($createResponse.id)" -ForegroundColor White
    
    # Clean up test work item
    $deleteUri = "https://dev.azure.com/$organization/$project/_apis/wit/workitems/$($createResponse.id)?destroy=true&api-version=$apiVersion"
    Invoke-RestMethod -Uri $deleteUri -Method 'DELETE' -Headers $headers
    Write-Host "   Test work item cleaned up" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Work item creation failed: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $errorResponse = $_.Exception.Response.GetResponseStream()
        $streamReader = New-Object System.IO.StreamReader($errorResponse)
        $errorMessage = $streamReader.ReadToEnd()
        Write-Host "   Error Details: $errorMessage" -ForegroundColor Yellow
    }
}

Write-Host "`n===========================================================" -ForegroundColor Cyan
Write-Host "  DIAGNOSTIC COMPLETE" -ForegroundColor Green
Write-Host "===========================================================" -ForegroundColor Cyan

Write-Host "`nSummary:" -ForegroundColor Yellow
Write-Host "• Organization: $organization" -ForegroundColor White
Write-Host "• Project: $project" -ForegroundColor White
Write-Host "• PAT Token: Valid" -ForegroundColor White
Write-Host "• Ready to create Epic 1!" -ForegroundColor Green
