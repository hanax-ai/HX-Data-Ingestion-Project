#!/usr/bin/env pwsh
# Azure DevOps Project Initialization Script
# Step 1: Initialize and validate Azure DevOps project settings

[CmdletBinding()]
param(
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "  Step 1: Initialize Azure DevOps Project" -ForegroundColor Cyan
Write-Host "===========================================================" -ForegroundColor Cyan

# Environment variables
$AZDO_ORG_URL = $env:AZDO_ORG_URL
$AZDO_PROJECT = $env:AZDO_PROJECT

if (-not $AZDO_ORG_URL) {
    Write-Host "❌ AZDO_ORG_URL environment variable not set" -ForegroundColor Red
    Write-Host "   Set with: `$env:AZDO_ORG_URL = 'https://dev.azure.com/hana-x'" -ForegroundColor Yellow
    exit 1
}

if (-not $AZDO_PROJECT) {
    Write-Host "❌ AZDO_PROJECT environment variable not set" -ForegroundColor Red
    Write-Host "   Set with: `$env:AZDO_PROJECT = 'HX-Data-Ingestion-Project'" -ForegroundColor Yellow
    exit 1
}

Write-Host "Organization: $AZDO_ORG_URL" -ForegroundColor Green
Write-Host "Project: $AZDO_PROJECT" -ForegroundColor Green

# Create output directory
if (-not (Test-Path "out")) {
    New-Item -ItemType Directory -Path "out" | Out-Null
    Write-Host "✅ Created output directory: out/" -ForegroundColor Green
}

# Configure Azure DevOps defaults
Write-Host "`nConfiguring Azure DevOps defaults..." -ForegroundColor Yellow
az devops configure --defaults organization=$AZDO_ORG_URL project=$AZDO_PROJECT

# Verify project exists and get details
Write-Host "`nVerifying project..." -ForegroundColor Yellow
try {
    $project = az devops project show --project $AZDO_PROJECT --output json | ConvertFrom-Json
    
    Write-Host "✅ Project verified:" -ForegroundColor Green
    Write-Host "   Name: $($project.name)" -ForegroundColor White
    Write-Host "   Process: $($project.capabilities.processTemplate.templateName)" -ForegroundColor White
    Write-Host "   Visibility: $($project.visibility)" -ForegroundColor White
    Write-Host "   State: $($project.state)" -ForegroundColor White
    
    # Verify Agile process
    if ($project.capabilities.processTemplate.templateName -ne "Agile") {
        Write-Host "⚠️  Warning: Project is not using Agile process template" -ForegroundColor Yellow
        Write-Host "   Current: $($project.capabilities.processTemplate.templateName)" -ForegroundColor Yellow
        Write-Host "   Recommended: Agile" -ForegroundColor Yellow
    } else {
        Write-Host "✅ Agile process template confirmed" -ForegroundColor Green
    }
    
} catch {
    Write-Host "❌ Failed to verify project: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "   Check that project '$AZDO_PROJECT' exists in organization" -ForegroundColor Yellow
    exit 1
}

# Check project features
Write-Host "`nChecking project features..." -ForegroundColor Yellow
try {
    $features = az devops project show --project $AZDO_PROJECT --include capabilities --output json | ConvertFrom-Json
    
    $requiredFeatures = @{
        "Boards" = "Work item tracking and agile boards"
        "Repos" = "Git repository hosting"
        "Pipelines" = "CI/CD automation"
        "Wiki" = "Project documentation"
        "Test Plans" = "Test case management"
    }
    
    foreach ($feature in $requiredFeatures.GetEnumerator()) {
        $featureName = $feature.Key
        $featureDesc = $feature.Value
        
        if ($features.capabilities.$featureName.enabled) {
            Write-Host "✅ $featureName enabled - $featureDesc" -ForegroundColor Green
        } else {
            Write-Host "⚠️  $featureName disabled - $featureDesc" -ForegroundColor Yellow
        }
    }
    
} catch {
    Write-Host "⚠️  Could not check project features: $($_.Exception.Message)" -ForegroundColor Yellow
}

# Test work item creation permissions
Write-Host "`nTesting work item creation permissions..." -ForegroundColor Yellow
try {
    $testWi = az boards work-item create --type Task --title "Test Work Item - Delete Me" --output json 2>$null | ConvertFrom-Json
    
    if ($testWi) {
        Write-Host "✅ Work item creation permissions verified" -ForegroundColor Green
        Write-Host "   Test work item created: #$($testWi.id)" -ForegroundColor White
        
        # Clean up test work item
        az boards work-item delete --id $testWi.id --yes --destroy 2>$null | Out-Null
        Write-Host "✅ Test work item cleaned up" -ForegroundColor Green
    } else {
        Write-Host "❌ Work item creation failed - check PAT permissions" -ForegroundColor Red
        Write-Host "   Required scopes: Work Items (Read, Write)" -ForegroundColor Yellow
        exit 1
    }
    
} catch {
    Write-Host "❌ Work item creation test failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "   Check PAT has Work Items (Write) scope" -ForegroundColor Yellow
    exit 1
}

# Save project configuration
$projectConfig = @{
    Organization = $AZDO_ORG_URL
    Project = $AZDO_PROJECT
    ProjectId = $project.id
    ProcessTemplate = $project.capabilities.processTemplate.templateName
    Visibility = $project.visibility
    State = $project.state
    Timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
}

$projectConfig | ConvertTo-Json | Out-File "out/project-config.json"
Write-Host "✅ Project configuration saved to out/project-config.json" -ForegroundColor Green

Write-Host "`n===========================================================" -ForegroundColor Cyan
Write-Host "  ✅ PROJECT INITIALIZATION COMPLETE" -ForegroundColor Green
Write-Host "===========================================================" -ForegroundColor Cyan

Write-Host "`nNext Steps:" -ForegroundColor Yellow
Write-Host "  1. Run: 02-create-area-paths.ps1" -ForegroundColor White
Write-Host "  2. Run: 03-create-iterations.ps1" -ForegroundColor White
Write-Host "  3. Run: 04-create-epics.ps1" -ForegroundColor White

Write-Host "`nProject URL: $AZDO_ORG_URL/$AZDO_PROJECT" -ForegroundColor Cyan
