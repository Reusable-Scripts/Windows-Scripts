To install tomcat as service:
tomcat8 //IS//Tomcat8 --Description="Apache Tomcat Server" --Startup=auto

To get path from windows services using wmic utility:
wmic service Tomcat8 get pathName

To get path from path variables:
for %i in (Tomcat8.exe) do @echo. %~$PATH:i

To get path from windows services using reg query:
reg query "HKLM\System\CurrentControlSet\Services\Tomcat8" /v "ImagePath"

To get path using SC utility
sc qc Tomcat8|findstr BINARY_PATH_NAME

