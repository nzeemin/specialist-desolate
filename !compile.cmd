@echo off
if exist desolcod0.inc del desolcod0.inc
if exist desolcod0.txt del desolcod0.txt
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

echo Compiling desolcod0 first pass, to export dzx0 address...
tools\pasmo --w8080 -E PASS1=1 desolcod0.asm desolcod0.bin desolcod0.txt
if errorlevel 1 goto Failed
findstr /R /C:"^dzx0[^_a-z]" desolcod0.txt >desolcod0.inc
findstr /R /C:"EQU" desolcod0.inc >nul
if errorlevel 1 goto Failed

echo Compiling desolcode...
tools\pasmo --w8080 desolcoda.asm desolcode.bin desolcode.txt
if errorlevel 1 goto Failed
dir /-c desolcode.bin|findstr /R /C:"desolcode.bin"
findstr /B "Desolate" desolcode.txt

echo Compressing...
tools\salvador.exe -classic -c desolcode.bin desolcode.zx0
if errorlevel 1 goto Failed
dir /-c desolcode.zx0|findstr /R /C:"desolcode.zx0"

echo Compiling desolcod0...
tools\pasmo --w8080 -E PASS1=0 desolcod0.asm desolate.bin desolcod0.txt
if errorlevel 1 goto Failed
findstr /R /C:"^dzx0[^_a-z]" desolcod0.txt >desolcod0.chk
fc desolcod0.inc desolcod0.chk >nul
if errorlevel 1 goto Failed
del desolcod0.chk
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
