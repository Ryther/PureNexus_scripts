#!/bin/bash
# Repo sync script

# Update the local_manifests
cd ~/android/PureNexus/.repo/local_manifests/
git pull

# Update vendors files
cd ~/android/Ryther/vendor/lge/
git pull

cd ~/android/PureNexus/

# Reset to standard toolchain
# Delete old link
unlink ~/android/PureNexus/prebuilts/gcc/linux-x86/aarch64
unlink ~/android/PureNexus/prebuilts/gcc/linux-x86/arm
# Create new link
if [ -d ~/android/PureNexus/prebuilts/gcc/linux-x86/aarch64 ]
	then
		ln -s ~/android/Ryther/toolchains/UBERTC/aarch64/ ~/android/PureNexus/prebuilts/gcc/linux-x86/aarch64
	else
		mkdir -p ~/android/PureNexus/prebuilts/gcc/linux-x86/
		ln -s ~/android/Ryther/toolchains/UBERTC/aarch64/ ~/android/PureNexus/prebuilts/gcc/linux-x86/aarch64
fi
if [ -d ~/android/PureNexus/prebuilts/gcc/linux-x86/arm ]
	then
		ln -s ~/android/Ryther/toolchains/UBERTC/arm/ ~/android/PureNexus/prebuilts/gcc/linux-x86/arm
	else
		mkdir -p ~/android/PureNexus/prebuilts/gcc/linux-x86/
		ln -s ~/android/Ryther/toolchains/UBERTC/arm/ ~/android/PureNexus/prebuilts/gcc/linux-x86/arm
fi

time repo sync -j4 -c -f --force-sync > >(tee ~/android/logs/stdout/PureNexus/stdout_repo_sync_sh.log) 2> >(tee ~/android/logs/stderr/PureNexus/stderr_repo_sync_sh.log >&2)
