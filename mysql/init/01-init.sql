-- WordPress Database Initialization
-- This script runs when the MySQL container starts for the first time

-- Create additional databases if needed
-- CREATE DATABASE IF NOT EXISTS wordpress_staging;
-- CREATE DATABASE IF NOT EXISTS wordpress_test;

-- Set MySQL configurations for WordPress
SET GLOBAL sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

-- Optimize MySQL for WordPress
SET GLOBAL innodb_buffer_pool_size = 128M;
SET GLOBAL max_connections = 100;