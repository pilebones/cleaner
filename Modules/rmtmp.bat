:DelTmpBegin
@echo off
cls
color 05
echo.
echo Module v1.1
echo.
echo       ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo       °          Programme de supression de fichiers temporaires           °
echo       ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
echo - Il est utilis‚ pour effacer des fichiers qui encombrent votre ordinateur.
echo - Ces fichiers sont susceptible de ralentir votre ordinateur.
echo.
echo.
rem Recherche de l'OS
ver | find /i "version 6.0" >nul
if %errorlevel%==0 (
set OS=vista
echo Vous Utilis‚ : Windows VISTA !
echo.
goto suptempvista
)
ver | find /i "xp" >nul
if %errorlevel%==0 (
set OS=xp
echo Vous Utilis‚ : Windows XP !
echo.
goto suptempxp
)
goto end

:suptempvista
rem Windows...
echo ^=^> Pour Windows...
echo - Supression des fichiers temporaires de l'explorer :
del %SYSTEMDRIVE%\Windows\Temp\* /s/q/F
del %SYSTEMDRIVE%\Windows\Debug\UserMode\* /s/q/F
echo.
echo - Supression des logs de securit‚es :
del %SYSTEMDRIVE%\Windows\security\logs\*.* /s/q
echo.
echo - Supression des fichiers temporaires de l'utilisateur :
del %LOCALAPPDATA%\Temp\* /s/q/F
echo.   
echo - Supression des Prefetcher :
del %SYSTEMDRIVE%\Windows\Prefetch\* /s/q
echo.
echo - Supression des liens vers fichiers récement ouvert :
del %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Recent\* /s/q
echo.

rem Internet Explorer...
echo ^=^> Pour Internet Explorer...
echo - Supression du cache :
echo.
del %LOCALAPPDATA%\Microsoft\Windows\"Temporary Internet Files"\* /s/q/F
del %LOCALAPPDATA%\Microsoft\Windows\Explorer\* /s/q/F
echo.
echo - Supression des Cookies :
echo.
del %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Cookies\* /s/q/F
echo.

rem FireFox...
echo ^=^> Pour FireFox...
echo - Supression du cache, de la liste de t‚l‚chargement :
echo.
for /F %%i in ('dir %USERPROFILE%\AppData\Local\Mozilla\Firefox\Profiles\*.default /B') do (
del %USERPROFILE%"\AppData\Local\Mozilla\Firefox\Profiles\"%%i"\Cache\"* /s/q/F
if exist %USERPROFILE%"\AppData\Local\Mozilla\Firefox\Profiles\"%%i"\downloads.sqlite" (
echo Supression de la liste de load firefox:
del %USERPROFILE%"\AppData\Local\Mozilla\Firefox\Profiles\"%%i"\downloads.sqlite" /s/q/F
)
)
echo.

rem Spybot - Search & Destroy...
echo ^=^> Pour Spybot ^- Search ^& Destroy...
echo - Supression des historiques de mises a jour spybot :
echo.
del %SYSTEMDRIVE%\ProgramData\"Spybot - Search & Destroy\Logs"\* /s/q
echo.

rem Windows Live Messenger...
echo ^=^> Pour Windows Live Messenger...
echo - Supression des fichiers temp :
echo.
del %USERPROFILE%\AppData\Roaming\Microsoft\MSN Messenger\*.sqm /s/q/F
echo.

rem GlobalTempfile
echo ^=^> Pour tout vos logiciels...
echo - Supression des fichiers temporaire Global :
del %SYSTEMDRIVE%\*.tmp /s
echo.

rem FIN DE LA SUP TEMP
echo Fichiers Temporaires supprim‚s a %TIME:~0,5% !
goto end

:suptempxp
rem Windows...
echo ^=^> Pour Windows...
echo - Supression des fichiers temporaires de l'explorer :
del %TEMP%\* /s/q/F
dir %TEMP%\ /B
del C:\Windows\Temp\* /s/q/F
dir C:\Windows\Temp\ /B
echo.
echo - Supression des Prefetchers :
del C:\Windows\Prefetch\* /s/q/F
dir C:\Windows\Prefetch\ /B
echo.

rem GlobalTempfile
echo ^=^> Pour tout vos logiciels...
echo - Supression des fichiers temporaire Global :
del %SYSTEMDRIVE%\*.tmp /s
echo.

echo Fichiers Temporaires supprim‚s a %TIME:~0,5% !
goto end

:end
echo.
echo FIN DU PROGRAMME..
pause>nul