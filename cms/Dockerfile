# 本番用 Dockerfile のサンプル

# 公式 Node イメージ
# 後に Node 実行ファイルやライブラリをコピーするために利用する
FROM node:20-slim as node

# ベースイメージ
FROM ghcr.io/kodansha/bedrock:php8.3-fpm

# 公式の Docker Node イメージから必要なファイルをコピーする
# これは、deb パッケージのインストールに依存する依存関係パッケージのインストール (Python3) を避けるのと、
# Nodesource やその他インストーラーに依存すると、それらが変更されたり削除されたりした場合にまずいため。
COPY --from=node /usr/local/include/ /usr/local/include/
COPY --from=node /usr/local/lib/ /usr/local/lib/
COPY --from=node /usr/local/bin/ /usr/local/bin/
RUN corepack disable && corepack enable

RUN apt-get update && apt-get install -y \
    locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ロケールの構成
RUN sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen \
    && locale-gen
ENV LANG ja_JP.UTF-8

# PHP 設定のカスタマイズ
RUN { \
    echo 'memory_limit = 128M'; \
    echo 'post_max_size = 96M'; \
    echo 'upload_max_filesize = 64M'; \
    echo 'max_execution_time = 3600'; \
    echo 'max_input_time = 3600'; \
    echo ''; \
    echo '[mbstring]'; \
    echo 'mbstring.language = "Japanese"'; \
    } > /usr/local/etc/php/conf.d/custom.ini
