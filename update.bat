@echo off
cd /d "C:\Users\youss\OneDrive\Documents\Obsidian Vault"

:: Check if the directory exists
if not exist "C:\Users\youss\OneDrive\Documents\Obsidian Vault" (
    echo Directory does not exist!
    exit /b
)

:: Check if there is a .gitignore file that might be excluding .md files
echo Checking for ignored .md files...
git check-ignore -v *.md
if %ERRORLEVEL% neq 0 (
    echo No .md files are being ignored.
) else (
    echo Some .md files are ignored! Consider updating your .gitignore file.
)

:: Add all files, force add in case .md files are ignored
git add -f .
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
