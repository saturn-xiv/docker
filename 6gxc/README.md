Form ZLG(EPC_IoT_M6GxC_A6GxC-V1.05.00)
---

## build for yourself toolchain

```bash
$ docker build -t 6g2c .
# test
$ docker run --rm -it -v `pwd`:/workspace 6gxc:latest
> cd ~/local/buildroot-2018.11.3
> make menuconfig
> make uboot-menuconfig
> make busybox-menuconfig
> make linux-menuconfig
```

## Using

### Build u-boot

#### config list

- mx6g2c_nand_128m_defconfig
- mx6g2c_nand_256m_defconfig
- mx6g2c_sd_128m_defconfig
- mx6g2c_sd_256m_defconfig
- a6g2c_nand_128m_defconfig
- a6g2c_nand_256m_defconfig
- a6g2c_sd_128m_defconfig
- a6g2c_sd_256m_defconfig

```bash
> cd ~/build/uboot-imx
> built-uboot-zlg-test.sh mx6g2c_nand_128m_defconfig # can be 
```

-  firmware is `mx6g_built/*_defconfig/u-boot.imx`

### Build kernel 

- edit `built-zImage.sh`(only for A6G2C)

```text
# make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- epc_m6g2c_defconfig &&
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- epc_m6g2c_wifi_defconfig &&
```

```bash
> cd ~/build/A7-linux-src
> ./built-zImage.sh
> tar zcvf kernel.tar.gz arch/arm/boot/zImage
```

- dts file is in `arch/arm/boot/dts`

### Build rootfs

```bash
> cd /opt/rootfs
> sudo tar zcvf rootfs.tar.gz *
```

### Document

- [Buildroot](https://buildroot.org/downloads/manual/manual.html)
- [Linaro](https://www.linaro.org/downloads/)
- [eLinux Toolchains](https://elinux.org/Toolchains)
- [musl.cc](https://musl.cc/)