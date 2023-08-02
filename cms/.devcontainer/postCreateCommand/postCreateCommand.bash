#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR=/workspaces/wp-standard/cms

cd $ROOT_DIR
composer install

# Install WordPress
wp core install \
  --url="http://localhost.localdomain" \
  --title="wp-standard" \
  --admin_user="admin" \
  --admin_password="admin" \
  --admin_email="admin@example.com" \
  --skip-email \
  --allow-root

# Activate plugins
wp plugin activate \
  killer-pads \
  --allow-root

# Switch language to ja
wp site switch-language ja --allow-root

# Set permalink structure
wp option update permalink_structure '/%postname%/' --allow-root

# Set timezone
wp option update timezone_string 'Asia/Tokyo' --allow-root

# Set date format
wp option update date_format 'Y年n月j日' --allow-root

# Set time format
wp option update time_format 'H:i' --allow-root
