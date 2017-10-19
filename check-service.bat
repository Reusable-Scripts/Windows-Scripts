@echo off
set "ServiceName=%APP-NAME%-%Version%-%HTTP-PORT%"
SC queryex "%ServiceName%"|Find "STATE"|Find /v "RUNNING">Nul&&(
    echo %ServiceName% not running 
    echo Start %ServiceName%

    Net start "%ServiceName%">nul||(
        Echo "%ServiceName%" wont start 
        exit /b 1
    )
    echo "%ServiceName%" started
    exit /b 0
)||(
    echo "%ServiceName%" working
    exit /b 0
)

###############ANOTHER WAY###################
@echo OFF

::For /f "tokens=1,*" %%A in ('sc query state^= active ^| find /i "SERVICE_NAME: sots-"') do ( echo %%B
 ::  echo Running Services Are
 ::  echo %%B
 ::  )
