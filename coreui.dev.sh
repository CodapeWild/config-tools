#! /bin/bash

set -e

appName="coreui.dev"
if [ -z $1 ]; then
  echo "app name is empty, will use ${appName} as folder name"
else
  appName=$1
fi

npx create-react-app $appName

cd $appName

# add coreui dependences
yarn add @coreui/coreui
yarn add @coreui/react
yarn add @coreui/chartjs
yarn add @coreui/react-chartjs
yarn add @coreui/icons
yarn add @coreui/icons-react
yarn add @coreui/utils

# add react dependences
yarn add redux
yarn add react-redux
yarn add redux-thunk
yarn add react-router-dom

# sass
yarn add sass
