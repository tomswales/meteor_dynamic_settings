#!/bin/sh

echo "*****"
echo "Welcome to MY EXAMPLE APP"
echo "*****"
echo ""
echo "To get started, enter the following data"
echo ""
echo "Please enter your very sensitive XYZ API key"
read APIKEY1
echo ""
echo "Please enter your very sensitive ABC API key"
read APIKEY2

METEOR_VARIABLES='{
	"public": {
    
  },
  "private": {
    "xzy_api" : {
              "secret_key": "'"$APIKEY1"'",
          },
    "abc_api" : {
              "secret_key": "'"$APIKEY2"'",
          }
  }
}'

meteor build ../my_example_app_build
cd ../my_example_app_build
tar -xvf my_example_ap.tar.gz
if cd bundle; then
	(cd programs/server && npm install)
	ROOT_URL=http://example.com PORT=3000 METEOR_SETTINGS=$METEOR_VARIABLES node ./main.js > app.log 2>&1
else
	echo "Build was not successful." 1>&2
	exit 1
fi
