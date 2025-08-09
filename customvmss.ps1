Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"  -Name "UserAuthentication"  -Value 0  -Type DWord
Invoke-WebRequest https://github.com/jqlang/jq/releases/download/jq-1.8.1/jq-windows-amd64.exe -outfile C:\Windows\jq.exe -UseBasicParsing
$response = Invoke-WebRequest -Uri "http://169.254.169.254/metadata/instance/compute?api-version=2021-02-01&format=json" -Headers @{ "Metadata" = "true" } -Method GET -outfile C:\prefile.json -UseBasicParsing
$content = Get-Content "C:\prefile.json"
$name = $content | jq '.name'
$computername = $content | jq '.vmScaleSetName' -r 
$id = $name.split("_")[1].split('"')[0]
$newname = "vm$id"
Rename-Computer -NewName $newname 
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"  -Name "NV Domain" -Value "$computername.eastus2.cloudapp.azure.com"  -Type String
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"  -Name "Domain" -Value "$computername.eastus2.cloudapp.azure.com"  -Type String
# Disable and enable the adapter
Disable-NetAdapter -Name $adapter.Name -Confirm:$false
Start-Sleep -Seconds 2
Enable-NetAdapter -Name $adapter.Name -Confirm:$false
netsh int ip reset
ipconfig /registerdns
Restart-Computer -Force
