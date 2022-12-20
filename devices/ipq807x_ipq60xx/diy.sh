#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

kernel_v="$(cat include/kernel-version.mk | grep LINUX_KERNEL_HASH-4.4.* | cut -f 2 -d - | cut -f 1 -d ' ')"
echo "KERNEL=${kernel_v}" >> $GITHUB_ENV || true
sed -i "s?targets/%S/.*'?targets/%S/$kernel_v'?" include/feeds.mk

rm -rf package/feeds/packages/perl

mv -f ../feeds/ipq807x/ipq807x target/linux/ || mv -f ../gl-infra-builder/wlan-ap/feeds/ipq807x/ipq807x target/linux/

rm -rf package/feeds/kiddin9/{firewall,rtl88x2bu,base-files,netifd,nft-fullcone,shortcut-fe,simulated-driver,fast-classifier,fullconenat}

make defconfig

rm -rf devices/common/patches/{glinet,imagebuilder.patch,iptables.patch,targets.patch,kernel-defaults.patch,disable_flock.patch}



