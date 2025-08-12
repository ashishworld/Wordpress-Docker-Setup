# WordPress Docker Development Environment

A complete Docker-based WordPress development environment designed for Kwebmaker WP Developers. Supports both local development and deployment to VPS servers or shared hosting environments.

## 🎯 Perfect For Wordpress Dev Team

This setup is specifically designed for agencies that:
- Develop WordPress sites locally
- Deploy to various hosting environments (VPS/Shared Hosting)
- Need consistent development environments across team
- Want easy client project handoffs

## 🚀 Quick Start

### Prerequisites
- **Docker Desktop** installed and running
- **Git** (optional, for version control)
- **Basic command line knowledge**

### Setup Steps
1. **Clone/Download** this repository
2. **Run setup script**:
   ```bash
   scripts\start.bat
   ```
3. **Access your site**:
   - WordPress: http://localhost:8080
   - phpMyAdmin: http://localhost:8081

## 📁 Project Structure

```
wordpress-docker/
├── docker-compose.yml          # Single Docker configuration (dev + prod)
├── .env                        # Environment variables
├── .env.example               # Environment template
├── uploads.ini                # PHP 8.3 configuration
├── wordpress/                 # WordPress files (latest version)
├── mysql/
│   └── init/
│       └── 01-init.sql       # MySQL initialization
├── scripts/
│   ├── start.bat             # Start development environment
│   ├── stop.bat              # Stop environment
│   ├── backup.bat            # Create backups
│   ├── logs.bat              # View container logs
│   ├── export-for-shared-hosting.bat  # Export for cPanel/shared hosting
│   └── export-for-vps.bat    # Export for VPS deployment
├── exports/                   # Deployment packages
└── backups/                  # Local backups
```

## 🛠️ Services & Ports

| Service | Port | Purpose |
|---------|------|---------|
| **WordPress** | 8080 | Main development site |
| **phpMyAdmin** | 8081 | Database management |
| **MySQL** | 3306 | Database (internal + external access) |

## 🔧 Configuration

### Environment Variables (.env)
```bash
# Database
DB_NAME=wordpress
DB_USER=wordpress
DB_PASSWORD=wordpress123
DB_ROOT_PASSWORD=rootpassword123

# WordPress
WP_PORT=8080
WP_DEBUG=false

# phpMyAdmin
PMA_PORT=8081
```

### PHP Settings (uploads.ini)
- **PHP Version**: 8.3 (Latest Stable)
- **Memory Limit**: 512M
- **Upload Limit**: 128M
- **Execution Time**: 600s

## 📋 Development Workflow

### 1. Start Development
```bash
scripts\start.bat
```

### 2. Develop Your Site
- Access WordPress at http://localhost:8080
- Install themes, plugins, create content
- Use phpMyAdmin for database operations

### 3. Create Backups
```bash
scripts\backup.bat
```

### 4. Deploy to Client

#### For VPS Clients:
```bash
scripts\export-for-vps.bat
```
- Creates complete Docker deployment package
- Includes deployment instructions
- Ready for VPS with Docker support

#### For Shared Hosting Clients:
```bash
scripts\export-for-shared-hosting.bat
```
- Exports WordPress files + database
- Includes step-by-step cPanel instructions
- Ready for traditional hosting upload

## 🚀 Deployment Options

### Option 1: VPS Deployment (Recommended)
**Best for clients with VPS/Cloud servers**

1. Run `scripts\export-for-vps.bat`
2. Upload package to VPS
3. Install Docker on VPS
4. Run `docker-compose up -d`
5. Configure domain/SSL

**Advantages:**
- Identical environment (dev = prod)
- Easy updates and maintenance
- Better performance and security
- Automated backups

### Option 2: Shared Hosting Deployment
**For clients with cPanel/shared hosting**

1. Run `scripts\export-for-shared-hosting.bat`
2. Upload files via FTP/File Manager
3. Import database via phpMyAdmin
4. Update wp-config.php with hosting credentials
5. Update site URLs in database

**Advantages:**
- Works with any hosting provider
- No server management required
- Cost-effective for small sites

## 🔒 Security Best Practices

### Development
- Default passwords for convenience
- Debug mode available
- All ports accessible locally

### Production
- **Change all passwords** in .env
- **Disable debug mode**
- **Use HTTPS/SSL certificates**
- **Regular security updates**
- **Firewall configuration**
- **Regular backups**

## 🛠️ Common Commands

```bash
# Start environment
scripts\start.bat

# Stop environment
scripts\stop.bat

# View logs
scripts\logs.bat

# Create backup
scripts\backup.bat

# Export for shared hosting
scripts\export-for-shared-hosting.bat

# Export for VPS
scripts\export-for-vps.bat

# Manual Docker commands
docker-compose up -d          # Start services
docker-compose down           # Stop services
docker-compose ps             # View status
docker-compose logs           # View all logs
docker-compose restart       # Restart services
```

## 💾 Data Management

### Persistent Data
- **Database**: Stored in Docker volume `db_data`
- **WordPress Files**: Stored in `./wordpress/` directory
- **Uploads**: Accessible via WordPress admin

### Backups
- **Automatic**: Use `scripts\backup.bat`
- **Manual**: Copy `wordpress/` folder + export database
- **Scheduled**: Set up cron jobs for regular backups

## 🐛 Troubleshooting

### Common Issues

**WordPress not accessible**
```bash
# Check if Docker is running
docker info

# Check container status
docker-compose ps

# View logs
scripts\logs.bat
```

**Database connection errors**
```bash
# Wait for MySQL initialization (30-60 seconds)
# Check database credentials in .env
# Restart containers
docker-compose restart
```

**Port conflicts**
```bash
# Change ports in .env file
WP_PORT=8090
PMA_PORT=8091
```

**Permission issues**
```bash
# Ensure Docker has access to project directory
# Check file permissions on mounted volumes
```

### Health Checks
```bash
# Check service status
docker-compose ps

# Test WordPress
curl http://localhost:8080

# Test phpMyAdmin
curl http://localhost:8081

# Check database
docker-compose exec db mysql -u root -p
```

## 👥 Team Collaboration

### Setup for New Developers
1. **Clone repository**
2. **Copy `.env.example` to `.env`**
3. **Run `scripts\start.bat`**
4. **Start developing!**

### Version Control
- **Include**: All project files, scripts, documentation
- **Exclude**: `.env`, `wordpress/wp-config.php`, `backups/`, `exports/`
- **Share**: `.env.example` with team for reference

### Project Handoff
1. **Create client documentation**
2. **Export appropriate deployment package**
3. **Provide deployment instructions**
4. **Include maintenance guidelines**

## 📚 Additional Resources

- [WordPress Documentation](https://wordpress.org/support/)
- [Docker Documentation](https://docs.docker.com/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [phpMyAdmin Documentation](https://www.phpmyadmin.net/docs/)

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Test changes thoroughly
4. Commit changes (`git commit -m 'Add amazing feature'`)
5. Push to branch (`git push origin feature/amazing-feature`)
6. Open Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 🎉 Ready to Start?

1. **Run**: `scripts\start.bat`
2. **Open**: http://localhost:8080
3. **Develop**: Your WordPress site
4. **Deploy**: Using export scripts
5. **Repeat**: For next client project!

**Happy WordPress Development! 🚀**
