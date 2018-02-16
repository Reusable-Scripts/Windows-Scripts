# Windows-Scripts

Installing jre silently

"%BATCH_SCRIPTS_DIR%3rdPartyApps\jre-7u15-windows-i586.exe" /s /v"INSTALLDIR="%BATCH_INSTALL_PATH%\JRE" ADDLOCAL=ALL IEXPLORER=1 MOZILLA=1 JAVAUPDATE=0 REBOOT=suppress /L*vx %BATCH_INSTALL_PATH%\Logs\JREInstall.log" " /qn
