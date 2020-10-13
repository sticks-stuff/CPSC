for /D %%D in (".\mysql\data\*.*") do (
    if /I not "%%~nxD"=="mysql" (
        2> nul rd /S /Q "%%~fD"
    )
)
del /Q .\mysql\data\*.*
mysql\bin\mysqld --standalone --console
mysql\bin\mysql --user=root --password= < mysql\create.sql
mysql\bin\mysql --user=root --password= < mysql\tables.sql
