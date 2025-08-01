reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v "NV Domain" /t REG_SZ /d "eastus2.cloudapp.azure.com" /f
Invoke-WebRequest https://github.com/jqlang/jq/releases/download/jq-1.8.1/jq-windows-amd64.exe -outfile C:\Windows\jq.exe -UseBasicParsing
$response = Invoke-WebRequest -Uri "http://169.254.169.254/metadata/instance/compute?api-version=2021-02-01&format=json" -Headers @{ "Metadata" = "true" } -Method GET
$name=$response.Content | jq '.name'
$computername=$response.Content | jq '.vmScaleSetName' -r 
$id=$name.split("_")[1].split('"')[0]
$newname="vm$id.$computername"
Rename-Computer -NewName $newname -Restart
