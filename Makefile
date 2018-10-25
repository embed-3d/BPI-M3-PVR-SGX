.PHONY: all clean help
.PHONY: u-boot kernel kernel-menuconfig kernel-help
.PHONY: linux pack

# ############################################################
# Cross Compiler
# ############################################################

C_COMPILE=arm-linux-gnueabi-

# ############################################################
# Directorys and Files
# ############################################################

CURDIR=$(shell pwd)

K_DIR=$(CURDIR)/linux-sunxi
K_DOT_CONFIG=$(K_DIR)/.config

OUTPUT_DIR=$(CURDIR)/output
K_OUT_DIR=$(OUTPUT_DIR)/kernel

# ############################################################
# Kernel Config
# ############################################################

T_ARCH=arm
K_CONFIG=sun8iw6p1smp_bpi_defconfig

# ############################################################
# Makefile env
# ############################################################

J=$(shell expr `grep ^processor /proc/cpuinfo  | wc -l`)

ifeq ($(J),0)
J=1
endif

# ############################################################
# Makefile toplevel options
# ############################################################

all:kernel

clean: kernel-clean
	rm -rf ${OUTPUT_DIR}

# ############################################################
# Build Kernel
# ############################################################
kernel-clean:
	$(MAKE) -C linux-sunxi/arch/arm/mach-sunxi/pm/standby ARCH=${T_ARCH} CROSS_COMPILE=${C_COMPILE} clean
	$(MAKE) -C ${K_DIR} ARCH=${T_ARCH} CROSS_COMPILE=${C_COMPILE} distclean
	rm -rf ${K_OUT_DIR}

$(K_OUT_DIR) :
	mkdir -p $@

kernel-help:
	$(MAKE) -C ${K_DIR} ARCH=${T_ARCH} CROSS_COMPILE=${C_COMPILE} help

$(K_DOT_CONFIG):
	$(MAKE) -C ${K_DIR} ARCH=${T_ARCH} CROSS_COMPILE=${C_COMPILE} ${K_CONFIG}

kernel-menuconfig: $(K_DOT_CONFIG)
	$(MAKE) -C ${K_DIR} ARCH=${T_ARCH} CROSS_COMPILE=${C_COMPILE} menuconfig
	cp linux-sunxi/.config linux-sunxi/arch/arm/configs/${K_CONFIG}

kernel: $(K_DOT_CONFIG) $(K_OUT_DIR)
	$(MAKE) -C ${K_DIR} ARCH=${T_ARCH} CROSS_COMPILE=${C_COMPILE} uImage modules -j$J
	cp ${K_DIR}/arch/arm/boot/uImage ${K_OUT_DIR}
	$(MAKE) -C ${K_DIR} ARCH=${T_ARCH} CROSS_COMPILE=${C_COMPILE} INSTALL_MOD_PATH=${K_OUT_DIR} modules_install firmware_install
	$(MAKE) -C ${K_DIR} ARCH=${T_ARCH} CROSS_COMPILE=${C_COMPILE} INSTALL_HDR_PATH=${K_OUT_DIR}/usr headers_install

