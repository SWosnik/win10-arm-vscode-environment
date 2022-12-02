@echo off
REM This batch installs the arm-gcc toolchain, including several tools like make, git and rm
REM under windows 10. The tools are only installed if they are not found in the path.

REM Check for required variables
if NOT DEFINED DOWNLOAD_DIR (
echo Download directory not defined
EXIT /B 1
)
if NOT DEFINED BIN_DIR (
echo Binary directory not defined
EXIT /B 1
)

REM Check for required directories
if NOT EXIST "%DOWNLOAD_DIR%" (
echo Download directory not found
EXIT /B 1
)
if NOT EXIST "%BIN_DIR%" (
echo Binary directory not found
EXIT /B 1
)

REM Check if tools are found
where /Q unzip.exe
IF ERRORLEVEL 1 set NOT_HAVE_UNZIP=1

REM Check if tools have been unziped
if DEFINED NOT_HAVE_UNZIP   if NOT EXIST "%BIN_DIR%\unzip"             set UNZIP_UNZIP=1

REM Check if we have all required Downloads
if DEFINED UNZIP_UNZIP  if NOT EXIST "%DOWNLOAD_DIR%\unzip-bin.zip"       set DOWNNLOAD_UNZIP=1

IF DEFINED NOT_HAVE_UNZIP (
  REM check if rm dir exists
  if DEFINED UNZIP_UNZIP (
    REM download commandline unzip if needed
    if DEFINED DOWNNLOAD_UNZIP (
      echo Download unzip
      curl -L https://gnuwin32.sourceforge.net/downlinks/unzip-bin-zip.php --output %DOWNLOAD_DIR%\unzip-bin.zip
    )
    REM unzip unzip
    echo unzip unzip
    PowerShell -Command "Expand-Archive -LiteralPath %DOWNLOAD_DIR%\unzip-bin.zip -DestinationPath %BIN_DIR%\unzip"
  )
  REM add unzip path
  set PATH=%BIN_DIR%\unzip\bin;%PATH%
)

IF DEFINED NOT_HAVE_VSCODE (
  REM check if vcode dir exists
  if DEFINED UNZIP_VSCODE (
    REM Download vcode if needed
    if NOT EXIST "%DOWNLOAD_DIR%\VSCode.zip" (
      echo Download Visual Studio Code
      curl -L "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-archive" --output %DOWNLOAD_DIR%\vscode.zip
    )

    REM extract VSCODE
    echo unzip Visual Studio Code
    unzip -q -o %DOWNLOAD_DIR%\vscode.zip -d %BIN_DIR%\vscode
    REM check if vcode settings exist and if not: generate a default
    if NOT EXIST "%AppData%\Roaming\Code\User\settings.json" (
      REM No Welcome Display
      mkdir %AppData%\Code\User
      echo { "workbench.startupEditor": "none" } > %AppData%\Code\User\settings.json
    )
  )
)

IF DEFINED NOT_HAVE_GCC (
  REM check if arm-gnu-toolchain dir exists
  if DEFINED UNZIP_GCC (
    REM Download toolchain if needed
    if NOT EXIST "%DOWNLOAD_DIR%\arm-none-eabi.zip" (
      echo arm gcc compiler toolchain
      curl -L "https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-mingw-w64-i686-arm-none-eabi.zip" --output %DOWNLOAD_DIR%\arm-none-eabi.zip
    )
    echo unzip toolchain
    REM unzip toolchain
    unzip -q -o %DOWNLOAD_DIR%\arm-none-eabi.zip -d %BIN_DIR%\
    REM rename tools-Path
    move %BIN_DIR%\arm-gnu-* %BIN_DIR%\arm-gnu-toolchain
  )
)

IF DEFINED NOT_HAVE_MAKE (
  REM check if make dir exists
  if DEFINED UNZIP_MAKE (
    REM get make if needed
    if DEFINED DOWNNLOAD_MAKE_BIN (
      echo Download make
      curl -L https://gnuwin32.sourceforge.net/downlinks/make-bin-zip.php --output %DOWNLOAD_DIR%\make-bin.zip
    )
    if DEFINED DOWNNLOAD_MAKE_DEP (
      curl -L https://gnuwin32.sourceforge.net/downlinks/make-dep-zip.php --output %DOWNLOAD_DIR%\make-dep.zip
    )
    REM and unzip
    echo unzip make
    unzip -q -o %DOWNLOAD_DIR%\make-bin.zip -d %BIN_DIR%\make
    unzip -q -o %DOWNLOAD_DIR%\make-dep.zip -d %BIN_DIR%\make
  )
)

IF DEFINED NOT_HAVE_UTILS (
  if DEFINED UNZIP_UTILS (
    REM get utils
    if DEFINED DOWNNLOAD_UTILS_BIN (
      echo Download ultilities
      curl -L https://gnuwin32.sourceforge.net/downlinks/coreutils-bin-zip.php --output %DOWNLOAD_DIR%\utils-bin.zip
    )

    if DEFINED DOWNNLOAD_UTILS_DEP (
      curl -L https://gnuwin32.sourceforge.net/downlinks/coreutils-dep-zip.php --output %DOWNLOAD_DIR%\utils-dep.zip
    )

    echo unzip utils
    unzip -q -o %DOWNLOAD_DIR%\utils-bin.zip -d %BIN_DIR%\utils
    unzip -q -o %DOWNLOAD_DIR%\utils-dep.zip -d %BIN_DIR%\utils
  )
)

IF DEFINED NOT_HAVE_GIT (
  if DEFINED UNZIP_GIT (
    REM get git
    if DEFINED DOWNLOAD_GIT (
      echo Download git
      curl -L https://github.com/git-for-windows/git/releases/download/v2.38.1.windows.1/MinGit-2.38.1-64-bit.zip --output %DOWNLOAD_DIR%\MinGit.zip
    )
    echo unzip git
    REM unzip git
    unzip -q -o %DOWNLOAD_DIR%\MinGit.zip -d %BIN_DIR%\git
  )
)

EXIT /B 0
