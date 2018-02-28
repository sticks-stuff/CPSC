Set WshShell = CreateObject("WScript.Shell") 
WshShell.Run chr(34) & "C:\xampp\htdocs\run.bat" & Chr(34), 0
WshShell.Run chr(34) & "C:\xampp\apache_start.bat" & Chr(34), 0
WshShell.Run chr(34) & "C:\xampp\mysql\bin\mysqld.exe" & Chr(34), 0
Set WshShell = Nothing