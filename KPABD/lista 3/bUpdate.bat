@echo off
set /p password=<password.txt
sqlcmd -S lista3serwer.database.windows.net -d lista3baza -U lista3serwer -P %password% -N -i q3Updater.sql
pause