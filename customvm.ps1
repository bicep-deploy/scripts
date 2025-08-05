reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 1 /f
$response = Invoke-WebRequest -Uri "http://169.254.169.254/metadata/instance/compute?api-version=2021-02-01&format=json" -Headers @{ "Metadata" = "true" } -Method GET -outfile C:\prefile.json -UseBasicParsing
reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v "NV Domain" /t REG_SZ /d "eastus2.cloudapp.azure.com" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f
