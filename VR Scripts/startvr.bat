@echo off

SETLOCAL EnableExtensions
set dash=OculusDash.exe
set obspath=C:\OBS Antonio Portable

"%~dp0\OculusDebugToolCLI.exe" -f odt_regular.txt

"%PROGRAMFILES(X86)%\MSI Afterburner\MSIAfterburner.exe" -profile1

"%~dp0\nircmd.exe" setdefaultsounddevice "Fones de ouvido" 1
"%~dp0\nircmd.exe" setdefaultsounddevice "VOIP-OUT" 2
"%~dp0\nircmd.exe" setdefaultsounddevice "Headset Microphone" 1
"%~dp0\nircmd.exe" setdefaultsounddevice "Headset Microphone" 2

"%~dp0\nircmd.exe" exec min "%PROGRAMFILES%\Oculus\Support\oculus-client\OculusClient.exe"

"%~dp0\nircmd.exe" exec min "%PROGRAMFILES(X86)%\Steam\steam.exe"

START "OBS" /d "%obspath%\bin\64bit\" obs64.exe

:LOOPSTART
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %dash%"') DO IF %%x == %dash% goto FOUND
TIMEOUT /T 2
goto LOOPSTART
:FOUND

"%~dp0\OculusDebugToolCLI.exe" -f odt_regular.txt

TIMEOUT /T 3

"%~dp0\nircmd.exe" setsysvolume 52428 "Fones de ouvido"
"%~dp0\nircmd.exe" setsysvolume 65535 "Headset Microphone"

START steam://rungameid/250820

TIMEOUT /T 5

"%~dp0\nircmd.exe" exec min "%obspath%\my stuff\Virtual Motion Capture\VirtualMotionCapture.exe"

TIMEOUT /T 10

powershell -command "& { $x = New-Object -ComObject Shell.Application; $x.ToggleDesktop() }"

TIMEOUT /T 2

"%~dp0\nircmd.exe" win max process obs64.exe

TIMEOUT /T 2

"%~dp0\nircmd.exe" win max process Ferdi.exe

exit 0