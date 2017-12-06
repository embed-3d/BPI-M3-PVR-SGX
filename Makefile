.PHONY: all clean help
.PHONY: u-boot kernel kernel-config
.PHONY: linux pack

C_COMPILE=arm-linux-gnueabihf-

CURDIR=$(shell pwd)

OUTPUT_DIR=$(CURDIR)/output

T_ARCH=arm
K_DIR=$(CURDIR)/linux-sunxi
K_CONFIG=sun8iw6p1smp_bpi_defconfig
#K_CONFIG=sun8iw6p1smp_defconfig

J=$(shell expr `grep ^processor /proc/cpuinfo  | wc -l`)

all:kernel

clean: kernel-clean


kernel-clean:
	$(MAKE) -C ${K_DIR} ARCH=${T_ARCH} CROSS_COMPILE=${C_COMPILE} distclean
	rm -rf ${OUTPUT_DIR}/uImage
	rm -rf ${OUTPUT_DIR}/usr
	rm -rf ${OUTPUT_DIR}/lib

kernel-config:
	$(MAKE) -C ${K_DIR} ARCH=${T_ARCH} CROSS_COMPILE=${C_COMPILE} ${K_CONFIG}

kernel-menuconfig:
	$(MAKE) -C ${K_DIR} ARCH=${T_ARCH} CROSS_COMPILE=${C_COMPILE} menuconfig

#kernel: kernel-config
kernel:
	$(MAKE) -C ${K_DIR} ARCH=${T_ARCH} CROSS_COMPILE=${C_COMPILE} uImage modules -j$J
	cp ${K_DIR}/arch/arm/boot/uImage ${OUTPUT_DIR}
	$(MAKE) -C ${K_DIR} ARCH=${T_ARCH} CROSS_COMPILE=${C_COMPILE} INSTALL_MOD_PATH=${OUTPUT_DIR} modules_install firmware_install
	$(MAKE) -C ${K_DIR} ARCH=${T_ARCH} CROSS_COMPILE=${C_COMPILE} INSTALL_HDR_PATH=${OUTPUT_DIR} headers_install
