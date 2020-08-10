#!/bin/bash

USER_DIR=$(pwd)

git clone https://github.com/malinthaprasan/wso2-iass-setup
cd wso2-iass-setup

#install java
cd java
cat jdk-8u* > jdk-linux-x64.tar.gz
tar -xvf jdk-linux-x64.tar.gz
JDK_FOLDER_NAME=$(find . -maxdepth 1  -type d -printf '%P\n' | tail -n 1)
cd -

sudo update-alternatives --install "/usr/bin/java" "java" "$USER_DIR/wso2-iass-setup/java/$JDK_FOLDER_NAME/bin/java" 1
sudo update-alternatives --config java

cat /etc/profile conf/profile > profile-cat
sudo mv profile-cat /etc/profile

# install maven
sudo apt update
sudo apt install maven

# install unzip
sudo apt install unzip

# install nvm and node
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
# nvm install 8.9.4

