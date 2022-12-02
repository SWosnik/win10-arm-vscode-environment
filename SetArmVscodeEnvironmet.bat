@if NOT DEFINED DEBUG_BAT @echo off
REM Set the path for the development environmet and change to the working directory.
REM If necessary, first install missing tools.

REM Path of the directory where the downloads will be placed.
set DOWNLOAD_DIR=C:\users\WDAGUtilityAccount\Downloads
REM Path of the directory under which the executable file should be saved.
set BIN_DIR=C:\bin
REM Working directory of the envirronment
set WORKSPACE_DIR=C:\Users\WDAGUtilityAccount\Documents\Projects

echo DOWNLOAD_DIR: %DOWNLOAD_DIR%
echo BIN_DIR: %BIN_DIR%
echo WORKSPACE_DIR: %WORKSPACE_DIR%
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
if DEFINED UNZIP_VSCODE if NOT EXIST "%DOWNLOAD_DIR%\VSCode.zip"          set DOWNLOAD_VSCODE=1
if DEFINED UNZIP_GCC    if NOT EXIST "%DOWNLOAD_DIR%\arm-none-eabi.zip"   set DOWNLOAD_GCC=1
if DEFINED UNZIP_MAKE   if NOT EXIST "%DOWNLOAD_DIR%\make-bin.zip"        set DOWNLOAD_MAKE_BIN=1
if DEFINED UNZIP_MAKE   if NOT EXIST "%DOWNLOAD_DIR%\make-dep.zip"        set DOWNLOAD_MAKE_DEP=1
if DEFINED UNZIP_UTILS  if NOT EXIST "%DOWNLOAD_DIR%\utils-bin.zip"       set DOWNLOAD_UTILS_BIN=1
if DEFINED UNZIP_UTILS  if NOT EXIST "%DOWNLOAD_DIR%\utils-dep.zip"       set DOWNLOAD_UTILS_DEP=1
if DEFINED UNZIP_GIT    if NOT EXIST "%DOWNLOAD_DIR%\MinGit.zip"          set DOWNLOAD_GIT=1

REM Install missing tools
if DEFINED UNZIP_VSCODE set CALL_INSTALL_BAT=1
if DEFINED UNZIP_GCC      set CALL_INSTALL_BAT=1
if DEFINED UNZIP_MAKE    set CALL_INSTALL_BAT=1
if DEFINED UNZIP_UTILS  set CALL_INSTALL_BAT=1
if DEFINED UNZIP_GIT      set CALL_INSTALL_BAT=1

if DEFINED DEBUG_BAT (
  @echo NOT_HAVE_VSCODE: %NOT_HAVE_VSCODE%
  @echo NOT_HAVE_GCC: %NOT_HAVE_GCC%
  @echo NOT_HAVE_MAKE: %NOT_HAVE_MAKE%
  @echo NOT_HAVE_UTILS: %NOT_HAVE_UTILS%
  @echo NOT_HAVE_GIT: %NOT_HAVE_GIT%
  @echo UNZIP_VSCODE: %UNZIP_VSCODE%
  @echo UNZIP_GCC: %UNZIP_GCC%
  @echo UNZIP_MAKE: %UNZIP_MAKE%
  @echo UNZIP_MAKE: %UNZIP_MAKE%
  @echo UNZIP_UTILS: %UNZIP_UTILS%
  @echo UNZIP_UTILS: %UNZIP_UTILS%
  @echo UNZIP_GIT: %UNZIP_GIT%
  @echo DOWNLOAD_VSCODE: %DOWNLOAD_VSCODE%
  @echo DOWNLOAD_GCC: %DOWNLOAD_GCC%
  @echo DOWNLOAD_MAKE_BIN: %DOWNLOAD_MAKE_BIN%
  @echo DOWNLOAD_MAKE_DEP: %DOWNLOAD_MAKE_DEP%
  @echo DOWNLOAD_UTILS_BIN: %DOWNLOAD_UTILS_BIN%
  @echo DOWNLOAD_UTILS_DEP: %DOWNLOAD_UTILS_DEP%
  @echo DOWNLOAD_GIT: %DOWNLOAD_GIT%
  @echo CALL_INSTALL_BAT: %CALL_INSTALL_BAT%
  pause
)

if DEFINED CALL_INSTALL_BAT (
  echo Install missing tools
  call ToolChainInstall.bat

  IF ERRORLEVEL 1 (
  echo Error during the installation of the tools
  pause
  EXIT /B 1
  )
)


Rem expand the path
IF DEFINED NOT_HAVE_VSCODE set path=%BIN_DIR%\vscode;%PATH%
IF DEFINED NOT_HAVE_GCC set PATH=%BIN_DIR%\arm-gnu-toolchain\bin;%PATH%
IF DEFINED NOT_HAVE_MAKE set PATH=%BIN_DIR%\make\bin;%PATH%
IF DEFINED NOT_HAVE_UTILS set PATH=%BIN_DIR%\utils\bin;%PATH%
IF DEFINED NOT_HAVE_GIT PATH=%BIN_DIR%\git\cmd;%PATH%

EXIT /B 0
