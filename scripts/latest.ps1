$repo = "lolitee/adobe-discord-rpc"
$name = "discord rpc"

$releases = "https://api.github.com/repos/$repo/releases"

Write-Host Getting latest version
$tag = (Invoke-WebRequest $releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name
$download = (Invoke-WebRequest $releases -UseBasicParsing | ConvertFrom-Json)[0].assets[0].browser_download_url
$body = (Invoke-WebRequest $releases -UseBasicParsing | ConvertFrom-Json)[0].body

If (Test-Path $name){
    Remove-Item $name -Recurse -Force
    Write-Host Removing [$name]
}

Write-Host $download
Write-Host $body -ForegroundColor green

$zip = "$name-$tag.zip"
$dir = "$name-$tag"

Write-Host Downloading latest version
Invoke-WebRequest $download -Out $zip -UseBasicParsing

Write-Host Extracting files
Expand-Archive $zip -Force

Remove-Item $name -Recurse -Force -ErrorAction SilentlyContinue 

Move-Item $dir\$name -Destination $name -Force

Remove-Item $zip -Force
Remove-Item $dir -Recurse -Force

Write-Host "Make sure to restart your Adobe app, if you've updated it through the panel!"

Remove-Item -Path $MyInvocation.MyCommand.Source

PAUSE
