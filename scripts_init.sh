#!/bin/bash
# This script help to initialize global variables used by all scripts

WORK_DIR=$(pwd)
SCRIPT_DIR="$WORK_DIR/"$(dirname "$0")
REMOTE_REPO=""
REMOTE_CUSTOM_REPO=""
BRANCH=""
ROM_NAME=""
BUILD_ROOT_PATH=""
USER_NAME=""
CUSTOM_ROOT_PATH=""
STANDARD_TOOLCHAIN_VERSION=""
LUNCH_PREFIX=""
LUNCH_SUFFIX=""

echo "Scripts Initializer - Prepare variables for scripts execution"
echo "-------------------------------------------------------------"
echo "Run this script in the root of your build project [ex. ~/android/AOSP]"
echo "Be sure to use ~/android/ as your main path for all the projects"
read -n 1 -p "Are you in the right folder? [Y/n] " USER_RESPONSE

case $USER_RESPONSE in
	""|"y"|"Y")
		echo ""
		echo "Let's set things up!" ;;
	*)
		echo ""
		echo "Be sure to launch this script from your project's root folder!"
		echo "Exiting"
		exit ;;
esac

echo ""
echo "-------------------------------------------------------------"
read -p "REMOTE_REPO (the repo you want to init) = " REMOTE_REPO

read -p "REMOTE_CUSTOM_REPO (your custom repo you want to init [ex. https://github.com/UserName]) = " REMOTE_CUSTOM_REPO

read -p "BRANCH (the branch to sync in REMOTE_REPO [ex. master]) = " BRANCH

read -p "ROM_NAME (the name of the rom, part of the project root  [ex. AOSP as in ~/android/>AOSP<]) = " ROM_NAME

echo "BUILD_ROOT_PATH (the current working dir, used to build upon) = $WORK_DIR"
BUILD_ROOT_PATH="~/android/$ROM_NAME"

read -p "USER_NAME (Your name, used in CUSTOM_ROOT_PATH where toolchains, logs etc are stored) = " USER_NAME

echo "CUSTOM_ROOT_PATH (Your custom path, where toolchains, logs etc are stored [ex. ~/android/USER_NAME]) = ~/android/$USER_NAME"
CUSTOM_ROOT_PATH="~/android/$USER_NAME"

read -p "STANDARD_TOOLCHAIN_VERSION (The standard version of the standard thoolchain) = " STANDARD_TOOLCHAIN_VERSION

read -p "LUNCH_PREFIX (The prefix used during lunch [ex. lunch LUNCH_PREFIX_hammerhead-userdebug) = " LUNCH_PREFIX

read -p "LUNCH_SUFFIX (The suffix used during lunch [ex. lunch aosp_hammerhead-LUNCH_SUFFIX) = " LUNCH_SUFFIX

echo "Saving variables in $SCRIPT_DIR/variables.var"

echo "#!/bin/bash" >$SCRIPT_DIR/variables.var
echo "# Global variables used by all scripts" >>$SCRIPT_DIR/variables.var
echo "" >>$SCRIPT_DIR/variables.var
echo "REMOTE_REPO=$REMOTE_REPO" >>$SCRIPT_DIR/variables.var
echo "REMOTE_CUSTOM_REPO=$REMOTE_CUSTOM_REPO" >>$SCRIPT_DIR/variables.var
echo "BRANCH=$BRANCH" >>$SCRIPT_DIR/variables.var
echo "ROM_NAME=$ROM_NAME" >>$SCRIPT_DIR/variables.var
echo "BUILD_ROOT_PATH=$BUILD_ROOT_PATH" >>$SCRIPT_DIR/variables.var
echo "USER_NAME=$USER_NAME" >>$SCRIPT_DIR/variables.var
echo "CUSTOM_ROOT_PATH=$CUSTOM_ROOT_PATH" >>$SCRIPT_DIR/variables.var
echo "STANDARD_TOOLCHAIN_VERSION=$STANDARD_TOOLCHAIN_VERSION" >>$SCRIPT_DIR/variables.var
echo "LUNCH_PREFIX=$LUNCH_PREFIX" >>$SCRIPT_DIR/variables.var
echo "LUNCH_SUFFIX=$LUNCH_SUFFIX" >>$SCRIPT_DIR/variables.var
