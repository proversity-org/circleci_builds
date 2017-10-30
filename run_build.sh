#!/usr/bin/env bash

echo "Setting up for run"

docker_check = "$(sudo docker -v)"

if [[ "$docker_check" == *"not found"* ]]; then
  sudo apt-get -y install docker
  sudo apt-get -y install docker.io

fi

circle_check = "$(ls /usr/local/bin/circleci)"

if [[ "$circle_check" == *"No such file or directory"* ]]; then
  sudo apt-get -y install --reinstall curl
  sudo curl -o /usr/local/bin/circleci https://circle-downloads.s3.amazonaws.com/releases/build_agent_wrapper/circleci && sudo chmod +x /usr/local/bin/circleci
fi

echo "Setup done, running build for $1"

if [[ "$1" == "development" ]]; then
  cd ./development
  sudo circleci build

  echo "circle run complete exiting"
  exit $?
fi