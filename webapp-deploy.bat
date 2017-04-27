@ECHO OFF
set /p APP_VERSION="Enter Application Version without any spaces: "
set /p APP_NAME="Enter Application Name without spaces: "
echo %APP_VERSION%
echo %APP_NAME%
set APP_VERSION=%APP_VERSION%
set APP_NAME=%APP_NAME%
REM This script only deploy's web application ans restarts tomcat
SET Webapps_Dir="%CATALLINA_HOME%"\webapps
call xcopy \\\Divisions\***\****\SCM\***\"%APP_VERSIOn%"\"%APP_NAME%"\*.war "%Webapps_Dir%" /Y /I /R
call "%CATALINA_HOME%"\bin\catalina.bat stop
timeout /t 30
call "%CATALINA_HOME%"\bin\catalina.bat start
endlocal.
