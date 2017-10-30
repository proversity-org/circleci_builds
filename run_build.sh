#!/usr/bin/env bash
set -o pipefail
echo "Setting up for run"

DOCKER_CHECK=$(sudo docker -v)

if [[ $? -eq 1 ]]; then
  echo "installing docker"
  sudo apt-get -y install docker &wait
  sudo apt-get -y install docker.io
fi

CIRCLE_CHECK=$(ls /usr/local/bin/circleci)

if [[ $? -eq 1 ]]; then
  echo "installing circle cli"
  sudo apt-get -y install --reinstall curl
  sudo curl -o /usr/local/bin/circleci https://circle-downloads.s3.amazonaws.com/releases/build_agent_wrapper/circleci && sudo chmod +x /usr/local/bin/circleci
fi

echo "Setup done, running build for $1"

cd ./$1
sudo circleci build

echo "circle run complete exiting with code $?"
exit $?
