@start /b cmd /c php\php server\run.php
@start /b cmd /c php\php -S localhost:80
@start /b cmd /c mysql\bin\mysqld --defaults-extra-file=.\mysql\config\my.ini --console
