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

export WP_CLI_ALLOW_ROOT=1

# Install WordPress
wp core install \
  --url="http://dev.mylocaldoma.in" \
  --title="wp-standard" \
  --admin_user="admin" \
  --admin_password="admin" \
  --admin_email="admin@example.com" \
  --skip-email

# Activate plugins
wp plugin activate \
  wp-multibyte-patch

# Switch language to ja
wp site switch-language ja

# Set permalink structure
wp option update permalink_structure '/%postname%/'

# Set timezone
wp option update timezone_string 'Asia/Tokyo'

# Set date format
wp option update date_format 'Y年n月j日'

# Set time format
wp option update time_format 'H:i'

cat << EOS
================================================================================
セットアップ完了
================================================================================
Dev Container のセットアップが完了しました。

以下の URL から WordPress 管理画面にアクセスできます。初期管理者でログインしてください。

Admin URL : http://dev.mylocaldoma.in/wp/wp-login.php
User      : admin
Password  : admin

EOS
