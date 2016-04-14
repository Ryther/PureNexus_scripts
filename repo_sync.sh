#!/bin/bash
# Repo script

# Update the local_manifests
cd ~/android/YAOSP/.repo/local_manifests/
git pull
cd ~/android/YAOSP/

# Reset to standard toolchain
# Delete old link
unlink ~/android/YAOSP/prebuilts/gcc/linux-x86/aarch64
unlink ~/android/YAOSP/prebuilts/gcc/linux-x86/arm
# Create new link
ln -s ~/android/Ryther/toolchains/UBERTC/aarch64/ ~/android/YAOSP/prebuilts/gcc/linux-x86/aarch64
ln -s ~/android/Ryther/toolchains/UBERTC/arm/ ~/android/YAOSP/prebuilts/gcc/linux-x86/arm

time repo sync -j4 -c -f --force-sync > >(tee ~/android/logs/stdout/YAOSP/stdout_repo_sync_sh.log) 2> >(tee ~/android/logs/stderr/YAOSP/stderr_repo_sync_sh.log >&2)
