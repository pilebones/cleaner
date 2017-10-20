:beginning
@echo off
color 0c
title Pilebones's Cleaner
setlocal EnableDelayedExpansion
cls
echo.
echo Pilebones's Cleaner
echo.
echo Created by ..
echo.
echo     ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo     Í  °°°°°°  °°  °°      °°°°°°  °°°°°°  °°°°°°  °°   °°  °°°°°°  °°°°°°   Í
echo     Í  °°  °°  °°  °°      °°      °°  °°  °°  °°  °°°  °°  °°      °°       Í
echo     Í  °°°°°°  °°  °°      °°°°°°  °°°°°°  °°  °°  °° ° °°  °°°°°°  °°°°°°   Í
echo     Í  °°      °°  °°      °°      °°  °°  °°  °°  °°  °°°  °°          °°   Í
echo     Í  °°      °°  °°°°°°  °°°°°°  °°°°°°  °°°°°°  °°   °°  °°°°°°  °°°°°°   Í
echo     ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
echo.
net config workstation | find /i "Nom complet">PilebonesCleaner_TEMP_name.txt
FOR /F "tokens=5 delims= " %%r in (PilebonesCleaner_TEMP_name.txt) do set pcname=%%r
net config workstation | find /i "Nom d'utilisateur">PilebonesCleaner_TEMP_name.txt
FOR /F "tokens=3 delims= " %%v in (PilebonesCleaner_TEMP_name.txt) do set name=%%v
del PilebonesCleaner_TEMP_name.txt
echo.
echo Bienvenue %name% ^^!
echo.
ver | find /i "version 6.0" >nul
if %errorlevel%==0 set OS=vista
ver | find /i "xp" >nul
if %errorlevel%==0 set OS=xp
echo Vous utilisez :
if %OS%==vista goto OSVST
if %OS%==xp goto OSXP
echo Un systeme d'exploitation qui n'est pas reconnue !
echo.
goto end
:OSVST
echo ^=^> Microsoft Windows Vista.
echo.
echo Menu : 
echo - 'A' pour Suprimer les fichiers temporaires.
echo - 'Z' pour Connaitre votre adresse IP.
echo - 'E' pour R‚-initialiser votre adresse IP.
echo - 'R' pour Connaitre les personnes sur le r‚seau et leurs IP.
echo - 'T' A propos...
echo - 'Y' pour Quitter le programme.
echo.
rem appuyer sur : 'T' pour suprimer les fichiers temp, 'I' pour ré-initialiser l'adresse ip 'Q' pour quitter..
choice /C azerty /N /M "Choississez une fonctionnalit‚e : "
if errorlevel==6 goto eof
if errorlevel==5 goto apropos
if errorlevel==4 (
set choix=parcreseau
goto DepartCompteur
)
if errorlevel==3 (
set choix=reip
goto DepartCompteur
)
if errorlevel==2 (
set choix=ip
goto DepartCompteur
)
if errorlevel==1 (
set choix=temp
goto DepartCompteur
)

:OSXP
echo ^=^> Microsoft Windows XP.
echo.
echo Menu : 
echo - 'A' pour Suprimer les fichiers temporaires.
echo - 'Z' pour Connaitre votre adresse IP.
echo - 'E' pour R‚-initialiser votre adresse IP.
echo - 'R' pour Connaitre les personnes sur le r‚seau et leurs IP.
echo - 'T' A propos...
echo - 'Y' pour Quitter le programme.
echo.
rem /p est un commutateur pour assigner a la var menu le texte saisie et non la valeur afficher a l'utilisateur
set /p menu=Choississez une fonctionnalit‚e : 
rem "if /i" pour ne pas prendre en compte la casse
if /i %menu%==y goto eof
if /i %menu%==t goto apropos
if /i %menu%==r (
set choix=parcreseau
goto DepartCompteur
)
if /i %menu%==e (
set choix=reip
goto DepartCompteur
)
if /i %menu%==z (
set choix=ip
goto DepartCompteur
)
if /i %menu%==a (
set choix=temp
goto DepartCompteur
)
goto DepartCompteur


rem MODULE : RMTMP
:temp
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
if %OS%==vista goto suptempvista
if %OS%==xp goto suptempxp
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
goto ArretCompteur

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
goto ArretCompteur

