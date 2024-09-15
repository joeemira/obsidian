@echo off
cd /d "C:\Users\youss\OneDrive\Documents\Obsidian Vault"

:: Check if the directory exists
if not exist "C:\Users\youss\OneDrive\Documents\Obsidian Vault" (
    echo Directory does not exist!
    exit /b
)

:: Add changes
git add .
if %ERRORLEVEL% neq 0 (
    echo Error adding files!
    exit /b
)

:: Commit changes with current date and time
git commit -m "Automated update: %date% %time%"
if %ERRORLEVEL% neq 0 (
    echo Error committing files!
    exit /b
)

:: Push to remote repository
git push
if %ERRORLEVEL% neq 0 (
    echo Error pushing to the repository!
    exit /b
)

echo Update complete.
