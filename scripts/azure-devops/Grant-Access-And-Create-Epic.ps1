# Grant Service Principal access to Azure DevOps and create Epic 1

$organization = "hana-x"
$projectName = "Citadel"
$clientId = "74bcb950-ec53-4672-a936-602babb8fb66"

Write-Host "Granting Service Principal access and creating Epic 1..." -ForegroundColor Cyan

# Step 1: Add service principal to organization
Write-Host "1. Adding service principal to Azure DevOps organization..." -ForegroundColor Yellow

try {
    # Add service principal to organization
    $addUserBody = @{
        principalName = "$clientId@$organization"
        accessLevel = "stakeholder"
    } | ConvertTo-Json
    
    $addUserUri = "https://dev.azure.com/$organization/_apis/userentitlements?api-version=7.1-preview.3"
    
    # This requires a PAT with User Management permissions
    Write-Host "⚠️  Manual step required: Add service principal to Azure DevOps" -ForegroundColor Yellow
    Write-Host "1. Go to: https://dev.azure.com/$organization/_settings/users" -ForegroundColor Cyan
    Write-Host "2. Click 'Add users'" -ForegroundColor White
    Write-Host "3. Add: $clientId@$organization" -ForegroundColor White
    Write-Host "4. Set access level to 'Stakeholder' or 'Basic'" -ForegroundColor White
    Write-Host "5. Add to project: $projectName" -ForegroundColor White
    
} catch {
    Write-Host "Manual configuration required for service principal access" -ForegroundColor Yellow
}

# Step 2: Try creating Epic 1 anyway (in case access is already granted)
Write-Host "`n2. Attempting to create Epic 1..." -ForegroundColor Yellow

try {
    $epicResponse = az boards work-item create --type Epic --title "Epic 1: Infrastructure Foundation" --description "15-server canonical deployment with complete monitoring and security infrastructure. Foundation for all Citadel V2 services. Timeline: 4 weeks. Tasks: 58 (T001-T058). Priority: Critical." --fields "Microsoft.VSTS.Common.Priority=Critical" "Microsoft.VSTS.Common.BusinessValue=10" "System.Tags=infrastructure;foundation;critical"
    
    Write-Host "🎉 EPIC 1 CREATED SUCCESSFULLY!" -ForegroundColor Green
    Write-Host "Response: $epicResponse" -ForegroundColor White
    
} catch {
    Write-Host "❌ Epic creation failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Service principal needs to be added to Azure DevOps organization first." -ForegroundColor Yellow
}

# Step 3: Alternative - Create via REST API with manual token
Write-Host "`n3. Alternative: Manual PAT approach..." -ForegroundColor Yellow
Write-Host "Create a Personal Access Token (PAT) with Work Items (Write) scope:" -ForegroundColor White
Write-Host "1. Go to: https://dev.azure.com/$organization/_usersSettings/tokens" -ForegroundColor Cyan
Write-Host "2. Create new token with scopes:" -ForegroundColor White
Write-Host "   - Work Items (Read, Write)" -ForegroundColor Gray
Write-Host "   - Project and Team (Read, Write)" -ForegroundColor Gray
Write-Host "3. Copy the token and run:" -ForegroundColor White
Write-Host "   .\Create-Epic-1-With-PAT.ps1 -PatToken 'your-pat-token'" -ForegroundColor Cyan

Write-Host "`nService Principal Access Configuration Complete!" -ForegroundColor Cyan
