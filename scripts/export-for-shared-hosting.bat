@echo off
setlocal enabledelayedexpansion

echo WordPress Shared Hosting Export Script
echo =======================================
echo.

REM Create export directory with timestamp
set "timestamp=%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "timestamp=%timestamp: =0%"
set "export_dir=exports\shared-hosting-export_%timestamp%"

if not exist "exports" mkdir exports
mkdir "%export_dir%"
mkdir "%export_dir%\website-files"
mkdir "%export_dir%\database"

echo Creating export in %export_dir%...
echo.

REM Export WordPress files (excluding wp-config.php)
echo Exporting WordPress files...
xcopy "wordpress\*" "%export_dir%\website-files\" /E /I /H /Y /EXCLUDE:exclude-files.txt

REM Export database
echo Exporting database...
docker-compose exec -T db mysqldump -u root -p%DB_ROOT_PASSWORD% %DB_NAME% > "%export_dir%\database\wordpress.sql"

REM Create deployment instructions
echo Creating deployment instructions...
(
echo SHARED HOSTING DEPLOYMENT INSTRUCTIONS
echo =====================================
echo.
echo 1. UPLOAD FILES:
echo    - Upload all files from 'website-files' folder to your hosting public_html directory
echo    - Make sure to upload .htaccess file if present
echo.
echo 2. CREATE DATABASE:
echo    - Create a new MySQL database in cPanel
echo    - Create a database user and assign to the database
echo    - Note down: database name, username, password, and host
echo.
echo 3. IMPORT DATABASE:
echo    - Go to phpMyAdmin in cPanel
echo    - Select your database
echo    - Click Import tab
echo    - Upload the wordpress.sql file from 'database' folder
echo.
echo 4. UPDATE WP-CONFIG.PHP:
echo    - Edit wp-config.php in the website files
echo    - Update database credentials:
echo      define('DB_NAME', 'your_database_name'^);
echo      define('DB_USER', 'your_database_user'^);
echo      define('DB_PASSWORD', 'your_database_password'^);
echo      define('DB_HOST', 'localhost'^);
echo.
echo 5. UPDATE SITE URLs:
echo    - In phpMyAdmin, go to wp_options table
echo    - Update 'siteurl' and 'home' values to your domain
echo    - Or use WordPress CLI/plugins for URL replacement
echo.
echo 6. SET FILE PERMISSIONS:
echo    - Folders: 755
echo    - Files: 644
echo    - wp-config.php: 600
echo.
echo Export completed on: %date% %time%
echo Local development URL: http://localhost:8080
echo.
) > "%export_dir%\DEPLOYMENT-INSTRUCTIONS.txt"

REM Create exclude file for future exports
(
echo wp-config.php
echo .htaccess
) > exclude-files.txt

echo.
echo ✅ Export completed successfully!
echo 📁 Location: %export_dir%
echo 📋 Check DEPLOYMENT-INSTRUCTIONS.txt for upload steps
echo.
pause