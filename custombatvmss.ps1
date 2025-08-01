reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v "NV Domain" /t REG_SZ /d "eastus2.cloudapp.azure.com" /f
Invoke-WebRequest https://github.com/jqlang/jq/releases/download/jq-1.8.1/jq-windows-amd64.exe -outfile C:\Windows\jq.exe -UseBasicParsing
