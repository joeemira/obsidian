@echo off
cd /d "C:\Users\youss\OneDrive\Documents\Obsidian Vault"

:: Check if Git is installed
git --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Git is not installed or not in PATH.
    exit /b
)

:: Pull latest changes from remote repository
echo Pulling changes from remote repository...
git pull origin main
if %ERRORLEVEL% neq 0 (
    echo Error pulling changes. Please resolve any conflicts manually.
    exit /b
)

:: Add all changes (including resolved conflicts)
echo Adding all changes...
git add --all
if %ERRORLEVEL% neq 0 (
    echo Error adding files!
    exit /b
)

:: Commit changes if needed (if there were new changes or resolved conflicts)
echo Committing changes...
git commit -m "Automated update: %date% %time%" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo No changes to commit.
) else (
    echo Changes committed.
)

:: Push changes to remote repository
echo Pushing changes to remote repository...
git push origin main
if %ERRORLEVEL% neq 0 (
    echo Error pushing to the repository!
    exit /b
)

echo Update complete.
pause
