@echo off

set folder=fiber
set flag_poweroff=optic.txt
set flag_cancel=cancel.txt
set seconds=60

:begin
echo.
if exist .\%folder%\%flag_poweroff% goto isthere
goto create

:isthere
del .\%folder%\%flag_poweroff%
echo Old poweroff flag file ".\%folder%\%flag_poweroff%" has been removed.

:create
if exist .\%folder%\%flag_cancel% goto remove_flag_cancel
goto create_flag_poweroff

:remove_flag_cancel
del .\%folder%\%flag_cancel%
echo Cancel flag file ".\%folder%\%flag_cancel%" has been removed.

:create_flag_poweroff
echo > .\%folder%\%flag_poweroff%
echo New poweroff flag file ".\%folder%\%flag_poweroff%" has been created.
echo.
echo PowerOff service started.
echo Delete ".\%folder%\%flag_poweroff%" to initiate shutdown.
echo Execute "poweroff-service-stop.cmd" or use "Ctrl + C" to stop the service.

:routine
if exist .\%folder%\%flag_cancel% goto cancel
if not exist .\%folder%\%flag_poweroff% goto poweroff
goto sleep

:sleep
ping 127.0.0.1 -n 10 -w 1000 > NUL
goto routine

:poweroff
echo.
echo Poweroff flag file ".\%folder%\%flag_poweroff%" has been removed.
shutdown /s /f /t %seconds%
echo Shutdown has been initiated.
echo You have %seconds% to cancel the shutdown by executing "poweroff-cancel.cmd".
echo.
pause
goto end

:cancel
echo Cancel flag file ".\%folder%\%flag_cancel%" has been detected.
del .\%folder%\%flag_cancel%
echo Cancel flag file ".\%folder%\%flag_cancel%" has been removed.
echo PowerOff service has been stopped.
echo.
pause

:end
