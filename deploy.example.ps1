# deploy.example.ps1
# Copy this to deploy.ps1 and fill in your own values
# deploy.ps1 is gitignored

$ErrorActionPreference = "Stop"
$ProjectDir = "YOUR_PROJECT_PATH_HERE"   # e.g. C:\inetpub\wwwroot\mysite\awm-bench
$BasePath   = "/YOUR_URL_BASE_PATH/"     # e.g. /awm-bench/

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

Write-Host " Done." -ForegroundColor Green
```

**3. Update `.gitignore`** — add one line:
```
node_modules/
dist/
.env
.env.local
.DS_Store
*.local
deploy.ps1