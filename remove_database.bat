echo !!! MAKE SURE MYSQLD (MYSQL SERVER) IS NOT RUNNING WHEN YOU EXECUTE THIS !!!
for /D %%D in (".\mysql\data\*.*") do (
    if /I not "%%~nxD"=="mysql" (
        2> nul rd /S /Q "%%~fD"
    )
)
del /Q .\mysql\data\*.*
