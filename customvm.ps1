$response = Invoke-WebRequest -Uri "http://169.254.169.254/metadata/instance/compute?api-version=2021-02-01&format=json" -Headers @{ "Metadata" = "true" } -Method GET -outfile C:\prefile.json -UseBasicParsing
#reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v "NV Domain" /t REG_SZ /d "eastus2.cloudapp.azure.com" /f
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"  -Name "NV Domain" -Value "eastus2.cloudapp.azure.com"  -Type String
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"  -Name "UserAuthentication"  -Value 0  -Type DWord
$adapter = Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -First 1
# Disable and enable the adapter
Disable-NetAdapter -Name $adapter.Name -Confirm:$false
Start-Sleep -Seconds 2
Enable-NetAdapter -Name $adapter.Name -Confirm:$false
netsh int ip reset
ipconfig /registerdns
