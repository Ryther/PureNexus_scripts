#!/bin/bash
# Repo init script

# Include global variables
if [ -f $(dirname "$0")/variables.var ]
	then
		source $(dirname "$0")/variables.var
	else
		source $(dirname "$0")/scripts_init.sh
		source $(dirname "$0")/variables.var
fi

echo "$USER_NAME"

# Initialize the repo
repo init -u ${REMOTE_REPO} -b ${BRANCH}

# Clone custom local_manifest
cd ${BUILD_ROOT_PATH}/.repo/
mkdir local_manifests
cd local_manifests
git clone ${REMOTE_CUSTOM_REPO}/${ROM_NAME}_local_manifests .

# Creater vendor symlink
# Create target path
mkdir -p ${BUILD_ROOT_PATH}/vendor/
# Create symlinks
ln -s ${CUSTOM_ROOT_PATH}/vendor/lge/ ${BUILD_ROOT_PATH}/vendor/lge

# Creater prebuilt standard GCC symlink
# Create target path
mkdir -p ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/
# Create symlinks
ln -s ${CUSTOM_ROOT_PATH}/toolchains/UBERTC/${STANDARD_TOOLCHAIN_VERSION}/aarch64/ ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/aarch64
ln -s ${CUSTOM_ROOT_PATH}/toolchains/UBERTC/${STANDARD_TOOLCHAIN_VERSION}/arm/ ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/arm
