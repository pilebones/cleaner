:reip
@echo off
color 09
cls
echo.
echo Module v1.0
echo.
echo       浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
echo       �        Programme de r�-initialisation de votre adresse IP          �
echo       藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕
echo.
echo - Il est utilis� dans le cas de probleme r�seau.
echo (par exemple lors de connection limit�e ou inexistante...)
echo.
echo.
echo Re-initialisation d'adresse IP :
echo.
ipconfig /release
ipconfig /flushdns
ipconfig /renew
echo.
echo R�-initialisation effectu� !
echo.
goto end

:end
echo.
echo Fin du Prog
pause