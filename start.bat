@start /b cmd /c php\php server\run.php
@start /b cmd /c php\php -S localhost:80 -t ./client
@start /b cmd /c mysql\bin\mysqld --standalone --console
@start /b cmd /c flashplayer\flashplayer_32_sa_debug http://localhost/play/load.swf
