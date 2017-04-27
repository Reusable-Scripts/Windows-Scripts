@ECHO OFF
set /p APP_VERSION="Enter Application Version: "
echo %APP_VERSION%
set APP_VERSION=%APP_VERSION%
REM This script only deploy's web application ans restarts tomcat
SET Webapps_Dir="%CATALLINA_HOME%"\webapps
call xcopy \\\Divisions\***\****\SCM\***\"%APP_VERSIOn%"\appname\*.war "%Webapps_Dir%" /Y /I /R
call "%CATALINA_HOME%"\bin\catalina.bat stop
timeout /t 30
call '%CATALINA_HOME%'\bin\catalina.bat start
endlocal.
