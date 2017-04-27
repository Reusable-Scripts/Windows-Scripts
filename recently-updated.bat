@echo off

goto comment1
(%i for windows 10)

/b is for bare format
/ad-h only directories, but not the hidden ones
t:c means to use the creation date for sorting (use t:w for last write date)
/od sort oldest first
The for /F executes the command and sets a to the directory name, the last one is the newest one.
:comment1
set Src="\\project\dir"
FOR /F "tokens=*" %%i IN ('dir %Src% /b /ad-h /t:w /o-d') DO (
    SET a=%%i
    GOTO :found
)
echo No subfolder found
goto :eof
:found
echo Most recently updated verion is: %a%
