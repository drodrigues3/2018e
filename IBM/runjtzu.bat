@ECHO OFF
@echo IBM Time Zone Update Utility for Java (JTZU) Version 1.7.18e

rem set JTZU_HOME to the current directory
set JTZU_HOME=%~dp0
@echo JTZU Home: %JTZU_HOME%


IF NOT EXIST "%JTZU_HOME%JTZU.jar" GOTO MissingJAR
Goto JTZUENV

:MissingJAR
@echo The IBM Time Zone Update Utility for Java (JTZU.jar) doesn't exist.
GOTO Exit

:JTZUENV
rem set JAVA_HOME to the a Java installation directory
IF NOT EXIST "%JTZU_HOME%JTZU.jar" GOTO MissingJTZUENV
	call "%JTZU_HOME%runjtzuenv.bat"
	@echo Java Home: %JAVA_HOME%
	GOTO Temp

:MissingJTZUENV
@echo runjtzuenv.bat file doesn't exist.
GOTO Exit

:Temp
IF EXIST "%JTZU_HOME%\Temp" GOTO Next
 
rem Create a temporary directory
mkdir "%JTZU_HOME%\Temp"

:Next
IF NOT EXIST "%JTZU_HOME%TimeZoneInfo" GOTO MissingTimeZoneInfo
GOTO TimeZoneInfo

:MissingTimeZoneInfo
@echo The TimeZone Information doesn't exist.
GOTO Exit

:TimeZoneInfo
@echo Go to the Time zone directory
rem change the directory to TimeZoneInfo from the current directory
cd "%JTZU_HOME%\TimeZoneInfo"

rem Run the JTZU tool
@echo Launching the IBM Time Zone Update Utility for Java (JTZU) ....
@echo "%JAVA_HOME%\bin\java.exe" -cp "%JTZU_HOME%JTZU.jar" -Dnogui=%NOGUI% -Ddiscoveronly=%DISCOVERONLY% -Dsilentpatch=%SILENTPATCH% -Dbackwardcompatibility=%BACKWARDCOMPATIBILITY% JTZUMain
"%JAVA_HOME%\bin\java.exe" -cp "%JTZU_HOME%JTZU.jar" -Dnogui=%NOGUI% -Ddiscoveronly=%DISCOVERONLY% -Dsilentpatch=%SILENTPATCH% -Dbackwardcompatibility=%BACKWARDCOMPATIBILITY% JTZUMain

:Exit
@echo End of IBM Time Zone Update Utility for Java (JTZU).

rem Return back to the IBM Time Zone Update Utility for Java (JTZU) Home directory
cd "%JTZU_HOME%"
