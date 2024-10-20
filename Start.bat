:: Begin batch script; start macro
@echo off
setlocal EnableDelayedExpansion
chcp 65001 > nul
cd %~dp0

:: Echo colours
set "grey=[90m"
set "red=[91m"
set "green=[92m"
set "yellow=[93m"
set "blue=[94m"
set "magenta=[95m"
set "cyan=[96m"
set "white=[97m"

set "repo_link=https://github.com/NegativeZero01/skibi-defense-macro"

:: If all scripts exist (mainly the main one) and the AutoHotkey 32-bit executable file exists, run the Macro, but first check for updates:
if exist "submacros\update-checker.ahk" (
	echo %cyan%Checking for updates . . .%reset%
	start "" "%~dp0submacros\update-checker.ahk" %*
) else (set "Updater_missing=1")
<nul set /p "=%green%Press any key to continue . . .%reset%"
	pause >nul
if exist "submacros\skibi-defense-macro.ahk" (
	if exist "submacros\AutoHotkey32.exe" (
		echo:
		echo %cyan%Starting Skibi Defense Macro . . .%reset%
		<nul set /p "=%green%Press any key to start . . .%reset%"
			pause >nul
		start "" "%~dp0submacros\AutoHotkey32.exe" "%~dp0submacros\skibi-defense-macro.ahk" %*
		exit
	) else (set "EXE_missing=1")
) else (set "Macro_missing=1")

:: Missing scripts:
if "%Macro_missing%" == "1" (
	echo ^<%red%Failed to find the 'skibi-defense-macro.ahk' file in the submacfros folder^^!%reset%^>
	echo ^<%red%This is most likely due to a third-party antivirus deleting the file, or a corrupted installation. Try following these steps to fix the issue:%reset%^>
	echo ^<%red%1. Re-install the macro from the official GitHub; [%repo_link%] and check that 'skibi-defense-macro.ahk' exists in the submacros folder.%reset%^>
	echo ^<%red%2. Disable any third-party antivirus software ^(or add the Skibi Defense Macro folder as an exception^)%reset%^>
	echo ^<%red%3. Run Start.bat.%reset%^>
	echo:
	echo ^<%red%Note: Both Skibi Defense Macro and AutoHotkey are safe and work fine with Microsoft Defender.%reset%^>
	:: echo ^<%red%Join the Discord server for support: discord.gg/57YmdVy8gA%reset%^>
	echo:
	<nul set /p "=%grey%Press any key to exit . . . %reset%"
		pause >nul
	exit
)

if "%EXE_missing%" == "1" (
	echo ^<%red%Failed to find the 'AutoHotkey32.exe' file in the submacros folder^^!%reset%^>
	echo ^<%red%This is most likely due to a third-party antivirus deleting the file, or a corrupted installation. Try following these steps to fix the issue:%reset%^>
	echo ^<%red%1. Re-install the macro from the official GitHub; https://github.com/NegativeZero01/skibi-defense-macro and check that 'AutoHotkey32.exe' exists in the submacros folder.%reset%^>
	echo ^<%red%2. Disable any third-party antivirus software ^(or add the Skibi Defense Macro folder as an exception^)%reset%^>
	echo ^<%red%3. Run Start.bat.%reset%^>
	echo:
	echo ^<%red%Note: Both Skibi Defense Macro and AutoHotkey are safe and work fine with Microsoft Defender.%reset%^>
	:: echo ^<%red%Join the Discord server for support: discord.gg/57YmdVy8gA%reset%^>
	echo:
	<nul set /p "=%grey%Press any key to exit . . . %reset%"
		pause >nul
	exit
)

if "%Updater_missing%" == "1" (
	echo ^<%red%You are missing the 'update-checker.ahk' file^^!%reset%^>
	echo ^<%red%Without it, the Macro cannot automatically check for updates%reset%^>
	echo ^<%red%Please download it from [%repo_link%]^^!%reset%^>
	echo:
	<nul set /p "=%grey%Press any key to exit . . . %reset%"
		pause >nul
	exit
)

:: Or try to find the .zip file in common install directories, extract it, then run the macro:
for %%a in (".\..") do set "grandparent=%%~nxa"
if not [!grandparent!] == [] (
	for /f "tokens=1,* delims=_" %%a in ("%grandparent%") do set "zip=%%b"
	if not [!zip!] == [] (
		call set str=%%zip:*.zip=%%
		call set zip=%%zip:!str!=%%
		if not [!zip!] == [] (
			echo %yellow%Looking for !zip! . . .%reset%
			cd %USERPROFILE%
			for %%a in ("Downloads","Downloads\Skibi Defense Macro","Desktop","Documents","OneDrive\Downloads","OneDrive\Downloads\Skibi Defense Macro","OneDrive\Desktop","OneDrive\Documents") do (
				if exist "%%~a\!zip!" (
					echo ^<%green%.zip File found in %%~a^^!%reset%^>
					echo:
					
					echo %magenta%Extracting %USERPROFILE%\%%~a\!zip! . . .%reset%
					for /f delims^=^ EOL^= %%g in ('cscript //nologo "%~f0?.wsf" "%USERPROFILE%\%%~a" "%USERPROFILE%\%%~a\!zip!"') do set "folder=%%g"
					echo ^<%cyan%Extract complete^^!%reset%^>
					echo:
					
					echo %magenta%Deleting unextracted !zip! . . .%reset%
					del /f /q "%USERPROFILE%\%%~a\!zip!" >nul
					echo ^<%yellow%Deleted successfully^^!%reset%^>
					echo:
					
					echo ^<%cyan%Extract complete^^! Starting Skibi Defense Macro in 10 seconds.%reset%^>
					<nul set /p =%green%Press any key to skip . . . %reset%
					timeout /t 10 >nul
					start "" "%USERPROFILE%\%%~a\!folder!\submacros\AutoHotkey32.exe" "%USERPROFILE%\%%~a\!folder!\submacros\skibi-defense-macro.ahk"
					exit
				)
			)
		) else (echo ^<%red%Error: No .zip detected, but essential files are missing^^!%reset%^>)
	) else (echo ^<%red%Error: Could not determine name of the unextracted .zip.%reset%^>)
) else (echo ^<%red%Error: Could not find Temp folder of unextracted .zip^^! ^(.bat has no grandparent^)%reset%^>)

echo ^<%red%Unable to automatically extract Skibi Defense Macro^^!%reset%^>
echo ^<%red%- If you have already extracted, you are missing important files. Please re-extract.%reset%^>
echo ^<%red%- If you have not extracted, you may have to manually extract the zipped folder.%reset%^>
echo %red%Join our Discord server for support: discord.gg/natromacro%reset%
echo:
<nul set /p "=%grey%Press any key to exit . . . %reset%"
pause >nul
exit

----- Begin wsf script --->
<job><script language="VBScript">
set fso = CreateObject("Scripting.FileSystemObject")
set objShell = CreateObject("Shell.Application")
set FilesInZip = objShell.NameSpace(WScript.Arguments(1)).items
for each folder in FilesInZip
	WScript.Echo folder
next
objShell.NameSpace(WScript.Arguments(0)).CopyHere FilesInZip, 20
set fso = Nothing
set objShell = Nothing
</script></job>