#!/usr/bin/env bash

set -euo pipefail

WORKSPACE=$(pwd)

cat << EOS

================================================================================
事前チェックを行なっています...
================================================================================
EOS

CMS_ENV_PATH="cms/.env"

if [ ! -f ${CMS_ENV_PATH} ]; then
  echo "${CMS_ENV_PATH} が存在しません。${CMS_ENV_PATH}.example からコピーして作成します。"
  cp ${CMS_ENV_PATH}.example ${CMS_ENV_PATH}
else
  echo "${CMS_ENV_PATH} ...OK"
fi

cat << EOS

...チェック完了
EOS
