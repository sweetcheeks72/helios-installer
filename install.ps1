$ErrorActionPreference = "Stop"
Write-Host ""
Write-Host "  helios." -ForegroundColor Cyan
Write-Host "  AI Operating Layer" -ForegroundColor DarkGray
Write-Host ""
try {
    $nodeVersion = (node -v) -replace 'v', ''
    $major = [int]($nodeVersion.Split('.')[0])
    if ($major -lt 18) {
        Write-Host "  Error: Node.js 18+ required (found v$nodeVersion)." -ForegroundColor Red
        exit 1
    }
    Write-Host "  Node.js:  v$nodeVersion" -ForegroundColor White
} catch {
    Write-Host "  Error: Node.js is required. Install from https://nodejs.org" -ForegroundColor Red
    exit 1
}
Write-Host ""
Write-Host "  Installing..." -ForegroundColor DarkGray
npm install -g @familiar/pi 2>&1 | Select-Object -Last 1
Write-Host ""
Write-Host "  Installed" -ForegroundColor Green
Write-Host ""
Write-Host "  Get started:" -ForegroundColor DarkGray
Write-Host "  helios config set ANTHROPIC_API_KEY sk-..." -ForegroundColor Cyan
Write-Host '  helios "your first task"' -ForegroundColor Cyan
Write-Host ""
