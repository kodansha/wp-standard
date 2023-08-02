#!/usr/bin/env bash

#===============================================================================
# This script checks the diff of the most recent wp-starter Git tag
# and the most recent official Bedrock Git tag
#===============================================================================

set -uo pipefail

# Get the most recent Git tag
wp_starter_tag=`git describe --tags --abbrev=0`

pushd "$(dirname "$0")" >/dev/null 2>&1

git clone git@github.com:roots/bedrock.git >/dev/null 2>&1

pushd bedrock >/dev/null 2>&1

git pull

# Get the most recent Bedrock tag
bedrock_tag=`git describe --tags --abbrev=0`

echo "========================================================================="
echo $wp_starter_tag : The most recent wp-starter tag
echo ↓
echo $bedrock_tag : The most recent Bedrock tag
echo "========================================================================="

git difftool ${wp_starter_tag} ${bedrock_tag}
