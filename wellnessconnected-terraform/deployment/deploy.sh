#!/bin/bash

if [ -z $1 ]; then
	echo "module dir required."
	echo "Usage: deploy.sh dev"
fi
ENV_DIR="$1"

REL_BASE_DIR="../.."
WORKSPACE_DIR="cd_workspace"
BUILD_STAGING_DIR="cd_staging"
cd $REL_BASE_DIR
BASE_DIR=`pwd`
if [ ! -e $WORKSPACE_DIR ]; then
	echo $BASE_DIR/$WORKSPACE_DIR
	mkdir $WORKSPACE_DIR
fi
if [ ! -e $BUILD_STAGING_DIR ]; then
	echo $BASE_DIR/$BUILD_STAGING_DIR
	mkdir $BUILD_STAGING_DIR
fi

SRC_REPO="wellnessconnected-lambdas"
cd $WORKSPACE_DIR
if [ ! -e $SRC_REPO ]; then
	echo `pwd`
	git clone -v https://github.com/andengineering/$SRC_REPO.git
	cd $SRC_REPO
else
	echo "Getting latest for $SRC_REPO"
	cd $SRC_REPO
	git pull

fi

echo "Gathering dependencies for project: " `pwd`
cd dynamo-readings-create
npm install --production

cd $BASE_DIR/wellnessconnected-terraform/$ENV_DIR
terraform apply
