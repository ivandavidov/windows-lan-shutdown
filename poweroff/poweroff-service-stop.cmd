@echo off

set folder=fiber
set flag_cancel=cancel.txt

:begin
if exist .\%folder%\%flag_cancel% goto end
goto create

:create
echo > .\%folder%\%flag_cancel%
echo.
echo New cancel flag file ".\%folder%\%flag_cancel%" has been created.
echo.
echo PowerOff service will be stopped shortly.
echo.
pause

:end
