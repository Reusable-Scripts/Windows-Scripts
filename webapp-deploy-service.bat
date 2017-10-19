@echo ON

set APP_VERSION=%1
set APP_NAME=%2
set HTTP_PORT=%3
set Src=..\..\..
Set temp=C:\Temp

echo "Deploying %APP_NAME% to %CATALINA_HOME%"

cd /d %CATALINA_HOME%
SET CATALINA_BASE=%CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%
call .\bin\tomcat8.exe //SS//Tomcat8 --Startup=auto
call .\bin\service.bat uninstall Tomcat8
call .\bin\tomcat8.exe //SS//%APP_NAME%-%APP_VERSION%-%HTTP_PORT% --Startup=auto
FOR /F "tokens=5 delims= " %%P IN ('netstat -a -n -o ^| findstr :%HTTP_PORT%') DO TaskKill.exe /F /PID %%P

waitfor processtostop /t 10 >nul

IF NOT EXIST "%CATALINA_HOME%\Instances" ( mkdir "%CATALINA_HOME%\Instances"
)
IF NOT EXIST "%CATALINA_HOME%\Instances\%APP_NAME%-tomcat" ( mkdir "%CATALINA_HOME%\Instances\%APP_NAME%-tomcat"
)
IF NOT EXIST "%CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%" ( mkdir %CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%
)
IF NOT EXIST "%CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%\webapps" ( mkdir "%CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%\webapps"
)
REM SET Src=%Src:"=%
REM chdir /d %Src%
echo y|COPY "%temp%\%APP_VERSION%\Media\%APP_NAME%\%APP_NAME%"*.war "%CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%\webapps\"

IF NOT EXIST "%CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%\work" ( mkdir "%CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%\work"
)
IF NOT EXIST "%CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%\logs" ( mkdir "%CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%\logs" 
)
IF NOT EXIST "%CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%\temp" ( mkdir "%CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%\temp" 
)
IF NOT EXIST "%CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%\conf" ( mkdir "%CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%\conf" 
)
echo Y|COPY %CATALINA_HOME%\conf %CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%\conf
echo Updating the ports in server.xml
cd /d %CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%\conf
set "search=8080"
set "replace=%3"
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

For /f "tokens=1,*" %%A in ('sc query state^= all ^| find /i "SERVICE_NAME: %HTTP_PORT%"') do (
sc config "%%B" start= disabled
)

cd /d "%CATALINA_HOME%"
SET CATALINA_BASE=%CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%
call %CATALINA_HOME%\bin\service.bat uninstall %APP_NAME%-%APP_VERSION%-%HTTP_PORT%
call %CATALINA_HOME%\bin\service.bat install %APP_NAME%-%APP_VERSION%-%HTTP_PORT%
call %CATALINA_HOME%\bin\tomcat8.exe //US//%APP_NAME%-%APP_VERSION%-%HTTP_PORT% --Description="%APP_NAME%-%APP_VERSION%" --Startup=auto --JvmMx=4096 ++JvmOptions="-Djava.library.path=C:\kla\DesignClipDecryptor"
sc failure %APP_NAME%-%APP_VERSION%-%HTTP_PORT% actions= restart/260000/restart/260000// reset= 900
net start %APP_NAME%-%APP_VERSION%-%HTTP_PORT%
waitfor processtostart /t 15 >nul

REM Removing war file after deployment
call .\bin\tomcat8.exe //SS//%APP_NAME%-%APP_VERSION%-%HTTP_PORT% --Startup=auto
waitfor processtostop /t 10 >nul
del /f "%CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%\webapps\%APP_NAME%.war"
net start %APP_NAME%-%APP_VERSION%-%HTTP_PORT%

IF EXIST "C:\Temp\app.properties" (
cd /d "%CATALINA_HOME%"
call .\bin\tomcat8.exe //SS//%APP_NAME%-%APP_VERSION%-%HTTP_PORT% --Startup=auto
waitfor processtostop /t 10 >nul
COPY C:\Temp\app.properties "%CATALINA_HOME%\Instances\%APP_NAME%-tomcat\%APP_VERSION%\webapps\%APP_NAME%\WEB-INF\classes\" /Y
net start %APP_NAME%-%APP_VERSION%-%HTTP_PORT%
)

set "ServiceName=%APP_NAME%-%APP_VERSION%-%HTTP_PORT%"
SC queryex "%ServiceName%"|Find "STATE"|Find /v "RUNNING">Nul&&(
    echo %ServiceName% not running 
    echo Start %ServiceName%

    Net start "%ServiceName%">nul||(
        Echo "%ServiceName%" wont start 
        exit /b 1
    )
    echo "%ServiceName%" started
    exit /b 0
)||(
    echo "%ServiceName%" working
    exit /b 0
)
