@echo off
title Applio Installer

:::                       _ _         _____                    _      
:::     /\               | (_)       |  __ \                  | |     
:::    /  \   _ __  _ __ | |_  ___   | |__) |___  ___ ___   __| | ___ 
:::   / /\ \ | '_ \| '_ \| | |/ _ \  |  _  // _ \/ __/ _ \ / _` |/ _ \
:::  / ____ \| |_) | |_) | | | (_) | | | \ \  __/ (_| (_) | (_| |  __/
::: /_/    \_\ .__/| .__/|_|_|\___/  |_|  \_\___|\___\___/ \__,_|\___|
:::          | |   | |                                                
:::          |_|   |_|                                                
:::
:::

setlocal 
set "branch=applio-recode"
set "runtime=runtime-recode"
set "repoUrl=https://github.com/IAHispano/Applio-RVC-Fork/archive/refs/heads/%branch%.zip"
set "fixesFolder=fixes"
set "localFixesPy=local_fixes.py"
set "principal=%cd%"
set "URL_BASE=https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main"
set "URL_EXTRA=https://huggingface.co/IAHispano/applio/resolve/main"

:menu
for /f "delims=: tokens=*" %%A in ('findstr /b ":::" "%~f0"') do @echo(%%A

echo [1] Reinstall Applio
echo [2] Update Applio
echo [3] Update Applio + Runtime
echo.

set /p choice=Select an option: 
set choice=%choice: =%

if "%choice%"=="1" (
    cls
    echo Starting Applio Reinstaller...
    echo.
    goto reinstaller
    pause
    cls
    goto menu

)

if "%choice%"=="2" (
    cls
    echo Starting Applio Updater...
    echo.
    goto updater
    pause
    cls
    goto menu
)

if "%choice%"=="3" (
    cls
    echo Updating Applio + Runtime...
    echo.
    goto updaterRuntime
    pause
    cls
    goto menu

)

cls
echo Invalid option. Please enter a number from 1 to 3.
echo.
echo Press 'Enter' to access the main menu...
pause>nul
cls
goto menu

:reinstaller

echo WARNING: Remember to install Microsoft C++ Build Tools, Redistributable, Python, and Git before continuing.
echo.
echo Step-by-step guide: https://rentry.org/appliolocal
echo Build Tools: https://aka.ms/vs/17/release/vs_BuildTools.exe
echo Redistributable: https://aka.ms/vs/17/release/vc_redist.x64.exe
echo Git: https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.2/Git-2.42.0.2-64-bit.exe
echo Python: Add this route to the windows enviroment variables the user path variable: %principal%\runtime\Scripts
echo.
pause
cls

echo Downloading ZIP file...
powershell -command "& { Invoke-WebRequest -Uri '%repoUrl%' -OutFile '%principal%\repo.zip' }"
echo.

echo Extracting ZIP file...
powershell -command "& { Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory('%principal%\repo.zip', '%principal%') }"
echo.

echo Copying folder and file structure from subdirectory to main directory...
robocopy "%principal%\Applio-RVC-Fork-%branch%" "%principal%" /E
echo.

echo Deleting contents of subdirectory (files and folders)...
rmdir "%principal%\Applio-RVC-Fork-%branch%" /S /Q
echo.

echo Cleaning up...
del "%principal%\repo.zip"
echo.
cls

echo Proceeding to download the models...
echo.

echo WARNING: At this point, it's recommended to disable antivirus or firewall, as errors might occur when downloading pretrained models.
pause
cls

echo Downloading models in the assets folder...
cd "assets"
echo.
echo Downloading the "pretrained" folder...
cd "pretrained"
curl -LJO "%URL_BASE%/pretrained/D32k.pth"
curl -LJO "%URL_BASE%/pretrained/D40k.pth"
curl -LJO "%URL_BASE%/pretrained/D48k.pth"
curl -LJO "%URL_BASE%/pretrained/G32k.pth"
curl -LJO "%URL_BASE%/pretrained/G40k.pth"
curl -LJO "%URL_BASE%/pretrained/G48k.pth"
curl -LJO "%URL_BASE%/pretrained/f0D32k.pth"
curl -LJO "%URL_BASE%/pretrained/f0D40k.pth"
curl -LJO "%URL_BASE%/pretrained/f0D48k.pth"
curl -LJO "%URL_BASE%/pretrained/f0G32k.pth"
curl -LJO "%URL_BASE%/pretrained/f0G40k.pth"
curl -LJO "%URL_BASE%/pretrained/f0G48k.pth"
cd ".."
echo.
cls

echo Downloading the "pretrained_v2" folder...
cd "pretrained_v2"
curl -LJO "%URL_BASE%/pretrained_v2/D32k.pth"
curl -LJO "%URL_BASE%/pretrained_v2/D40k.pth"
curl -LJO "%URL_BASE%/pretrained_v2/D48k.pth"
curl -LJO "%URL_BASE%/pretrained_v2/G32k.pth"
curl -LJO "%URL_BASE%/pretrained_v2/G40k.pth"
curl -LJO "%URL_BASE%/pretrained_v2/G48k.pth"
curl -LJO "%URL_BASE%/pretrained_v2/f0D32k.pth"
curl -LJO "%URL_BASE%/pretrained_v2/f0D40k.pth"
curl -LJO "%URL_BASE%/pretrained_v2/f0D48k.pth"
curl -LJO "%URL_BASE%/pretrained_v2/f0G32k.pth"
curl -LJO "%URL_BASE%/pretrained_v2/f0G40k.pth"
curl -LJO "%URL_BASE%/pretrained_v2/f0G48k.pth"
cd ".."
echo.
cls

echo Downloading the hubert_base.pt file...
cd "hubert"
curl -LJO "%URL_BASE%/hubert_base.pt"
cd ".."
echo.
cls


echo Downloading the rmvpe.pt file...
cd "rmvpe"
curl -LJO "%URL_BASE%/rmvpe.pt"
echo.
cls

echo Downloading the rmvpe.onnx file...
curl -LJO "%URL_BASE%/rmvpe.onnx"
cd ".."
cd ".."
echo.
cls

echo Downloading the rest of the large files

echo Downloading the "uvr5_weights" folder...
cd "uvr5_weights"
curl -LJO "%URL_BASE%/uvr5_weights/HP2_all_vocals.pth"
curl -LJO "%URL_BASE%/uvr5_weights/HP3_all_vocals.pth"
curl -LJO "%URL_BASE%/uvr5_weights/HP5_only_main_vocal.pth"
curl -LJO "%URL_BASE%/uvr5_weights/VR-DeEchoAggressive.pth"
curl -LJO "%URL_BASE%/uvr5_weights/VR-DeEchoDeReverb.pth"
curl -LJO "%URL_BASE%/uvr5_weights/VR-DeEchoNormal.pth"
cd ".."
echo.
cls

echo Downloading the ffmpeg.exe file...
curl -LJO "%URL_BASE%/ffmpeg.exe"
echo.
cls

echo Downloading the ffprobe.exe file...
curl -LJO "%URL_BASE%/ffprobe.exe"
echo.
cls

echo Downloading the runtime.zip file...
curl -LJO "%URL_EXTRA%/%runtime%.zip"
echo.
cls

echo Extracting the runtime.zip file, this might take a while...
powershell -Command "Expand-Archive -Path '%runtime%.zip' -DestinationPath '.'"
del %runtime%.zip
echo.
cls

echo Downloads completed!
echo.

echo Checking if the local_fixes.py file exists in the Fixes folder...
if exist "%fixesFolder%\%localFixesPy%" (
    echo Running the file...
    runtime\python.exe "%fixesFolder%\%localFixesPy%"
) else (
    echo The "%localFixesPy%" file was not found in the "Fixes" folder.
)
echo.

echo Fixes Applied!
echo.

echo Applio has been reinstalled!
echo.
echo Press 'Enter' to access the main menu...
pause>nul
cls
goto menu


:updater

echo Downloading the ZIP file...
powershell -command "& { Invoke-WebRequest -Uri '%repoUrl%' -OutFile '%principal%\repo.zip' }"
echo.

echo Extracting ZIP file...
powershell -command "& { Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory('%principal%\repo.zip', '%principal%') }"
echo.

echo Copying folder and file structure from subdirectory to main directory...
robocopy "%principal%\Applio-RVC-Fork-%branch%" "%principal%" /E
echo.

echo Deleting contents of the subdirectory (files and folders)...
rmdir "%principal%\Applio-RVC-Fork-%branch%" /S /Q
echo.

echo Cleaning up...
del "%principal%\repo.zip"
echo.
cls

echo Verifying if the local_fixes.py file exists in the Fixes folder...
if exist "%fixesFolder%\%localFixesPy%" (
    echo Running the file...
    runtime\python.exe "%fixesFolder%\%localFixesPy%"
) else (
    echo The file "%localFixesPy%" was not found in the "Fixes" folder.
)
echo.

echo Applio has been updated!
echo.
echo Press 'Enter' to access the main menu... 
pause>nul
cls
goto menu


:updaterRuntime

echo Downloading the ZIP file...
powershell -command "& { Invoke-WebRequest -Uri '%repoUrl%' -OutFile '%principal%\repo.zip' }"
echo.

echo Extracting ZIP file...
powershell -command "& { Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory('%principal%\repo.zip', '%principal%') }"
echo.

echo Copying folder and file structure from subdirectory to main directory...
robocopy "%principal%\Applio-RVC-Fork-%branch%" "%principal%" /E
echo.

echo Deleting contents of the subdirectory (files and folders)...
rmdir "%principal%\Applio-RVC-Fork-%branch%" /S /Q
echo.

echo Cleaning up...
del "%principal%\repo.zip"
echo.
cls

echo Downloading the runtime.zip file...
curl -LJO "%URL_EXTRA%/%runtime%.zip"
echo.
cls
echo Extracting the runtime.zip file, this might take a while...
powershell -Command "Expand-Archive -Path '%runtime%.zip' -DestinationPath '.'"
del runtime.zip
echo.
cls

echo Verifying if the local_fixes.py file exists in the Fixes folder...
if exist "%fixesFolder%\%localFixesPy%" (
    echo Running the file...
    runtime\python.exe "%fixesFolder%\%localFixesPy%"
) else (
    echo The file "%localFixesPy%" was not found in the "Fixes" folder.
)
echo.

echo Applio has been updated!
echo.
echo Press 'Enter' to access the main menu...
pause>nul
cls
goto menu
