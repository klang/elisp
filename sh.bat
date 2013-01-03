@ECHO off

set /p mycmd=;;Command:
echo.
REM echo you typed "%mycmd%"

SET Line=%mycmd%
SET Line=%Line:"=%
REM echo %Line% 

echo ;;Launching %Line% ...
%Line%