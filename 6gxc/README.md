Form ZLG(EPC_IoT_M6GxC_A6GxC-V1.05.00)
---

![packages](packages.png)

### build for yourself toolchain

```bash
$ docker build -t 6gxc .
# test
$ docker run --rm -it -v `pwd`:/workspace 6gxc:latest
> cd ~/build/buildroot-2018.11.3
> make menuconfig
> make busybox-menuconfig
> make -j
```

will generate `output/images/rootfs.tar.bz2`

### Using official toolchain

```bash
> source $HOME/local/zlg
```

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
> make kernelversion 
> ./built-zImage.sh
> tar zcvf kernel.tar.gz arch/arm/boot/zImage
```

- dts file is in `arch/arm/boot/dts`

### Build rootfs

- rootfs-mx6g2c.tar.gz：for all M6G2C
- rootfs-mx6g2c-wifi.tar.gz for A6G2C-W128LI/A6G2C-W256LI/A6G2C-WB128LI/A6G2C-WB256LI
- rootfs-mx6g2c-5gwifi.tar.gz for A6G2C-5WB128LI
- rootfs-mx6g2c-mifare.tar.gz for A6G2C-M128F128LI
- rootfs-mx6g2c-zigbee.tar.gz for A6G2C-Z128F128LI

```bash
> mkdir rootfs
> sudo tar zxf /opt/zlg/rootfs-mx6g2c-wifi.tar.gz -C rootfs
> sudo mkfs.ubifs -r rootfs -m 2KiB -e 124KiB -c 540 -o rootfs.ubifs.img
> sudo tar zcf rootfs.tar.gz *
```

### Document

- [Buildroot](https://buildroot.org/downloads/manual/manual.html)
- [Linaro](https://www.linaro.org/downloads/)
- [eLinux Toolchains](https://elinux.org/Toolchains)
- [musl.cc](https://musl.cc/)