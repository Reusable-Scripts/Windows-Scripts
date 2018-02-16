# Windows-Scripts

Installing jre silently

"%BATCH_SCRIPTS_DIR%3rdPartyApps\jre-7u15-windows-i586.exe" /s /v"INSTALLDIR="%BATCH_INSTALL_PATH%\JRE" ADDLOCAL=ALL IEXPLORER=1 MOZILLA=1 JAVAUPDATE=0 REBOOT=suppress /L*vx %BATCH_INSTALL_PATH%\Logs\JREInstall.log" " /qn

Install Visual Studio silently
msiexec /i "%BATCH_SCRIPTS_DIR%\3rdPartyApps\VCRedist\vcredist.msi" /qb /Lvoicewarmupx "%BATCH_INSTALL_PATH%\Logs\VC2005SP1Redist.log"

Install Tomcat Silently
apache-tomcat-7.0.35.exe" /S /D=%BATCH_INSTALL_PATH%\Tomcat
