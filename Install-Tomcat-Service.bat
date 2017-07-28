@ECHO OFF
set InstallDir=%1
set servicename="Tomcat8"

REM strip path from Tomcat8 service in windows services then assign it to CATALINA_HOME variable
FOR /f "delims=/" %%a IN ('reg query "HKLM\System\CurrentControlSet\Services\Tomcat8" /v "ImagePath"') DO ( FOR /f "tokens=1,2,*delims= " %%b IN ("%%a") DO IF "%%b"=="ImagePath" ( FOR %%m IN ("%%~dpd.") DO set TC=%%~dpm ))
if "%TC%"=="" (
    @echo Tomcat8 Service not found, installing
	goto :install-tomcat
) else (
    @echo setx -m CATALINA_HOME %TC%)
	
IF NOT EXIST %CATALINA_HOME%\bin goto :install-tomcat
goto :start-tomcat

:install-tomcat
set /p InstallDir="Enter Tomcat Installation Directory: "
call .\ThirdParty\7za.exe x .\ThirdParty\apache-tomcat-8.5.15-windows-x64.zip -o%InstallDir%\ * -r -y
set CATALINA_HOME=%InstallDir%\apache-tomcat-8.5.15
setx -m CATALINA_HOME %InstallDir%\apache-tomcat-8.5.15
setx -m path "%path%;%CATALINA_HOME%\bin"
cd /d %CATALINA_HOME%
call .\bin\tomcat8.exe //SS//%servicename% --Description="application server" --Startup=auto
call .\bin\service.bat uninstall %servicename%
call .\bin\service.bat install %servicename%
call .\bin\tomcat8.exe //US//%servicename% --Description="application server" --Startup=auto
goto :start-tomcat

:start-tomcat
echo "restarting tomcat service"
FOR /f "delims=/" %%a IN ('reg query "HKLM\System\CurrentControlSet\Services\Tomcat8" /v "ImagePath"') DO ( FOR /f "tokens=1,2,*delims= " %%b IN ("%%a") DO IF "%%b"=="ImagePath" ( FOR %%m IN ("%%~dpd.") DO setx -m CATALINA_HOME %%~dpm ))
net start %servicename%
goto :check-status
:check-status
sc query %servicename% | findstr RUNNING
if %ERRORLEVEL% == 0 goto :running
if %ERRORLEVEL% == 2 goto :trouble
if %ERRORLEVEL% == 1 goto :failed
REM tasklist /FI "IMAGENAME eq tomcat.exe" | find /C /I ".exe" > NUL
netstat -na | find "LISTENING" | find /C /I ":8083" > NUL
if %errorlevel%==0 goto :running 
goto :eof

:already-running
echo tomcat is already installed and running, stopping tomcat service
FOR /f "delims=/" %%a IN ('reg query "HKLM\System\CurrentControlSet\Services\Tomcat8" /v "ImagePath"') DO ( FOR /f "tokens=1,2,*delims= " %%b IN ("%%a") DO IF "%%b"=="ImagePath" ( FOR %%m IN ("%%~dpd.") DO setx -m CATALINA_HOME %%~dpm ))
cd /d %CATALINA_HOME%
call .\bin\tomcat8.exe //SS//Tomcat8
goto :eof

:running
echo tomcat started
goto :eof

:failed
echo tomcat failed to start
goto :eof

:trouble
echo trouble with tomcat
goto :eof

:eof
REM TO OPEN Firewall
REM netsh advfirewall firewall add rule name="Apache Tomcat" dir=in action=allow protocol=TCP localport=8888 program="C:\Program Files\Tomcat\bin\tomcat8.exe" profile=ANY
