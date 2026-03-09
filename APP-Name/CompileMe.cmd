@REM App-Tool-C++
@REM Copyright (c) 2026 Erli Nuraj

@REM This program is free software: you can redistribute it and/or modify
@REM it under the terms of the GNU General Public License as published by
@REM the Free Software Foundation, either version 3 of the License, or
@REM (at your option) any later version.

@REM This program is distributed in the hope that it will be useful,
@REM but WITHOUT ANY WARRANTY; without even the implied warranty of
@REM MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
@REM GNU General Public License for more details.

@REM You should have received a copy of the GNU General Public License
@REM along with this program. If not, see <https://www.gnu.org/licenses/>.

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

if not exist "AppImpl\Setup.cpp" (
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
    echo void App::Setup^(^) {
    echo.
    echo /* TODO:    Add App Setup Sequence Here   */
    echo.
    echo }
    ) > "AppImpl\Setup.cpp"

    echo Compilation Stopped: Didnt find 'Setup.cpp' in AppImpl. Created 'Setup.cpp' in AppImpl
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