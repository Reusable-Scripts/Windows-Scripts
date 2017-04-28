goto comments 
This script copies files from network frive to linux machine and executes the ecript on linux machine. 
Prerequisites:
1. create a putty in shared drive and copy pscp.exe and plink.exe
2. put the script that you want to execute in linux under shared drive or by creating scripts folder in current folder
:comments
@ECHO OFF
set /p Linux_Machine="Enter Linux Machine host name: "
set /p Linux_User="Enter Deployment Machine User name: "
set /p Linux_PW="Enter Deployment Machine Password: "
set /p Target_Dir="Enter Application Directory(eg: /mnt/windowsfs): "
set /p APP_VERSION="Enter Application Version Number: "
SET Src="shared drive"
mkdir Putty
call XCOPY \\projscm\Gallery\Softwares\Putty\* ".\Putty" /Z /Y /E
If "%APP_VERSION%" NEQ "" (
set APP_VERSION=%APP_VERSION%
mkdir %APP_VERSION%\STS
mkdir %APP_VERSION%\STA
REM call XCOPY \\projscm\Gallery\Softwares\Putty\* ".\Putty" /Z /Y /E
call XCOPY %Src%\"%APP_VERSION%"\STS\* .\%APP_VERSION%\STS /Z /E /Y
call XCOPY %Src%\"%APP_VERSION%"\STA\* .\%APP_VERSION%\STA /Z /Y /E
timeout /t 5 
goto Deploy )
else(
FOR /F "tokens=*" %%i IN ('dir %Src% /b /ad-h /t:w /od') DO ( SET APP_VERSION=%%i  
mkdir %APP_VERSION%
call XCOPY %Src%\"%APP_VERSION%"\STS\* .\%APP_VERSION%\STS /Z /E /Y
call XCOPY %Src%\"%APP_VERSION%"\STA\* .\%APP_VERSION%\STA /Z /Y /E
echo Version Number: %APP_VERSION%
timeout /t 5
goto Deploy
))

:Deploy
REM XCOPY \\projectscm\Gallery\Softwares\Putty\* ".\Putty" /Z /Y /E
REM XCOPY %Src%\44\STS\* .\STS /Z /E /Y
REM XCOPY %Src%\44\STA\* .\STA /Z /Y /E
.\Putty\pscp.exe -r -q -pw %Linux_PW% .\%APP_VERSION% %Linux_User%@%Linux_Machine%:%Target_Dir%
REM .\Putty\pscp.exe -r -q -pw %Linux_PW% .\STA %Linux_User%@%Linux_Machine%:%Target_Dir%
.\Putty\pscp.exe -r -q -pw %Linux_PW% .\Scripts %Linux_User%@%Linux_Machine%:%Target_Dir%

.\Putty\plink.exe -v -pw %Linux_PW% %Linux_User%@%Linux_Machine% export APP_DIR=%Target_Dir%/%APP_VERSION%; sh %Target_Dir%/Scripts/ST-Deployment.sh
if %ERRORLEVEL%==0( echo "Deployment completed") 
else ( echo "Deployment failed")
