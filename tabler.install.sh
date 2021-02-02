#! /bin/bash
# install tabler for macos

set -e

nodeVersion=$(node -v)
if [ -z "${nodeVersion}" ]; then
  brew install node
else
  echo "nodejs version:${nodeVersion}"
fi

rubyVersion=$(ruby -v)
if [ -z "${rubyVersion}" ]; then
  brew intall ruby@2.5
else
  echo "ruby version:${rubyVersion}"
fi
