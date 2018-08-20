Batchfile

@echo off
if "%2" == "" GOTO Usage

cd /D %1
if errorlevel 1 goto usage

for %%x in (*.*) do if NOT exist %2\%%x echo missing %2\%%x
cd /D %2
for %%x in (*.*) do if NOT exist %1\%%x echo missing %1\%%x

goto end

:usage
echo Usage %0 dir1 dir2
echo where dir1 and dir2 are full paths
:end
Usage

Environment:

F:\so>dir /s dir1 dir2
 Volume in drive F is WIN2K
 Volume Serial Number is 921E-EC47

 Directory of F:\so\dir1

2010-11-22  10:33       <DIR>          .
2010-11-22  10:33       <DIR>          ..
2010-11-22  10:33                   13 a
2010-11-22  10:33                   13 b
2010-11-22  10:33                   13 c
               3 File(s)             39 bytes

 Directory of F:\so\dir2

2010-11-22  10:33       <DIR>          .
2010-11-22  10:33       <DIR>          ..
2010-11-22  10:33                   13 a
2010-11-22  10:33                   13 b
2010-11-22  10:33                   13 c
2010-11-22  10:33                   13 D
2010-11-22  10:33                   13 E
               5 File(s)             65 bytes

     Total Files Listed:
               5 File(s)             65 bytes
               2 Dir(s)     219,848,704 bytes free

F:\so>
Running:

F:\so\dir1>dirc f:\so\dir1 f:\so\dir2

F:\so\dir1>dirc f:\so\dir1 f:\so\dir2
missing f:\so\dir1\D
missing f:\so\dir1\E

F:\so\dir2>
