# BPI-M3-PVR-SGX
### Bananapi M3 BSP with PVR SGX Driver
This Project is based on the [Sinovoip BPI-M3-bsp](https://github.com/BPI-SINOVOIP/BPI-M3-bsp.git). Since the Sinvoip repo is most of the time broken, I buildt up a repo where everything should work. The intention of this Repo is to build a reliable reverse engineering platform for the PVR-SGX driver.
## Setup
### ubuntu 14.04 LTS
required packages:
```
sudo apt-get install build-essential libncurses5-dev
sudo apt-get install gcc-arm-linux-gnueabi u-boot-tools device-tree-compiler
```

## Configure kernel
```
make kernel-menuconfig
```

## Build kernel
```
make kernel
```
## Transfer Kernel & Modules to SD-Card
### Requirements for the Script
The BOOT partition should be mounted in this direcectory : `/media/${CURRENT_USER}/BPI-BOOT/` and the ROOT Partition should be mounted here: `/media/${CURRENT_USER}/BPI-BOOT/`
### Run Script
```
cd scripts
./transfer_sd_card.sh
```
## Kown Issues
- Hardfloat issue: This processor should be normaly built with gcc-arm-linux-gnueabihf- 
- Needs ubuntu 14.04LTS
## Todo:
- [ ] fix hardfloat issue
- [ ] Provide cross compiler to be able compile it on any linux flavour