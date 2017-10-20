:ip
@echo off
color 0a
cls
echo.
echo Module v1.0
echo.
echo       ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo       ฐ                  Connaitre votre adresse IP                        ฐ
echo       ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
echo - Il est utilis dans le cas ou vous souhaiter connaitre votre adresse IP rapidement.
echo (par exemple lors de rseaux TCP-IP...) 
echo.
echo.
ipconfig | find "Adresse IPv4" /i > PilebonesCleaner_TEMP_ip.txt
FOR /F "tokens=2 delims=:" %%i in (PilebonesCleaner_TEMP_ip.txt) do set ip=%%i
set ip > PilebonesCleaner_TEMP_ip.txt
echo Votre IP est : %ip%
del PilebonesCleaner_TEMP_ip.txt
goto end

:end
echo.
echo Fin du Prog
pause