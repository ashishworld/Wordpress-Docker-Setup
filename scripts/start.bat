@echo off
echo Starting WordPress Development Environment...
echo.

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Error: Docker is not running. Please start Docker Desktop.
    pause
    exit /b 1
)

REM Check if .env file exists
if not exist ".env" (
    echo Creating .env file from template...
    copy ".env.example" ".env"
    echo ⚠️  Please edit .env file with your configuration before running again.
    pause
    exit /b 1
)

echo 🚀 Building and starting containers...
docker-compose up -d --build

echo.
echo ⏳ Waiting for services to be ready...
timeout /t 30 /nobreak >nul

echo.
echo 🎉 WordPress Development Environment Started!
echo.
echo 🌐 WordPress URL: http://localhost:8080
echo 🗄️  phpMyAdmin URL: http://localhost:8081
echo.
echo 📊 Container Status:
docker-compose ps

echo.
echo 💡 Next Steps:
echo 1. Open http://localhost:8080 to setup WordPress
echo 2. Use phpMyAdmin at http://localhost:8081 for database management
echo 3. Start developing your WordPress site!
echo.
echo 📋 Available Commands:
echo - scripts\stop.bat          (Stop environment)
echo - scripts\logs.bat          (View logs)
echo - scripts\backup.bat        (Create backup)
echo - scripts\export-for-shared-hosting.bat (Export for shared hosting)
echo - scripts\export-for-vps.bat (Export for VPS deployment)
echo.
pause