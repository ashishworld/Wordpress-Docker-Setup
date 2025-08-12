@echo off
echo WordPress Docker Environment Health Check
echo ==========================================
echo.

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo [FAIL] Docker is not running
    goto :end
) else (
    echo [PASS] Docker is running
)

REM Check if containers are running
echo.
echo Container Status:
docker-compose ps

echo.
echo Service Health Checks:
echo.

REM Check WordPress
echo Checking WordPress...
curl -s -o nul -w "WordPress HTTP Status: %%{http_code}\n" http://localhost:8080/wp-admin/install.php
if %errorlevel% equ 0 (
    echo [PASS] WordPress is responding
) else (
    echo [FAIL] WordPress is not responding
)

REM Check phpMyAdmin
echo.
echo Checking phpMyAdmin...
curl -s -o nul -w "phpMyAdmin HTTP Status: %%{http_code}\n" http://localhost:8081
if %errorlevel% equ 0 (
    echo [PASS] phpMyAdmin is responding
) else (
    echo [FAIL] phpMyAdmin is not responding
)

REM Check database connectivity
echo.
echo Checking Database...
docker-compose exec -T db mysqladmin ping -h localhost -u root -prootpassword123 >nul 2>&1
if %errorlevel% equ 0 (
    echo [PASS] Database is responding
) else (
    echo [FAIL] Database is not responding
)

:end
echo.
echo Health check completed.
pause