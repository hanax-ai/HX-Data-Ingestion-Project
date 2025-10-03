# Check available projects and wait for initialization

$organization = "hana-x"
$pat = "YOUR_AZURE_DEVOPS_PAT_TOKEN_HERE"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

$headers = @{
    "Authorization" = "Basic $base64AuthInfo"
    "Content-Type" = "application/json"
}

Write-Host "Checking available projects..." -ForegroundColor Cyan

# List all projects
try {
    $projectsUri = "https://dev.azure.com/$organization/_apis/projects?api-version=7.1-preview.4"
    $projectsResponse = Invoke-RestMethod -Uri $projectsUri -Method 'GET' -Headers $headers
    
    Write-Host "Found $($projectsResponse.count) projects:" -ForegroundColor Green
    foreach ($project in $projectsResponse.value) {
        $status = if ($project.name -eq "HX-Citadel-Delta") { "NEW AGILE PROJECT" } else { "EXISTING" }
        Write-Host "  $status - $($project.name)" -ForegroundColor White
        Write-Host "    ID: $($project.id)" -ForegroundColor Gray
        Write-Host "    State: $($project.state)" -ForegroundColor Gray
        Write-Host "    Visibility: $($project.visibility)" -ForegroundColor Gray
        Write-Host ""
    }
    
    # Check if HX-Citadel-Delta exists and is ready
    $hxProject = $projectsResponse.value | Where-Object { $_.name -eq "HX-Citadel-Delta" }
    if ($hxProject) {
        Write-Host "✅ HX-Citadel-Delta project found!" -ForegroundColor Green
        Write-Host "State: $($hxProject.state)" -ForegroundColor White
        
        if ($hxProject.state -eq "wellFormed") {
            Write-Host "✅ Project is ready for Epic creation!" -ForegroundColor Green
            Write-Host "Run: .\Create-Epic-1-HX-Citadel-Delta.ps1 -PatToken '$pat'" -ForegroundColor Cyan
        } else {
            Write-Host "⏳ Project is still initializing. Wait a few more minutes." -ForegroundColor Yellow
            Write-Host "Current state: $($hxProject.state)" -ForegroundColor White
        }
    } else {
        Write-Host "❌ HX-Citadel-Delta project not found!" -ForegroundColor Red
        Write-Host "Run: .\Create-HX-Citadel-Delta-Project.ps1" -ForegroundColor Yellow
    }
    
} catch {
    Write-Host "❌ Failed to list projects: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`nProject Check Complete!" -ForegroundColor Cyan

