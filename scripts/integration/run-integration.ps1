# HX Data Ingestion Project - Azure DevOps Integration
# PowerShell Master Execution Script
# Run this script to set up complete ADO ↔ GitHub integration

#Requires -Version 7.0

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [switch]$SkipPrereqs,
    
    [Parameter(Mandatory=$false)]
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

# Banner
Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "  HX Data Ingestion Project" -ForegroundColor Cyan
Write-Host "  Azure DevOps ↔ GitHub Integration Setup" -ForegroundColor Cyan
Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host ""

# Create output directory
$OutDir = "out"
if (!(Test-Path $OutDir)) {
    New-Item -ItemType Directory -Path $OutDir | Out-Null
}

# Configuration
$Config = @{
    # Azure DevOps
    AZDO_ORG = "hana-x"
    AZDO_PROJECT = "HX-Data-Ingestion-Project"
    AZDO_API_VER = "7.1-preview.3"
    AZDO_USER = "agent0@hana-x.ai"
    
    # GitHub
    GH_OWNER = "hanax-ai"
    GH_REPO = "HX-Data-Ingestion-Project"
    DEFAULT_BRANCH = "main"
    
    # Names
    SERVICE_CONNECTION_NAME = "GitHub-Connection-HX-DIP"
    PIPELINE_NAME = "hx-dip-ci"
}

$Config.AZDO_ORG_URL = "https://dev.azure.com/$($Config.AZDO_ORG)"

Write-Host "Configuration:" -ForegroundColor Yellow
$Config.GetEnumerator() | Sort-Object Name | ForEach-Object {
    Write-Host "  $($_.Key): $($_.Value)" -ForegroundColor Gray
}
Write-Host ""

# Check for required secrets
Write-Host "Checking for required secrets..." -ForegroundColor Yellow

if (-not $env:AZDO_PAT) {
    Write-Host "❌ ERROR: AZDO_PAT environment variable not set" -ForegroundColor Red
    Write-Host "FIX: `$env:AZDO_PAT = '<your-azure-devops-pat>'" -ForegroundColor Yellow
    exit 1
}

if (-not $env:GITHUB_TOKEN) {
    Write-Host "❌ ERROR: GITHUB_TOKEN environment variable not set" -ForegroundColor Red
    Write-Host "FIX: `$env:GITHUB_TOKEN = '<your-github-token>'" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Required secrets found" -ForegroundColor Green
Write-Host ""

# Step 1: Verify Tools
Write-Host "Step 1: Verifying Required Tools..." -ForegroundColor Cyan

$tools = @("az", "gh", "jq", "git")
foreach ($tool in $tools) {
    if (Get-Command $tool -ErrorAction SilentlyContinue) {
        Write-Host "  ✅ $tool installed" -ForegroundColor Green
    } else {
        Write-Host "  ❌ $tool NOT installed" -ForegroundColor Red
        Write-Host "     Install $tool and try again" -ForegroundColor Yellow
        
        if ($tool -eq "az") {
            Write-Host "     Download: https://aka.ms/installazurecliwindows" -ForegroundColor Yellow
        } elseif ($tool -eq "gh") {
            Write-Host "     Install: winget install GitHub.cli" -ForegroundColor Yellow
        } elseif ($tool -eq "jq") {
            Write-Host "     Install: winget install jqlang.jq" -ForegroundColor Yellow
        }
        
        if (-not $SkipPrereqs) {
            exit 1
        }
    }
}

# Install/Update Azure DevOps extension
Write-Host "  Installing/Updating Azure DevOps extension..." -ForegroundColor Gray
az extension add --name azure-devops 2>$null || az extension update --name azure-devops
Write-Host "  ✅ Azure DevOps extension ready" -ForegroundColor Green
Write-Host ""

# Step 2: Authentication
Write-Host "Step 2: Authenticating with Services..." -ForegroundColor Cyan

# Configure Azure DevOps defaults
az devops configure --defaults organization="$($Config.AZDO_ORG_URL)" project="$($Config.AZDO_PROJECT)"
Write-Host "  ✅ Azure DevOps configured" -ForegroundColor Green

# Authenticate Azure DevOps
Write-Host "  Authenticating with Azure DevOps..." -ForegroundColor Gray
$env:AZDO_PAT | az devops login --organization $Config.AZDO_ORG_URL --only-show-errors
Write-Host "  ✅ Azure DevOps authenticated" -ForegroundColor Green

# Authenticate GitHub
Write-Host "  Authenticating with GitHub..." -ForegroundColor Gray
$env:GITHUB_TOKEN | gh auth login --with-token
Write-Host "  ✅ GitHub authenticated" -ForegroundColor Green

# Sanity checks
Write-Host "  Verifying access..." -ForegroundColor Gray
az devops project show --project $Config.AZDO_PROJECT -o table | Out-Null
Write-Host "  ✅ Azure DevOps project accessible" -ForegroundColor Green

gh repo view "$($Config.GH_OWNER)/$($Config.GH_REPO)" | Out-Null
Write-Host "  ✅ GitHub repository accessible" -ForegroundColor Green
Write-Host ""

if ($DryRun) {
    Write-Host "🔍 DRY RUN MODE - Stopping before making changes" -ForegroundColor Yellow
    Write-Host "Configuration validated successfully" -ForegroundColor Green
    exit 0
}

# Step 3: Create Seed Work Item
Write-Host "Step 3: Creating Seed Work Item..." -ForegroundColor Cyan

$wiJson = az boards work-item create --type "Product Backlog Item" `
  --title "DIP: Wire ADO ↔ GitHub integration" `
  --description "Integrate Azure DevOps Boards with GitHub repository for automated work item management and CI/CD pipeline" `
  --output json | ConvertFrom-Json

$WI_ID = $wiJson.id
Write-Host "  ✅ Seed Work Item created: AB#$WI_ID" -ForegroundColor Green
$WI_ID | Out-File -FilePath "out/seed-wi-id.txt" -NoNewline
Write-Host "  📝 View: $($Config.AZDO_ORG_URL)/$($Config.AZDO_PROJECT)/_workitems/edit/$WI_ID" -ForegroundColor Gray
Write-Host ""

# Step 4: Create Service Connection
Write-Host "Step 4: Creating GitHub Service Connection..." -ForegroundColor Cyan

$scJson = az devops service-endpoint github create `
  --name $Config.SERVICE_CONNECTION_NAME `
  --github-url "https://github.com/$($Config.GH_OWNER)/$($Config.GH_REPO)" `
  --github-access-token $env:GITHUB_TOKEN `
  --organization $Config.AZDO_ORG_URL `
  --project $Config.AZDO_PROJECT `
  --output json | ConvertFrom-Json

$SC_ID = $scJson.id
Write-Host "  ✅ Service Connection created: $SC_ID" -ForegroundColor Green
$SC_ID | Out-File -FilePath "out/service-connection-id.txt" -NoNewline

# Enable for all pipelines
az devops service-endpoint update --id $SC_ID `
  --enable-for-all true `
  --organization $Config.AZDO_ORG_URL `
  --project $Config.AZDO_PROJECT `
  -o table | Out-Null
Write-Host "  ✅ Service Connection enabled for all pipelines" -ForegroundColor Green
Write-Host ""

Write-Host "✅✅✅ Azure DevOps Integration Complete ✅✅✅" -ForegroundColor Green
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "1. Run: .\scripts\integration\create-github-workflows.ps1" -ForegroundColor White
Write-Host "2. Run: .\scripts\integration\setup-branch-protection.ps1" -ForegroundColor White
Write-Host "3. Test by creating a GitHub issue" -ForegroundColor White
Write-Host ""


