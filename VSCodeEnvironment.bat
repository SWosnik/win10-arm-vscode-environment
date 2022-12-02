@echo off

call SetArmVscodeEnvironmet.bat

IF ERRORLEVEL 1 (
echo Error during setup of environment
EXIT /B 1
)

REM Goto the workspace
echo goto %WORKSPACE_DIR%
cd %WORKSPACE_DIR%

REM Switch to an new commandshell
cmd /K dir
