# Create Epic 1 using Azure CLI with Service Principal
# Based on: https://learn.microsoft.com/en-us/azure/devops/integrate/how-to/call-rest-api?view=azure-devops

Write-Host "Creating Epic 1 using Azure CLI with Service Principal..." -ForegroundColor Cyan

# Step 1: Set environment variables
Write-Host "1. Setting up Service Principal credentials..." -ForegroundColor Yellow

$env:ARM_CLIENT_ID = "74bcb950-ec53-4672-a936-602babb8fb66"
$env:ARM_CLIENT_SECRET = "YOUR_AZURE_AD_CLIENT_SECRET_HERE"
$env:ARM_TENANT_ID = "0487600e-01cb-4a3a-b857-362ca50ea92c"

Write-Host "✅ Service Principal credentials set" -ForegroundColor Green

# Step 2: Login with service principal
Write-Host "`n2. Logging in with Service Principal..." -ForegroundColor Yellow

try {
    $loginResult = az login --service-principal -u $env:ARM_CLIENT_ID -p $env:ARM_CLIENT_SECRET --tenant $env:ARM_TENANT_ID
    Write-Host "✅ Successfully logged in with Service Principal" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to login: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Step 3: Configure Azure DevOps
Write-Host "`n3. Configuring Azure DevOps..." -ForegroundColor Yellow

try {
    az devops configure --defaults organization=https://dev.azure.com/hana-x project=HX-Citadel-Delta
    Write-Host "✅ Azure DevOps configured" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to configure Azure DevOps: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Step 4: Create Epic 1
Write-Host "`n4. Creating Epic 1..." -ForegroundColor Yellow

$epicTitle = "Epic 1: Infrastructure Foundation"
$epicDescription = "15-server canonical deployment with complete monitoring and security infrastructure. Foundation for all Citadel V2 services. Timeline: 4 weeks. Tasks: 58 (T001-T058). Priority: Critical."

try {
    $epicResult = az boards work-item create --type Epic --title $epicTitle --description $epicDescription --fields "Microsoft.VSTS.Common.Priority=Critical" "Microsoft.VSTS.Common.BusinessValue=10" "System.Tags=infrastructure;foundation;critical;citadel-v2;15-servers"
    
    Write-Host "🎉 EPIC 1 CREATED SUCCESSFULLY!" -ForegroundColor Green
    Write-Host "Result: $epicResult" -ForegroundColor White
    
    # Save epic data
    $epicData = @{
        Title = $epicTitle
        Description = $epicDescription
        ProjectName = "HX-Citadel-Delta"
        Organization = "hana-x"
        CreatedDate = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        Method = "Azure CLI with Service Principal"
        Result = $epicResult
    }
    
    $epicData | ConvertTo-Json | Out-File "out/epic-1-azure-cli-success.json"
    Write-Host "Epic data saved to out/epic-1-azure-cli-success.json" -ForegroundColor Green
    
    Write-Host "`nEpic 1 Details:" -ForegroundColor Yellow
    Write-Host "  - 58 Infrastructure Tasks (T001-T058)" -ForegroundColor White
    Write-Host "  - 4-Week Timeline (Sprints 1-2)" -ForegroundColor White
    Write-Host "  - Critical Priority" -ForegroundColor White
    Write-Host "  - Business Value: 10/10" -ForegroundColor White
    Write-Host "  - Foundation for all Citadel V2 services" -ForegroundColor White
    
    Write-Host "`nAzure DevOps URLs:" -ForegroundColor Yellow
    Write-Host "Project: https://dev.azure.com/hana-x/HX-Citadel-Delta" -ForegroundColor Cyan
    Write-Host "Epic Board: https://dev.azure.com/hana-x/HX-Citadel-Delta/_boards/board/t/HX-Citadel-Delta%20Team/Epics" -ForegroundColor Cyan
    
    Write-Host "`n✅ API INTEGRATION WORKING! Epic 1 is now on the board!" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Failed to create Epic 1: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Message -like "*TF401444*") {
        Write-Host "`nThe service principal needs to be granted access to Azure DevOps." -ForegroundColor Yellow
        Write-Host "Go to: https://dev.azure.com/hana-x/_settings/users" -ForegroundColor Cyan
        Write-Host "Add: 74bcb950-ec53-4672-a936-602babb8fb66@hana-x" -ForegroundColor White
        Write-Host "Set access level to: Stakeholder or Basic" -ForegroundColor White
        Write-Host "Add to project: HX-Citadel-Delta" -ForegroundColor White
    }
}

Write-Host "`nEpic Creation Complete!" -ForegroundColor Cyan

