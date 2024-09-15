@echo off
cd /d "C:\Users\youss\OneDrive\Documents\Obsidian Vault"

:: Check if the directory exists
if not exist "C:\Users\youss\OneDrive\Documents\Obsidian Vault" (
    echo Directory does not exist!
    exit /b
)

:: List ignored files and check if any .md files are ignored
echo Checking for ignored .md files...
git check-ignore -v *.md
if %ERRORLEVEL% neq 0 (
    echo No .md files are being ignored.
) else (
    echo Some .md files are ignored! Forcing them to be added.
    git add -f *.md
)

:: Add all files (force add to ensure ignored files are included)
git add -f .
if %ERRORLEVEL% neq 0 (
    echo Error adding files!
    exit /b
)

:: Check the Git status to verify the files staged for commit
echo Checking files staged for commit...
git status

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
pause
