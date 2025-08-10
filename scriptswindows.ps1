mkdir c:\buildArtifacts
echo Azure-Image-Builder-Was-Here  > c:\buildArtifacts\azureImageBuilder.txt

$sshDir = "$HOME\.ssh"
if (-not (Test-Path $sshDir)) {
    New-Item -ItemType Directory -Path $sshDir | Out-Null
}

# Save the private key from an environment variable (similar to ${{ secrets.PRIVATE_KEY }})
$privateKey = $env:PRIVATE_KEY
$privateKeyPath = Join-Path $sshDir "private_tf_modules"
Set-Content -Path $privateKeyPath -Value $privateKey -NoNewline

# Set permissions to read-only for the owner
icacls $privateKeyPath /inheritance:r /grant:r "$($env:USERNAME):R"

# Create the SSH config file
$sshConfig = @"
Host github.com
    User git
    Hostname github.com
    IdentityFile $privateKeyPath
    StrictHostKeyChecking no
"@
Set-Content -Path (Join-Path $sshDir "config") -Value $sshConfig -NoNewline

# Display confirmation
Write-Host "Created private key"
Get-Content (Join-Path $sshDir "config")

Write-Host "File ssh"
Get-Content $privateKeyPath
