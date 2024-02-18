@echo off
if exist desolroom.bin del desolroom.bin
if exist desolroom.inc del desolroom.inc
if exist desolroom.zx0 del desolroom.zx0
if exist desolcode.bin del desolcode.bin
if exist desolcode.txt del desolcode.txt
if exist desolcode.zx0 del desolcode.zx0
if exist desolate.bin del desolate.bin
if exist desolate.rks del desolate.rks

rem Define ESCchar to use in ANSI escape sequences
rem https://stackoverflow.com/questions/2048509/how-to-echo-with-different-colors-in-the-windows-command-line
for /F "delims=#" %%E in ('"prompt #$E# & for %%E in (1) do rem"') do set "ESCchar=%%E"

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "DATESTAMP=%YYYY%-%MM%-%DD%"
for /f %%i in ('git rev-list HEAD --count') do (set REVISION=%%i)
echo REV.%REVISION% %DATESTAMP%

echo   DEFM "ver.%REVISION% %DATESTAMP%" >desolvers.asm

echo Compiling desolroom...
tools\pasmo --w8080 desolroom.asm desolroom.bin desolroom.inc
if errorlevel 1 goto Failed
dir /-c desolroom.bin|findstr /R /C:"desolroom.bin"

echo Compiling desolcode...
tools\pasmo --w8080 desolcoda.asm desolcode.bin desolcode.txt
if errorlevel 1 goto Failed
dir /-c desolcode.bin|findstr /R /C:"desolcode.bin"
findstr /B "Desolate" desolcode.txt

echo Compressing...
tools\salvador.exe -classic -c desolcode.bin desolcode.zx0
if errorlevel 1 goto Failed
dir /-c desolcode.zx0|findstr /R /C:"desolcode.zx0"
tools\salvador.exe -classic -c desolroom.bin desolroom.zx0
if errorlevel 1 goto Failed
dir /-c desolroom.zx0|findstr /R /C:"desolroom.zx0"

echo Compiling desolcod0...
tools\pasmo --w8080 desolcod0.asm desolate.bin
if errorlevel 1 goto Failed
dir /-c desolate.bin|findstr /R /C:"desolate.bin"

echo Converting desolate.bin to rks...
python .\tools\bin2rks.py desolate.bin

dir /-c desolate.rks|findstr /R /C:"desolate.rks"

echo %ESCchar%[92mSUCCESS%ESCchar%[0m
exit

:Failed
@echo off
echo %ESCchar%[91mFAILED%ESCchar%[0m
exit /b
