@ECHO ON
set /p InstallDir="Enter Java Installation Directory: "
call .\Packages\jdk-8u131-windows-x64.exe /s ADDLOCAL="ToolsFeature,SourceFeature,PublicjreFeature" INSTALLDIR="%InstallDir%\Java"
set JAVA_HOME="%InstallDir%\Java"
setx JAVA_HOME "%InstallDir%\Java" /M
setx path "%path%;%InstallDir%\Java\bin" /M

call .\Packages\7za.exe x .\Packages\apache-tomcat-9.0.0.M20.zip -o%InstallDir% * -r -y
set CATALINA_HOME="%InstallDir%\apache-tomcat-9.0.0.M20"
setx CATALINA_HOME="%InstallDir%\apache-tomcat-9.0.0.M20"
setx path "%path%;%CATALINA_HOME%\bin"
echo "end of installation"

cd /d %CATALINA_HOME%\conf
setLocal EnableDelayedExpansion
For /f "tokens=* delims= " %%a in (server.xml) do (
Set str=%%a
set str=!str:8080=8083!
echo !str!>>New.xml
)
ENDLOCAL
move New.xml server.xml

cd /d %CATALINA_HOME%
bin\startup.bat

goto comments
1. To update tomcat connector port
<Server port="${port.shutdown}" shutdown="SHUTDOWN">
...
  <Connector port="${port.http}" protocol="HTTP/1.1"/>
...
</Server>


Here's how you can start in Linux (assuming your current directory is CATALINA_HOME):
JAVA_OPTS="-Dport.shutdown=8005 -Dport.http=8080" bin/startup.sh

In windows it should be smth like following:
set "JAVA_OPTS=-Dport.shutdown=8005 -Dport.http=8080"
bin\startup.bat
:comments
