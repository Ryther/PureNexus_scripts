#!/bin/bash
# Repo script

BRANCH="YAOSP-MM-6.0.1_r24"

# Initialize the repo
repo init -u git://github.com/YAOSP/manifest.git -b ${BRANCH}

# Clone custom local_manifest
cd ~/android/YAOSP/.repo/
mkdir local_manifests
cd local_manifests
git clone https://github.com/Ryther/YAOSP_local_manifests .

# Creater prebuilt standard GCC symlink
# Create target path
mkdir -p ~/android/YAOSP/prebuilts/gcc/linux-x86/
# Create symlinks
ln -s ~/android/Ryther/toolchains/UBERTC/aarch64/ ~/android/YAOSP/prebuilts/gcc/linux-x86/aarch64
ln -s ~/android/Ryther/toolchains/UBERTC/arm/ ~/android/YAOSP/prebuilts/gcc/linux-x86/arm
