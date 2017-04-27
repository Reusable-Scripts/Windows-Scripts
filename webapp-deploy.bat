@ECHO OFF
set /p APP_VERSION="Enter Application Version without any spaces: "
set /p MOD_NAME="Enter Module Name without spaces: "
echo %APP_VERSION%
echo %MOD_NAME%
set APP_VERSION=%APP_VERSION%
set MOD_NAME=%MOD_NAME%
REM This script only deploy's web application ans restarts tomcat
SET Webapps_Dir="%CATALLINA_HOME%"\webapps
call xcopy \\\Divisions\***\****\SCM\***\"%APP_VERSIOn%"\"%MOD_NAME%"\*.war "%Webapps_Dir%" /Y /I /R
call "%CATALINA_HOME%"\bin\catalina.bat stop
timeout /t 30
call "%CATALINA_HOME%"\bin\catalina.bat start
endlocal.
