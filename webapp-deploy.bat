@ECHO OFF
set /p APP_VERSION="Enter Application Version: "
set /p APP_NAME="Enter Application Name: "
echo %APP_VERSION%
echo %APP_NAME%
if "%APP_NAME%" == "app1" goto Deploy
if "%APP_NAME%" == "app2" goto Deploy
goto end
:Deploy
set APP_VERSION=%APP_VERSION%
set APP_NAME=%APP_NAME%
REM This script only deploy's web application ans restarts tomcat
SET Webapps_Dir="%CATALLINA_HOME%"\webapps
call xcopy \\Share_Drive_Location\SCM\project\"%APP_VERSIOn%"\"%APP_NAME%"\*.war "%Webapps_Dir%" /Y /I /R
call "%CATALINA_HOME%"\bin\catalina.bat stop
timeout /t 30
call "%CATALINA_HOME%"\bin\catalina.bat start
endlocal.
 :end
 echo end
 exit
 
