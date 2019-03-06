#!/bin/sh

set -e

if [ $# -ne 1 ] ; then
    echo "Please specify your board(epc_m6g2c, epc_m6g2c_mfg, epc_m6g2c_wifi, dcp_1000l)"
    exit 1
fi

ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf-
export ARCH CROSS_COMPILE

make distclean
make epc_m6g2c_wifi_defconfig
make menuconfig
make all -j

exit 0