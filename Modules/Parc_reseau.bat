:parcreseau
@echo off
color 0e
setlocal EnableDelayedExpansion
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
echo PROBLEME r‚seau ^=^> Mat‚riels D‚connect‚ ^^!
if exist netview_avec_desc.txt del netview_avec_desc.txt 
goto end
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
endlocal
goto end 
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
goto end
) ELSE (
goto tracertbegin
)

:end
if exist netview_avec_desc.txt del netview_avec_desc.txt
if exist netview_sans_desc.txt del netview_sans_desc.txt
if exist votre_nom_reseau_.txt del votre_nom_reseau_.txt
if exist netview_sans_desc_ni_votre_nom.txt del netview_sans_desc_ni_votre_nom.txt
if exist netview_sans_desc_ni_votre_nom_ni_nom_trace.txt del netview_sans_desc_ni_votre_nom_ni_nom_trace.txt
if exist tracert_non_filtrer.txt del tracert_non_filtrer.txt
if exist tracert_filtrer.txt del tracert_filtrer.txt
echo.
echo FIN DU PROGRAMME..
pause>nul