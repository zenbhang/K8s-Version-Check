#!/bin/bash

CONFIRMATIONS='ynYN'

echo ''
echo ''
echo "______________________________________________________________________________"

cat << "EOF"
 __      ________ _____   _____ _____ ____  _   _    _____ _    _ ______ _____ _  __
 \ \    / /  ____|  __ \ / ____|_   _/ __ \| \ | |  / ____| |  | |  ____/ ____| |/ /
  \ \  / /| |__  | |__) | (___   | || |  | |  \| | | |    | |__| | |__ | |    | ' / 
   \ \/ / |  __| |  _  / \___ \  | || |  | | . ` | | |    |  __  |  __|| |    |  <  
    \  /  | |____| | \ \ ____) |_| || |__| | |\  | | |____| |  | | |___| |____| . \ 
     \/   |______|_|  \_\_____/|_____\____/|_| \_|  \_____|_|  |_|______\_____|_|\_\
EOF
echo "__________________________________________________________________Open Edition"
echo "Made by Ben Zhang (zenbhang)__________________________________________________"
echo ""
echo "Please be signed into the correct profile/SAML before starting."
echo ""
echo "Checking for kubectx..."
if brew ls --versions kubectx > /dev/null; then
  # The package is installed
  echo 'KUBECTX is installed. Continuing...'
else
  # The package is not installed
  echo 'KUBECTX is not installed, installing via brew.'
  brew install kubectx
fi

echo ''
#env selection
kubectx
echo ''
echo ''
echo 'Which environment are you checking versions for?'
read env

versionCheck(){

	echo ""
	echo "VERSIONS IN KUBERNETES IN "$1
	echo "___________________________________"
	kubectl get deployments --all-namespaces -o jsonpath="{..image}" | tr -s '[[:space:]]' '\n'
	sleep 3

}

echo ''
echo "Do you want to compare versions with another context? (Y/N)"
echo "(Please ensure that you are signed in on both already.)"
read confirmation
while [[ $CONFIRMATIONS != *$confirmation* ]]; do
	echo 'Please respond Y or N.'
	read confirmation
done
if [[ 'yY' == *$confirmation* ]]; then
	echo ''
	echo ''
	echo 'Which environment are you comparing versions for?'
	kubectx
	read env2
	kubectx $env
	versionCheck $env
	echo ""
	kubectx $env2
	versionCheck $env2
else
	echo "Checking versions for "$env
	versionCheck $env
fi



