@echo off
REM Download an example project for building and debugging arm-code on a STM32VLDISCOVERY-Board

call SetArmVscodeEnvironmet.bat

IF ERRORLEVEL 1 (
echo Error during setup of environment
pause
EXIT /B 1
)

REM Goto the workspace
echo goto %WORKSPACE_DIR%
cd %WORKSPACE_DIR%

REM Check if not already downloaded
if NOT EXIST "STM32-Template\Demo" (
REM Fetch the project with git
  echo Get the Demo Code
  git.exe clone --recurse-submodules https://github.com/SWosnik/STM32-Template.git
)

REM  Goto the project directory
cd STM32-Template\Demo
REM and satrt Visual Studio Code
cmd /C code . ../../Readme.md