@ECHO OFF
REM This script only deploy's web application ans restarts tomcat
SET Webapps_sir=%CATALLINA_HOME%\webapps
xcopy \\klasj\ktfiles\ %CATALINA_HOME%\webapps
call %CATALINA_HOME%\bin\catalina.bat stop
sleep -m 3000
call%CATALINA_HOME%\bin\catalina.bat jpda start

