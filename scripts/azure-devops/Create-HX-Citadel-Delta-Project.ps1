# Create HX-Citadel-Delta project with Agile process template

$organization = "hana-x"
$projectName = "HX-Citadel-Delta"
$pat = "YOUR_AZURE_DEVOPS_PAT_TOKEN_HERE"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

$headers = @{
    "Authorization" = "Basic $base64AuthInfo"
    "Content-Type" = "application/json"
}

Write-Host "Creating HX-Citadel-Delta project with Agile process template..." -ForegroundColor Cyan

# Create project with Agile process template
$projectBody = @{
    name = $projectName
    description = "Citadel V2 Data Ingestion Platform - Agile Project Management"
    visibility = "private"
    capabilities = @{
        versioncontrol = @{
            sourceControlType = "Git"
        }
        processTemplate = @{
            templateTypeId = "adcc42ab-9882-485e-a3ed-7678f01f66bc"  # Agile process template ID
        }
    }
} | ConvertTo-Json

$projectUri = "https://dev.azure.com/$organization/_apis/projects?api-version=7.1-preview.4"

try {
    Write-Host "Creating project: $projectName..." -ForegroundColor Yellow
    $projectResponse = Invoke-RestMethod -Uri $projectUri -Method 'POST' -Headers $headers -Body $projectBody
    
    Write-Host "🎉 PROJECT CREATED SUCCESSFULLY!" -ForegroundColor Green
    Write-Host "Project Name: $($projectResponse.name)" -ForegroundColor White
    Write-Host "Project ID: $($projectResponse.id)" -ForegroundColor White
    Write-Host "State: $($projectResponse.state)" -ForegroundColor White
    Write-Host "Visibility: $($projectResponse.visibility)" -ForegroundColor White
    
    # Save project data
    $projectData = @{
        Name = $projectResponse.name
        Id = $projectResponse.id
        State = $projectResponse.state
        Visibility = $projectResponse.visibility
        Organization = $organization
        CreatedDate = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        ProcessTemplate = "Agile"
    }
    
    $projectData | ConvertTo-Json | Out-File "out/hx-citadel-delta-project.json"
    Write-Host "Project data saved to out/hx-citadel-delta-project.json" -ForegroundColor Green
    
    Write-Host "`nProject URLs:" -ForegroundColor Yellow
    Write-Host "Project: https://dev.azure.com/$organization/$projectName" -ForegroundColor Cyan
    Write-Host "Epic Board: https://dev.azure.com/$organization/$projectName/_boards/board/t/$projectName%20Team/Epics" -ForegroundColor Cyan
    
    Write-Host "`nNext Steps:" -ForegroundColor Yellow
    Write-Host "1. Wait for project initialization (2-3 minutes)" -ForegroundColor White
    Write-Host "2. Run: .\Create-Epic-1-HX-Citadel-Delta.ps1 -PatToken '$pat'" -ForegroundColor White
    Write-Host "3. Epic 1 will be created with proper Agile work item types" -ForegroundColor White
    
} catch {
    Write-Host "❌ Failed to create project: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $errorResponse = $_.Exception.Response.GetResponseStream()
        $streamReader = New-Object System.IO.StreamReader($errorResponse)
        $errorMessage = $streamReader.ReadToEnd()
        Write-Host "Error Details: $errorMessage" -ForegroundColor Yellow
    }
}

Write-Host "`nProject Creation Complete!" -ForegroundColor Cyan

