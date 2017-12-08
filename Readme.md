# BPI-M3-PVR-SGX
### Bananapi M3 BSP with PVR SGX Driver
This Project is based on the [Sinovoip BPI M3 bsp](https://github.com/BPI-SINOVOIP/BPI-M3-bsp.git). Since the Sinvoip repo is most of the time broken. I buildt up a repo where everything should work. The intention of this Repo is to build a reliable reverse engineering Platform to reverse ingeneer the PVR-SGX Driver.
## Setup
### ubuntu 14.04 LTS
required packages:
```
sudo apt-get install build-essential libncurses5-dev
sudo apt-get install gcc-arm-linux-gnueabi u-boot-tools device-tree-compiler
```

## Build Project

```
make kernel
```
