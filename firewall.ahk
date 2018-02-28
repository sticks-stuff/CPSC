RegRead, firewall_status, HKLM, SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile\AuthorizedApplications\List, [C:\xampp\apache\bin\httpd.exe]
If (!InStr(firewall_status, "Enabled"))
	RegWrite, REG_SZ, HKLM, SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile\AuthorizedApplications\List, [C:\xampp\apache\bin\httpd.exe], [C:\xampp\apache\bin\httpd.exe]:*:Enabled:[Apache]

RegRead, firewall_status, HKLM, SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile\AuthorizedApplications\List, [C:\xampp\mysql\bin\mysqld.exe]
If (!InStr(firewall_status, "Enabled"))
	RegWrite, REG_SZ, HKLM, SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile\AuthorizedApplications\List, [C:\xampp\mysql\bin\mysqld.exe], [C:\xampp\mysql\bin\mysqld.exe]:*:Enabled:[MySQL]
