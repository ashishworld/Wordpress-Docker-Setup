@echo off
setlocal enabledelayedexpansion

echo WordPress VPS Deployment Export Script
echo =======================================
echo.

REM Create export directory with timestamp
set "timestamp=%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "timestamp=%timestamp: =0%"
set "export_dir=exports\vps-deployment_%timestamp%"

if not exist "exports" mkdir exports
mkdir "%export_dir%"

echo Creating VPS deployment package in %export_dir%...
echo.

REM Copy all project files except node_modules and .git
echo Copying project files...
xcopy "docker-compose.yml" "%export_dir%\" /Y
xcopy ".env.example" "%export_dir%\" /Y
xcopy "uploads.ini" "%export_dir%\" /Y
xcopy "mysql" "%export_dir%\mysql\" /E /I /Y
xcopy "wordpress" "%export_dir%\wordpress\" /E /I /Y
xcopy "scripts" "%export_dir%\scripts\" /E /I /Y

REM Create production environment file
echo Creating production .env file...
(
echo # Production Database Configuration
echo DB_NAME=wordpress_prod
echo DB_USER=wordpress_prod
echo DB_PASSWORD=CHANGE_THIS_SECURE_PASSWORD
echo DB_ROOT_PASSWORD=CHANGE_THIS_ROOT_PASSWORD
echo DB_PORT=3306
echo.
echo # WordPress Configuration
echo WP_PORT=80
echo WP_DEBUG=false
echo WP_DEBUG_LOG=false
echo WP_DEBUG_DISPLAY=false
echo.
echo # phpMyAdmin Configuration
echo PMA_PORT=8081
echo.
echo # Environment
echo ENVIRONMENT=production
) > "%export_dir%\.env"

REM Create VPS deployment instructions
(
echo VPS DEPLOYMENT INSTRUCTIONS
echo ===========================
echo.
echo PREREQUISITES:
echo - Ubuntu/CentOS VPS with root access
echo - Domain pointed to VPS IP
echo - Ports 80, 443, 8081 open in firewall
echo.
echo 1. INSTALL DOCKER:
echo    # Update system
echo    sudo apt update ^&^& sudo apt upgrade -y
echo.
echo    # Install Docker
echo    curl -fsSL https://get.docker.com -o get-docker.sh
echo    sudo sh get-docker.sh
echo    sudo usermod -aG docker $USER
echo.
echo    # Install Docker Compose
echo    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s^)-$(uname -m^)" -o /usr/local/bin/docker-compose
echo    sudo chmod +x /usr/local/bin/docker-compose
echo.
echo 2. UPLOAD PROJECT:
echo    # Upload this entire folder to VPS (e.g., /var/www/wordpress^)
echo    scp -r . user@your-vps-ip:/var/www/wordpress/
echo.
echo 3. CONFIGURE ENVIRONMENT:
echo    # Edit .env file with secure passwords
echo    nano .env
echo.
echo 4. START SERVICES:
echo    cd /var/www/wordpress
echo    docker-compose up -d
echo.
echo 5. SETUP SSL (Optional but recommended^):
echo    # Install Nginx reverse proxy with SSL
echo    # Or use Cloudflare for SSL termination
echo.
echo 6. SETUP DOMAIN:
echo    # Point your domain A record to VPS IP
echo    # Access: http://your-domain.com
echo    # phpMyAdmin: http://your-domain.com:8081
echo.
echo 7. BACKUP SETUP:
echo    # Setup automated backups using scripts/backup.bat
echo    # Consider using cron jobs for regular backups
echo.
echo SECURITY NOTES:
echo - Change all default passwords in .env
echo - Use strong passwords (20+ characters^)
echo - Consider disabling phpMyAdmin in production
echo - Setup firewall rules
echo - Regular security updates
echo.
echo Export completed on: %date% %time%
) > "%export_dir%\VPS-DEPLOYMENT-GUIDE.txt"

echo.
echo ✅ VPS deployment package created successfully!
echo 📁 Location: %export_dir%
echo 📋 Check VPS-DEPLOYMENT-GUIDE.txt for deployment steps
echo.
pause