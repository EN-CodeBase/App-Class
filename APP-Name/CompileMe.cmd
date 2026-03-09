@echo off
setlocal enabledelayedexpansion

REM ================================
REM Check for AppImpl\Update.cpp
REM ================================
if not exist "AppImpl" (
    mkdir "AppImpl"
)

if not exist "AppImpl\Update.cpp" (
    (
    echo #include "../App.h"
    echo // INCLUDES
    echo #include ^<iostream^>
    echo.
    echo.
    echo // ----------------------------------
    echo // Static member definitions
    echo std::atomic_bool App::running{false};
    echo std::thread App::PrivateThread;
    echo using namespace std;
    echo // ----------------------------------
    echo.
    echo void App::Update^(^) {
    echo.
    echo /* TODO:    Add Main App Update Sequence Here   */
    echo.
    echo }
    ) > "AppImpl\Update.cpp"

    echo Compilation Stopped: Didnt find 'Update.cpp' in AppImpl. Created 'Update.cpp' in AppImpl
    exit /b 1
)

REM ================================
REM Compiler Settings
REM ================================
set CXX=g++
set CXXFLAGS=-std=c++20 -O2

REM Get parent folder name as exe name
for %%I in ("%CD%") do set "PARENT=%%~nxI"
set "OUTPUT=%PARENT%.exe"

set SRC_FILES=main.cpp
set LINK_ITEMS=

REM ================================
REM Gather source files
REM ================================
if exist "AppImpl" (
    for /r "AppImpl" %%F in (*.cpp) do (
        set "SRC_FILES=!SRC_FILES! "%%F""
    )
)

REM ================================
REM Gather DLLs only from AppImpl\bin
REM ================================
if exist "AppImpl\bin" (
    echo Linking Binaries in Bin
    for %%F in ("AppImpl\bin\*.dll") do (
        if exist "%%F" set "LINK_ITEMS=!LINK_ITEMS! "%%F""
        
    )
)

echo Compiling sources:
echo %SRC_FILES%

if not "%LINK_ITEMS%"=="" (
    echo Linking DLLs:
    echo %LINK_ITEMS%
)

REM ================================
REM Build
REM ================================
%CXX% %CXXFLAGS% %SRC_FILES% %LINK_ITEMS% -o "%OUTPUT%"

if %errorlevel%==0 (
    echo.
    echo Build complete: %OUTPUT%
) else (
    echo.
    echo Build failed.
)