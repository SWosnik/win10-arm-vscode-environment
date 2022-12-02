@echo off
REM Set the path for the development environmet and change to the working directory.
REM If necessary, first install missing tools.

REM Path of the directory where the downloads will be placed.
set DOWNLOAD_DIR=C:\users\WDAGUtilityAccount\Downloads
REM Path of the directory under which the executable file should be saved.
set BIN_DIR=C:\bin
REM Working directory of the envirronment
set WORKSPACE_DIR=C:\Users\WDAGUtilityAccount\Documents\Projects

REM Check if all required tools are found

REM Check if tools are found
where /Q code.exe
IF ERRORLEVEL 1 set NOT_HAVE_VSCODE=1
where /Q arm-none-eabi-gcc.exe
IF ERRORLEVEL 1 set NOT_HAVE_GCC=1
where /Q make.exe
IF ERRORLEVEL 1 set NOT_HAVE_MAKE=1
where /Q gmkdir.exe
IF ERRORLEVEL 1 set NOT_HAVE_UTILS=1
where /Q git.exe
IF ERRORLEVEL 1 set NOT_HAVE_GIT=1

REM Check if tools have been unziped
if DEFINED NOT_HAVE_VSCODE  if NOT EXIST "%BIN_DIR%\vscode"            set UNZIP_VSCODE=1
if DEFINED NOT_HAVE_GCC     if NOT EXIST "%BIN_DIR%\arm-gnu-toolchain" set UNZIP_GCC=1
if DEFINED NOT_HAVE_MAKE    if NOT EXIST "%BIN_DIR%\make"              set UNZIP_MAKE=1
if DEFINED NOT_HAVE_UTILS   if NOT EXIST "%BIN_DIR%\utils"             set UNZIP_UTILS=1
if DEFINED NOT_HAVE_GIT     if NOT EXIST "%BIN_DIR%\git"               set UNZIP_GIT=1

REM Check if we have all required Downloads
if DEFINED UNZIP_VSCODE if NOT EXIST "%DOWNLOAD_DIR%\VSCode.zip"          set DOWNNLOAD_VSCODE=1
if DEFINED UNZIP_GCC    if NOT EXIST "%DOWNLOAD_DIR%\arm-none-eabi.zip"   set DOWNNLOAD_GCC=1
if DEFINED UNZIP_MAKE   if NOT EXIST "%DOWNLOAD_DIR%\make-bin.zip"        set DOWNNLOAD_MAKE_BIN=1
if DEFINED UNZIP_MAKE   if NOT EXIST "%DOWNLOAD_DIR%\make-dep.zip"        set DOWNNLOAD_MAKE_DEP=1
if DEFINED UNZIP_UTILS  if NOT EXIST "%DOWNLOAD_DIR%\utils-bin.zip"       set DOWNNLOAD_UTILS_BIN=1
if DEFINED UNZIP_UTILS  if NOT EXIST "%DOWNLOAD_DIR%\utils-dep.zip"       set DOWNNLOAD_UTILS_DEP=1
if DEFINED UNZIP_GIT    if NOT EXIST "%DOWNLOAD_DIR%\MinGit.zip"          set DOWNNLOAD_GIT=1

REM Install missing tools
if NOT DEFINED DOWNNLOAD_VSCODE if NOT DEFINED DOWNNLOAD_GCC if NOT DEFINED DOWNNLOAD_MAKE_BIN if NOT DEFINED DOWNNLOAD_MAKE_DEP if NOT DEFINED DOWNNLOAD_UTILS_BIN if NOT DEFINED DOWNNLOAD_UTILS_DEP if NOT DEFINED DOWNNLOAD_GIT call ToolchainInstall.bat
IF ERRORLEVEL 1 (
echo Error during the installation of the tools
EXIT /B 1
)

Rem expand the path
IF DEFINED NOT_HAVE_VSCODE set path=%BIN_DIR%\vscode;%PATH%
IF DEFINED NOT_HAVE_GCC set PATH=%BIN_DIR%\arm-gnu-toolchain\bin;%PATH%
IF DEFINED NOT_HAVE_MAKE set PATH=%BIN_DIR%\make\bin;%PATH%
IF DEFINED NOT_HAVE_UTILS set PATH=%BIN_DIR%\utils\bin;%PATH%
IF DEFINED NOT_HAVE_GIT PATH=%BIN_DIR%\git\cmd;%PATH%

