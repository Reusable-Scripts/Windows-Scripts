@ECHO ON
set /p InstallDir="Enter Java Installation Directory: "
call .\Packages\jdk-8u131-windows-x64.exe /s ADDLOCAL="ToolsFeature,SourceFeature,PublicjreFeature" INSTALLDIR="%InstallDir%\Java"
set JAVA_HOME="%InstallDir%"
setx JAVA_HOME "%InstallDir%" /M
setx path "%path%;%InstallDir%\bin" /M
