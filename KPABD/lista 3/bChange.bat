@echo off
set /p password=<password.txt
set /p currency=Enter the name of currency you want to change (Dollar, Euro, Franc, Pound):
set /p pricePLN=Enter the new pricePLN:
sqlcmd -S lista3serwer.database.windows.net -d lista3baza -U lista3serwer -P %password% -N -i q3Changer.sql -v currency=%currency% pricePLN=%pricePLN%
pause