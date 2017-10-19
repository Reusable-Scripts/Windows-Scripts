@echo off &setlocal

:: pass variables to this script sear 8080 & replace with desired port

cd /d %CATALINA_HOME%\conf
set "search=%1"
set "replace=%2"
set "textfile=server.xml"
set "newfile=server1.xml"
(for /f "delims=" %%i in (%textfile%) do (
    set "line=%%i"
    setlocal enabledelayedexpansion
    set "line=!line:%search%=%replace%!"
    echo(!line!
    endlocal
))>"%newfile%"
del %textfile%
rename %newfile%  %textfile%
