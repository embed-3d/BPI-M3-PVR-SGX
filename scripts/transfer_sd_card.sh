#!/bin/bash

BASE_PATH=`pwd`
BASE_PATH="${BASE_PATH}/.."
CURRENT_USER=`whoami`
UIMAGE="${BASE_PATH}/output/kernel/uImage"
MODULES="${BASE_PATH}/output/kernel/lib/modules/3.4.39"
SCRIPTBIN="${BASE_PATH}/bpi-m3-bsp/configs/script.bin"
FEX="${BASE_PATH}/bpi-m3-bsp/configs/sys_config.fex"
UENV="${BASE_PATH}/bpi-m3-bsp/configs/uEnv.txt"

T_BOOT_PATH="/media/${CURRENT_USER}/BPI-BOOT/"
T_ROOT_PATH="/media/${CURRENT_USER}/BPI-ROOT/"
T_MODULES="${T_ROOT_PATH}/lib/modules/3.4.39"
T_MODULES_PATH="/media/${CURRENT_USER}/BPI-ROOT/lib/modules/"

if [[ ! -d "${T_BOOT_PATH}" || ! -d "${T_ROOT_PATH}" ]]; then
	echo "Partitons not mounted"
	exit
fi

echo "Start Transfer"

echo "Clean BOOT partition"
rm -rf $T_BOOT_PATH/*

echo "Transfer to BOOT partiton"
cp $UIMAGE $T_BOOT_PATH
cp $SCRIPTBIN $T_BOOT_PATH
cp $FEX $T_BOOT_PATH
cp $UENV $T_BOOT_PATH

echo "Clean Modules"
sudo rm -rf $T_MODULES

echo "Transfer Modules"
sudo cp -r $MODULES $T_MODULES_PATH

echo "End Transfer"
