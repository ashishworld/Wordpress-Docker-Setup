@echo off
setlocal enabledelayedexpansion

echo WordPress Backup Script
echo ========================
echo.

REM Create backup directory with timestamp
set "timestamp=%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "timestamp=%timestamp: =0%"
set "backup_dir=backups\backup_%timestamp%"

if not exist "backups" mkdir backups
mkdir "%backup_dir%"

echo 📦 Creating backup in %backup_dir%...
echo.

REM Backup database
echo 🗄️  Backing up database...
docker-compose exec -T db mysqldump -u root -prootpassword123 wordpress > "%backup_dir%\database.sql"

REM Backup WordPress files
echo 📁 Backing up WordPress files...
xcopy "wordpress" "%backup_dir%\wordpress_files\" /E /I /H /Y

REM Create backup info file
echo 📋 Creating backup information...
(
echo WordPress Backup Information
echo ============================
echo Backup Date: %date%
echo Backup Time: %time%
echo Database: wordpress
echo WordPress Version: Latest
echo.
echo Restore Instructions:
echo 1. Copy wordpress_files contents to wordpress/ directory
echo 2. Import database.sql using phpMyAdmin or MySQL command
echo 3. Restart Docker containers: docker-compose restart
) > "%backup_dir%\backup_info.txt"

echo.
echo ✅ Backup completed successfully!
echo 📁 Location: %backup_dir%
echo 📊 Backup Size:
dir "%backup_dir%" /s

echo.
pause