#!/bin/bash
# Repo sync script

#Consts
STANDARD_TOOLCHAIN_VERSION="4.9"
ROM_NAME="PureNexus"
BUILD_ROOT_PATH="~/android/${ROM_NAME}"
CUSTOM_ROOT_PATH="~/android/Ryther"

# Update the local_manifests
cd ${BUILD_ROOT_PATH}/.repo/local_manifests/
git pull

# Update vendors files
cd ${CUSTOM_ROOT_PATH}/vendor/lge/
git pull

cd ${BUILD_ROOT_PATH}/

# Reset to standard toolchain
# Delete old link
unlink ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/aarch64
unlink ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/arm
# Create new link
if [ -d ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/aarch64 ]
	then
		ln -s ${CUSTOM_ROOT_PATH}/toolchains/UBERTC/${STANDARD_TOOLCHAIN_VERSION}/aarch64/ ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/aarch64
	else
		mkdir -p ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/
		ln -s ${CUSTOM_ROOT_PATH}/toolchains/UBERTC/${STANDARD_TOOLCHAIN_VERSION}/aarch64/ ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/aarch64
fi
if [ -d ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/arm ]
	then
		ln -s ${CUSTOM_ROOT_PATH}/toolchains/UBERTC/${STANDARD_TOOLCHAIN_VERSION}/arm/ ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/arm
	else
		mkdir -p ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/
		ln -s ${CUSTOM_ROOT_PATH}/toolchains/UBERTC/${STANDARD_TOOLCHAIN_VERSION}/arm/ ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/arm
fi

time repo sync -j4 -c -f --force-sync > >(tee ${CUSTOM_ROOT_PATH}/logs/stdout/${ROM_NAME}/stdout_repo_sync_sh.log) 2> >(tee ${CUSTOM_ROOT_PATH}/logs/stderr/${ROM_NAME}/stderr_repo_sync_sh.log >&2)
