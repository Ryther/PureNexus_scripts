#!/bin/bash
# Repo init script

BRANCH="mm"
STANDARD_TOOLCHAIN_VERSION="4.9"

# Initialize the repo
repo init -u https://github.com/PureNexusProject/manifest.git -b ${BRANCH}

# Clone custom local_manifest
cd ~/android/PureNexus/.repo/
mkdir local_manifests
cd local_manifests
git clone https://github.com/Ryther/PureNexus_local_manifests .

# Creater vendor symlink
# Create target path
mkdir -p ~/android/PureNexus/vendor/
# Create symlinks
ln -s ~/android/Ryther/vendor/lge/ ~/android/PureNexus/vendor/lge

# Creater prebuilt standard GCC symlink
# Create target path
mkdir -p ~/android/PureNexus/prebuilts/gcc/linux-x86/
# Create symlinks
ln -s ~/android/Ryther/toolchains/UBERTC/${STANDARD_TOOLCHAIN_VERSION}/aarch64/ ~/android/PureNexus/prebuilts/gcc/linux-x86/aarch64
ln -s ~/android/Ryther/toolchains/UBERTC/${STANDARD_TOOLCHAIN_VERSION}/arm/ ~/android/PureNexus/prebuilts/gcc/linux-x86/arm
