# ESB32 Dictation Button - Windows Setup Script
# 
# This script installs all required software for ESP32-S3 development:
# - Arduino IDE
# - Git (required for ESP32 board manager)
# - Winget (if not already installed)
#
# Run this script as Administrator in PowerShell
#
# Author: TurnerWorks
# Repository: https://github.com/lozturner/ESB32-Dictation-Button

# Check if running as Administrator
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "ERROR: This script must be run as Administrator" -ForegroundColor Red
    Write-Host "Right-click PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "ESB32 Dictation Button Setup" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Check for winget
Write-Host "[1/3] Checking for winget..." -ForegroundColor Yellow
if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "  winget not found. Installing App Installer..." -ForegroundColor Red
    Write-Host "  Opening Microsoft Store - please install 'App Installer'" -ForegroundColor Yellow
    Start-Process "ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1"
    Write-Host ""
    Write-Host "After installing App Installer, please re-run this script." -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host "  ✓ winget found" -ForegroundColor Green
Write-Host ""

# Install Arduino IDE
Write-Host "[2/3] Installing Arduino IDE..." -ForegroundColor Yellow
$arduinoInstalled = winget list --id ArduinoSA.IDE.stable --exact 2>&1
if ($arduinoInstalled -match "ArduinoSA.IDE.stable") {
    Write-Host "  Arduino IDE already installed" -ForegroundColor Green
} else {
    Write-Host "  Installing Arduino IDE..." -ForegroundColor Cyan
    winget install --id=ArduinoSA.IDE.stable -e --accept-source-agreements --accept-package-agreements --silent
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ Arduino IDE installed successfully" -ForegroundColor Green
    } else {
        Write-Host "  ✗ Arduino IDE installation failed" -ForegroundColor Red
    }
}
Write-Host ""

# Install Git
Write-Host "[3/3] Installing Git..." -ForegroundColor Yellow
$gitInstalled = winget list --id Git.Git --exact 2>&1
if ($gitInstalled -match "Git.Git") {
    Write-Host "  Git already installed" -ForegroundColor Green
} else {
    Write-Host "  Installing Git..." -ForegroundColor Cyan
    winget install --id=Git.Git -e --accept-source-agreements --accept-package-agreements --silent
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ Git installed successfully" -ForegroundColor Green
    } else {
        Write-Host "  ✗ Git installation failed" -ForegroundColor Red
    }
}
Write-Host ""

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "Installation Complete!" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Restart your terminal (or log out and back in)" -ForegroundColor White
Write-Host "2. Open Arduino IDE" -ForegroundColor White
Write-Host "3. Follow the README instructions to:" -ForegroundColor White
Write-Host "   - Add ESP32 board support" -ForegroundColor White
Write-Host "   - Upload the ESB32_Dictation.ino sketch" -ForegroundColor White
Write-Host "   - Connect your ESP32-S3 and start dictating!" -ForegroundColor White
Write-Host ""
Write-Host "Repository: https://github.com/lozturner/ESB32-Dictation-Button" -ForegroundColor Cyan
Write-Host ""

Read-Host "Press Enter to exit"
