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
