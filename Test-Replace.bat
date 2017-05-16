REM REPLACER:

DEL New.txt
setLocal EnableDelayedExpansion
For /f "tokens=* delims= " %%a in (OLD.txt) do (
Set str=%%a
set str=!str:FOO=BAR!
echo !str!>>New.txt
)
ENDLOCAL

REM DEDUPLICATOR (note the use of -9 for an ABA number):
REM DE-DUPLICATE THE Mapping.txt FILE
REM THE DE-DUPLICATED FILE IS STORED AS new.txt

set MapFile=Mapping.txt
set ReplaceFile=New.txt

del %ReplaceFile%
::DelDupeText.bat
rem https://groups.google.com/forum/#!topic/alt.msdos.batch.nt/sj8IUhMOq6o
setLocal EnableDelayedExpansion
for /f "tokens=1,2 delims=," %%a in (%MapFile%) do (
set str=%%a
rem Ref: http://www.dostips.com/DtTipsStringManipulation.php#Snippets.RightString
set str=!str:~-9!
set str2=%%a
set str3=%%a,%%b

find /i ^"!str!^" %MapFile%
find /i ^"!str!^" %ReplaceFile%
if errorlevel 1 echo !str3!>>%ReplaceFile%
)
ENDLOCAL
