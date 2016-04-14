#!/bin/bash
# Repo sync script

# Update the local_manifests
cd ~/android/PureNexus/.repo/local_manifests/
git pull
cd ~/android/PureNexus/

# Reset to standard toolchain
# Delete old link
unlink ~/android/PureNexus/prebuilts/gcc/linux-x86/aarch64
unlink ~/android/PureNexus/prebuilts/gcc/linux-x86/arm
# Create new link
ln -s ~/android/Ryther/toolchains/UBERTC/aarch64/ ~/android/PureNexus/prebuilts/gcc/linux-x86/aarch64
ln -s ~/android/Ryther/toolchains/UBERTC/arm/ ~/android/PureNexus/prebuilts/gcc/linux-x86/arm

time repo sync -j4 -c -f --force-sync > >(tee ~/android/logs/stdout/PureNexus/stdout_repo_sync_sh.log) 2> >(tee ~/android/logs/stderr/PureNexus/stderr_repo_sync_sh.log >&2)