rem MODULE : VOTRE_IP
:ip
@echo off
color 0a
cls
echo.
echo Module v1.0
echo.
echo       ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo       °                  Connaitre votre adresse IP                        °
echo       ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
echo - Il est utilis‚ dans le cas ou vous souhaiter connaitre votre adresse IP rapidement.
echo (par exemple lors de r‚seaux TCP-IP...) 
echo.
echo.
ipconfig | find "Adresse IPv4" /i > PilebonesCleaner_TEMP_ip.txt
FOR /F "tokens=2 delims=:" %%i in (PilebonesCleaner_TEMP_ip.txt) do set ip=%%i
set ip > PilebonesCleaner_TEMP_ip.txt
echo Votre IP est : %ip%
del PilebonesCleaner_TEMP_ip.txt
goto ArretCompteur

rem MODULE : RE_IP
:reip
@echo off
color 09
cls
echo.
echo Module v1.0
echo.
echo       ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo       °        Programme de r‚-initialisation de votre adresse IP          °
echo       ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
echo - Il est utilis‚ dans le cas de probleme r‚seau.
echo (par exemple lors de connection limit‚e ou inexistante...)
echo.
echo.
echo Re-initialisation d'adresse IP :
echo.
ipconfig /release
ipconfig /flushdns
ipconfig /renew
echo.
echo R‚-initialisation effectu‚ !
echo.
goto ArretCompteur

rem MODULE : PARC_RESEAU
:parcreseau
@echo off
color 0e
cls
if exist netview_avec_desc.txt del netview_avec_desc.txt
if exist netview_sans_desc.txt del netview_sans_desc.txt
if exist votre_nom_reseau_.txt del votre_nom_reseau_.txt
if exist netview_sans_desc_ni_votre_nom.txt del netview_sans_desc_ni_votre_nom.txt
if exist netview_sans_desc_ni_votre_nom_ni_nom_trace.txt del netview_sans_desc_ni_votre_nom_ni_nom_trace.txt
if exist tracert_non_filtrer.txt del tracert_non_filtrer.txt
if exist tracert_filtrer.txt del tracert_filtrer.txt
cls
echo.
echo Module v1.1
echo.
echo       ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo       °                  Connaitre votre parc r‚seau                       °
echo       ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
echo Il est utilis‚ dans le cas ou vous souhaiter connaitre les utilisateurs connect‚s
echo au r‚seau et leurs adresses.
echo.
echo IMPORTANT : Le programme ne pourra tracer l'IP d'un ordinateur si sont nom comporte
echo un ou plusieurs espaces, ou si il commence par un ou plusieurs caracteres sp‚ciaux ou r‚serv‚s.
echo Cela provoquera des problemes d'affichage dans la liste des ordianteurs connect‚s au r‚seau.
echo.

rem Charger dans les fichier "netview_avec_desc.txt" la liste des ordinateur présent sur le réseau
net view | find "\\">netview_avec_desc.txt

rem Si return error => Réseau désactiver
if %errorlevel%==1 (
echo.
echo PROBLEME r‚seau ^=^> Mat‚riels D‚connect‚
if exist netview_avec_desc.txt del netview_avec_desc.txt 
goto ArretCompteur
)
echo ^=^> AUCUNE erreur lors du chargement des donn‚es r‚seau
goto end
echo.

rem Suppression des Descriptions de chacun des ordinateurs sur le réseau
for /f "tokens=1 delims= " %%a in (netview_avec_desc.txt) do echo %%a>>netview_sans_desc.txt

rem Récupération du nom de l'ordinateur
net config workstation | find "Nom de l'ordinateur">votre_nom_reseau_.txt
for /f "tokens=4 delims= " %%b in (votre_nom_reseau_.txt) do set linkname=%%b

rem Suppression du nom de VOTRE ordinateur dans le fichier
TYPE netview_sans_desc.txt | FIND /V "%linkname%">netview_sans_desc_ni_votre_nom.txt

