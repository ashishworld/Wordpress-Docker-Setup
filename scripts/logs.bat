@echo off
echo WordPress Docker Logs
echo.
echo Choose an option:
echo 1. View all logs
echo 2. View WordPress logs only
echo 3. View Database logs only
echo 4. View phpMyAdmin logs only
echo 5. Follow live logs
echo.
set /p choice="Enter your choice (1-5): "

if "%choice%"=="1" (
    docker-compose logs
) else if "%choice%"=="2" (
    docker-compose logs wordpress
) else if "%choice%"=="3" (
    docker-compose logs db
) else if "%choice%"=="4" (
    docker-compose logs phpmyadmin
) else if "%choice%"=="5" (
    docker-compose logs -f
) else (
    echo Invalid choice!
)

pause