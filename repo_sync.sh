#!/bin/bash
# Repo sync script

# Include project global variables
echo ""
echo "Checking for project global variables..."
if [ -f $(dirname "$0")/variables.var ]
	then
		echo ""
		echo "Including project global variables..."
		source $(dirname "$0")/variables.var
	else
		echo ""
		echo "Executing project global variables init..."
		source $(dirname "$0")/scripts_init.sh
		echo ""
		echo "Including project global variables..."
		source $(dirname "$0")/variables.var
fi

# Update the local_manifests
echo ""
echo "Updating local_manifest..."
cd ${BUILD_ROOT_PATH}/.repo/local_manifests/
git pull

cd ${BUILD_ROOT_PATH}/

# Reset to standard toolchain 1/2
# Delete old link
unlink ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/aarch64
unlink ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/arm

# Unlink removed vendors folders before sync to prevents errors 1/2
unlink ${BUILD_ROOT_PATH}/vendor/lge

echo ""
echo "Starting repo sync..."
if [ ! -d ${CUSTOM_ROOT_PATH}/logs/stdout/${ROM_NAME} ]
	then
		mkdir -p ${CUSTOM_ROOT_PATH}/logs/stdout/${ROM_NAME}/
fi
if [ ! -d ${CUSTOM_ROOT_PATH}/logs/stderr/${ROM_NAME} ]
	then
		mkdir -p ${CUSTOM_ROOT_PATH}/logs/stderr/${ROM_NAME}/
fi

# Syncing
time repo sync -j4 -c -f --force-sync > >(tee ${CUSTOM_ROOT_PATH}/logs/stdout/${ROM_NAME}/stdout_repo_sync_sh.log) 2> >(tee ${CUSTOM_ROOT_PATH}/logs/stderr/${ROM_NAME}/stderr_repo_sync_sh.log >&2)

# Reset to standard toolchain 2/2
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

# Unlink removed vendors folders before sync to prevents errors 2/2
ln -s ${CUSTOM_ROOT_PATH}/vendor/lge/ ${BUILD_ROOT_PATH}/vendor/lge

# Update vendors files
echo ""
echo "Updating vendors files..."
cd ${CUSTOM_ROOT_PATH}/vendor/lge/
git pull