rem Verification de la taille de fichier de scan
call :testsize netview_sans_desc_ni_votre_nom.txt
:testsize
rem si fichier vide (taille=0) fin du prog
if %~z1 EQU 0 (
echo.
echo ^=^> AUCUN ordinateur/ d‚tect‚ sur le r‚seau !
echo.
if exist netview_avec_desc.txt del netview_avec_desc.txt
if exist netview_sans_desc.txt del netview_sans_desc.txt
if exist votre_nom_reseau_.txt del votre_nom_reseau_.txt
if exist netview_sans_desc_ni_votre_nom.txt del netview_sans_desc_ni_votre_nom.txt
goto ArretCompteur 
)
rem sinon suite !
echo ^=^> D'autre Ordinateurs ont ‚t‚ d‚tecter sur le r‚seau !
echo.
echo -------------------------------
echo  Nom-du-Pc          Adresse-IP
echo -------------------------------
echo.
echo.

rem Ciblage tracage
:tracertbegin
echo.
FOR /F "tokens=1 delims= " %%a in (netview_sans_desc_ni_votre_nom.txt) do set linktarget=%%a
set linknametarget=%linktarget:~2%

rem Suppression du linktarget dans le fichier "netview_sans_desc_ni_votre_nom.txt"
TYPE netview_sans_desc_ni_votre_nom.txt | FIND /V "%linktarget%">netview_sans_desc_ni_votre_nom_ni_nom_trace.txt
TYPE netview_sans_desc_ni_votre_nom_ni_nom_trace.txt>netview_sans_desc_ni_votre_nom.txt

rem Tracage des cibles
tracert -4-6 ^%linknametarget%>tracert_non_filtrer.txt

rem Si erreur durant de tracage => Ordinateur deconnecter entre temps  
if %errorlevel%==1 (
echo %linknametarget%          ^*… ‚t‚ connect‚^*
goto testsize2
)

for /f "tokens=9 delims= " %%c in (tracert_non_filtrer.txt) do set fakeip=%%c
set realip=%fakeip:~1,-1%
echo %linknametarget%          %realip%

rem test size après affichage
call :testsize2 netview_sans_desc_ni_votre_nom.txt
:testsize2
rem si fichier vide (taille=0) fin du scan et prog
if %~z1 EQU 0 (
echo.
echo Plus aucun ordinateur d‚tect‚ sur le r‚seau !
if exist netview_avec_desc.txt del netview_avec_desc.txt
if exist netview_sans_desc.txt del netview_sans_desc.txt
if exist votre_nom_reseau_.txt del votre_nom_reseau_.txt
if exist netview_sans_desc_ni_votre_nom.txt del netview_sans_desc_ni_votre_nom.txt
if exist netview_sans_desc_ni_votre_nom_ni_nom_trace.txt del netview_sans_desc_ni_votre_nom_ni_nom_trace.txt
if exist tracert_non_filtrer.txt del tracert_non_filtrer.txt
if exist tracert_filtrer.txt del tracert_filtrer.txt
goto ArretCompteur
) ELSE (
goto tracertbegin
)

:apropos
cls
echo.
echo                     ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo                     °     Pilebones's Cleaner           °
echo                     °     Version 1.37 de 2009          °
echo                     °  Copyright 2009 par Pilebones     °
echo                     ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
echo.
echo Pour Microsoft Windows XP et Vista 32/64-bit
echo.
echo Pilebones's Cleaner est un programme multi-fonction r‚alis‚ pour facilit‚ :
echo - La maintenance d'un ordinateur plus FACILEMENT.
echo - Pour effectuer des taches RAPIDEMENT.
echo.
echo Concus … la base dans le but de d‚couvrir les scripts Batch, 
echo Pilebones's Cleaner c'est av‚r‚ utile et a finis par conqu‚rir certaine personnes.
echo Penser de maniere ergonomique, ce programme facilite vos envies … travers 
echo ses diverses fonctionnalit‚es.
echo.
echo Pour tout ceux qui en ont mare de cliquer a tout vas pour une chose simple,
echo ce programme est pour vous ^^!
echo Promis pas plus de 3 touches ^^!
echo.
echo.
echo.
pause
goto beginning

:DepartCompteur
@echo off
set mindeb=%TIME:~3,2%
set secdeb=%TIME:~6,2%
set dixiemedeb=%TIME:~9,2%

if %choix%==ip goto ip
if %choix%==temp goto temp
if %choix%==reip goto reip
if %choix%==parcreseau goto parcreseau
echo.
echo Choix incorrect !
echo. 
pause
echo.
goto beginning

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
echo.
echo Temps d'execution ^: %Duree%min %Duree2%s %Duree3%
goto end

:end
echo.
echo FIN DU PROGRAMME..
endlocal
pause>nul