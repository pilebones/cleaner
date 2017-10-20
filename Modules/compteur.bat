:DepartCompteur
@echo off
set mindeb=%TIME:~3,2%
set secdeb=%TIME:~6,2%
set dixiemedeb=%TIME:~9,2%
echo.
echo Compteur Amorcer !
echo.

pause
:ArretCompteur
set minend=%TIME:~3,2%
set secend=%TIME:~6,2%
set dixiemeend=%TIME:~9,2%

if %secend% GEQ %secdeb% goto suitecompteur
set /a secend=%secend% + 60
set /a minend=%minend% - 1
:suitecompteur

if %dixiemeend% GEQ %dixiemedeb% goto suitecompteur2
set /a dixiemeend=%dixiemeend% + 100
set /a secend=%secend% - 1
:suitecompteur2

set /a Duree=%minend% - %mindeb%
set /a Duree2=%secend% - %secdeb%
set /a Duree3=%dixiemeend% - %dixiemedeb%
echo Temps d'execution ^: %Duree%min %Duree2%s %Duree3%
goto end

:end
echo.
echo FIN DU PROGRAMME..
pause>nul