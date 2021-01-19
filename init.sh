#!/bin/bash

WUM_VERSION=3.0.6
USER_DIR=$(pwd)

git clone https://github.com/malinthaprasan/wso2-iass-setup
cd wso2-iass-setup

#install java
echo "-------------------"
echo "Installing JAVA ..."
echo "-------------------"
cd java
cat jdk-8u* > jdk-linux-x64.tar.gz
tar -xf jdk-linux-x64.tar.gz
JDK_FOLDER_NAME=$(find . -maxdepth 1  -type d -printf '%P\n' | tail -n 1)
cd -

export JDK_HOME=$USER_DIR/wso2-iass-setup/java/$JDK_FOLDER_NAME
echo JDK_HOME is taken as $JDK_HOME

sudo update-alternatives --install "/usr/bin/java" "java" "$JDK_HOME/bin/java" 1
sudo update-alternatives --config java

envsubst <  conf/profile >  conf/profile.env

cat /etc/profile conf/profile.env > profile-cat

echo "Final profile"
cat profile-cat
echo "============="

sudo mv profile-cat /etc/profile

# install maven
echo "-------------------"
echo "Installing MAVEN ..."
echo "-------------------"
cd maven
unzip apache-maven-3.6.2-bin.zip
export MVN_HOME=$USER_DIR/wso2-iass-setup/maven/apache-maven-3.6.2
sudo update-alternatives --install "/usr/bin/mvn" "mvn" "$MVN_HOME/bin/mvn" 1
cd -

# install unzip
echo "-------------------"
echo "Installing unzip .."
echo "-------------------"
sudo apt install unzip

# install wum
echo "-------------------"
echo "Installing WUM ...."
echo "-------------------"
cd $USER_DIR
wget http://product-dist.wso2.com/downloads/wum/$WUM_VERSION/wum-$WUM_VERSION-linux-x64.tar.gz
tar -xvf wum-$WUM_VERSION-linux-x64.tar.gz
WUM_HOME=$USER_DIR/wum
sudo update-alternatives --install "/usr/bin/wum" "wum" "$WUM_HOME/bin/wum" 1

# update packages
apt-get update

# install nvm and node
echo "---------------------------"
echo "Installing nvm and node...."
echo "---------------------------"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
nvm install 12.16.3

# install prism
echo "-----------------------------------------------"
echo "Installing prism : swagger/oas mock server ...."
echo "-----------------------------------------------"
npm install -g @stoplight/prism-cli@4.1.0
