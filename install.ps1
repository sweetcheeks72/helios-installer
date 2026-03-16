$ErrorActionPreference = "Stop"
Write-Host ""
Write-Host "  helios." -ForegroundColor Cyan
Write-Host "  AI Operating Layer" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  Helios runs on macOS and Linux." -ForegroundColor White
Write-Host "  On Windows, install WSL first:" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  Step 1: Install WSL (if not already installed)" -ForegroundColor White
Write-Host "    wsl --install" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Step 2: Restart your computer" -ForegroundColor White
Write-Host ""
Write-Host "  Step 3: Open Ubuntu from the Start menu, then run:" -ForegroundColor White
Write-Host '    curl -fsSL https://raw.githubusercontent.com/sweetcheeks72/helios-installer/main/bootstrap.sh | bash' -ForegroundColor Cyan
Write-Host ""

# Check if WSL is available
try {
    $wslStatus = wsl --status 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  WSL detected. Install directly:" -ForegroundColor Green
        Write-Host '    wsl bash -c "curl -fsSL https://raw.githubusercontent.com/sweetcheeks72/helios-installer/main/bootstrap.sh | bash"' -ForegroundColor Cyan
        Write-Host ""
        
        $response = Read-Host "  Install now? (y/N)"
        if ($response -eq 'y' -or $response -eq 'Y') {
            wsl bash -c "curl -fsSL https://raw.githubusercontent.com/sweetcheeks72/helios-installer/main/bootstrap.sh | bash"
        }
    }
} catch {
    Write-Host "  WSL not installed. Run 'wsl --install' in PowerShell as Admin first." -ForegroundColor Yellow
}
Write-Host ""
