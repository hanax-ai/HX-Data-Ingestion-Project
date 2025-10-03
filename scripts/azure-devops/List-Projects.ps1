# List all available projects

$organization = "hana-x"
$pat = "3IbP1DkWs12aNa3Qq6P7PZVwnjEyrvDquojqPLlfDkxor0U8P6mtJQQJ99BJACAAAAAAX1qVAAASAZDO1Wp2"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

$headers = @{
    "Authorization"  = "Basic $base64AuthInfo"
    "Content-Type"   = "application/json"
}

Write-Host "Listing all projects in organization: $organization" -ForegroundColor Cyan

try {
    $projectsUri = "https://dev.azure.com/$organization/_apis/projects?api-version=7.1-preview.4"
    $projectsResponse = Invoke-RestMethod -Uri $projectsUri -Method 'GET' -Headers $headers
    
    Write-Host "Found $($projectsResponse.count) projects:" -ForegroundColor Green
    
    foreach ($project in $projectsResponse.value) {
        $status = if ($project.name -eq "Citadel") { "NEW CITADEL" } else { "EXISTING" }
        Write-Host "  $status - $($project.name)" -ForegroundColor White
        Write-Host "    ID: $($project.id)" -ForegroundColor Gray
        Write-Host "    State: $($project.state)" -ForegroundColor Gray
        Write-Host "    Visibility: $($project.visibility)" -ForegroundColor Gray
        Write-Host ""
    }
    
} catch {
    Write-Host "Failed to list projects: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "Project URLs:" -ForegroundColor Yellow
Write-Host "Citadel: https://dev.azure.com/$organization/Citadel" -ForegroundColor Cyan
Write-Host "Citadel Epic Board: https://dev.azure.com/$organization/Citadel/_boards/board/t/Citadel%20Team/Epics" -ForegroundColor Cyan
