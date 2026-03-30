# Please note that this is for local use only (i.e., not tracked by git)
# Copy from deploy.example.ps1 and fill in your paths

$ErrorActionPreference = "Stop"
$ProjectDir = "C:\inetpub\wwwroot\dsiweb\paper_demos\awm-bench"
$BasePath   = "/awm-bench/"

Write-Host "=> Pulling latest..." -ForegroundColor Cyan
Set-Location $ProjectDir
git pull

Write-Host "=> Installing dependencies..." -ForegroundColor Cyan
npm install

Write-Host "=> Building..." -ForegroundColor Cyan
$env:VITE_BASE_PATH = $BasePath
npm run build

Write-Host "=> Copying web.config..." -ForegroundColor Cyan
Copy-Item -Force "$ProjectDir\web.config" "$ProjectDir\dist\web.config"

Write-Host "Done." -ForegroundColor Green
