#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

kernel_v="$(cat include/kernel-version.mk | grep LINUX_KERNEL_HASH-5.4.164* | cut -f 2 -d - | cut -f 1 -d ' ')"
echo "KERNEL=${kernel_v}" >> $GITHUB_ENV || true
sed -i "s?targets/%S/.*'?targets/%S/$kernel_v'?" include/feeds.mk

mv -f ../feeds/ipq807x/ipq807x target/linux/

rm -rf package/feeds/kiddin9/{firewall,rtl*,base-files,netifd,nft-fullcone,mbedtls,oaf,shortcut-fe,simulated-driver,fast-classifier,fullconenat}

rm -rf package/kernel/nat46
rm -rf feeds/packages/net/xtables-addons

make defconfig

rm -rf devices/common/patches/{glinet,imagebuilder.patch,iptables.patch,targets.patch,kernel-defaults.patch,disable_flock.patch}

rm -rf toolchain/musl

svn co https://github.com/openwrt/openwrt/branches/openwrt-22.03/toolchain/musl toolchain/musl

svn co https://github.com/coolsnowwolf/openwrt-gl-ax1800/trunk/package/network/services/fullconenat feeds/kiddin9/fullconenat