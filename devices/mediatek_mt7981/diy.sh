#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

kernel_v="$(cat include/kernel-version.mk | grep LINUX_KERNEL_HASH-5.* | cut -f 2 -d - | cut -f 1 -d ' ')"
echo "KERNEL=${kernel_v}" >> $GITHUB_ENV || true
sed -i "s?targets/%S/.*'?targets/%S/$kernel_v'?" include/feeds.mk

rm -rf devices/common/patches/{glinet,imagebuilder.patch,iptables.patch,kernel-defaults.patch,targets.patch}

rm -rf toolchain/glibc

svn co https://github.com/openwrt/openwrt/branches/openwrt-22.03/toolchain/glibc toolchain/glibc
