@ECHO OFF
SETLOCAL
set "APP_VERSION="
REM This script only deploy's web application ans restarts tomcat
set /p APP_VERSION="Enter Application Version: "
set /p APP_NAME="Enter Application Name: "
SET Src="enter your source directory shared folder path"
SET Webapps_Dir="%CATALLINA_HOME%"\webapps

if "%APP_NAME%"=="APP1" set APP=true
if "%APP_NAME%"=="APP2" set APP=true

if "%APP%" == "true" ( goto version )
else ( goto end )
:version
If [%APP_VERSION%] NEQ [] (
goto Deploy
) else (
FOR /F "tokens=*" %%i IN ('dir %Src% /b /ad-h /t:w /o-d') DO (
    SET APP_VERSION=%%i
    GOTO :%APP_NAME%-Deploy
) )

:APP1-Deploy
call xcopy "%Src%""%APP_VERSIOn%"\"%APP_NAME%"\*.war "%Webapps_Dir%" /Y /I /R /E
call xcopy "%Src%""%APP_VERSIOn%"\sup-files\dist\* "%Webapps_Dir%\sup-files" /Y /I /R /E
call "%CATALINA_HOME%"\bin\catalina.bat stop
timeout /t 5
call "%CATALINA_HOME%"\bin\catalina.bat start	
echo Version Deployed: %APP_VERSION%

:APP2-Deploy
call xcopy "%Src%""%APP_VERSIOn%"\"%APP_NAME%"\*.war "%Webapps_Dir%" /Y /I /R /E
call "%CATALINA_HOME%"\bin\catalina.bat stop
timeout /t 5
call "%CATALINA_HOME%"\bin\catalina.bat start	
echo Version Deployed: %APP_VERSION%

)
 :end
 echo The Application you have entered doesn't exist, closing window
 timeout /t 10
 ENDLOCAL
 exit
 
