#!/usr/bin/env bash

set -uo pipefail

WORKSPACE=/workspaces/wp-standard

cat << EOS

================================================================================
CMS のセットアップ
================================================================================
EOS

CMS_DIR=${WORKSPACE}/cms

cat << EOS
--------------------------------------------------------------------------------
Composer 依存パッケージのインストール
--------------------------------------------------------------------------------
EOS

cd $CMS_DIR
composer install

cat << EOS
--------------------------------------------------------------------------------
WordPress の設定
--------------------------------------------------------------------------------
EOS

# Install WordPress
wp core install \
  --url="http://mylocaldoma.in" \
  --title="wp-standard" \
  --admin_user="admin" \
  --admin_password="admin" \
  --admin_email="admin@example.com" \
  --skip-email \
  --allow-root

# Activate plugins
wp plugin activate \
  wp-multibyte-patch \
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

cat << EOS
================================================================================
セットアップ完了
================================================================================
Dev Container のセットアップが完了しました。

以下の URL から WordPress 管理画面にアクセスできます。初期管理者でログインしてください。

Admin URL : http://mylocaldoma.in/wp/wp-login.php
User      : admin
Password  : admin

EOS
