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
echo "--------------------------------------------------"
echo "Select the branch of the local_manifest"
echo "--------------------------------------------------"
BRANCH=($(git branch -r | awk 'BEGIN {FS="->"} {print $1}' | cut -f2- -d'/'))
for ((i=0;i<${#BRANCH[@]};i++))
do
    
    echo "$(( $i + 1 )) - ${BRANCH[$i]}"
done
echo "--------------------------------------------------"
BRANCH_SEL=-1
while [[ ($BRANCH_SEL -lt 0) || (${BRANCH_SEL} -gt ${#BRANCH[@]}) ]]
do
    read -n 1 -p "Select a branch: " BRANCH_SEL
    echo ""
done
git checkout ${BRANCH[(( ${BRANCH_SEL} - 1 ))]}

cd ${BUILD_ROOT_PATH}/

# Reset to standard toolchain 1/2
# Delete old link
unlink ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/aarch64
unlink ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/arm

# Unlink removed vendors folders before sync to prevents errors 1/2
unlink ${BUILD_ROOT_PATH}/vendor/lge

# Standard TC prompt
read -p "Do you want to use a modded toolchain? [y/N] " STANDARD_TC

# Reset to standard toolchain 2/2
# Create new link
case $STANDARD_TC in
	"y"|"Y")
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
esac

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

# Unlink removed vendors folders before sync to prevents errors 2/2
if [ ! -d ${BUILD_ROOT_PATH}/vendor/lge ]
then
    ln -s ${CUSTOM_ROOT_PATH}/vendor/lge/ ${BUILD_ROOT_PATH}/vendor/lge
fi

# Update vendors files
echo ""
echo "Updating vendors files..."
cd ${CUSTOM_ROOT_PATH}/vendor/lge/
git pull
