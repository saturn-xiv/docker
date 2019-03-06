Form ZLG(EPC_IoT_M6GxC_A6GxC-V1.05.00)
---

![packages](packages.png)

### build for yourself toolchain

```bash
$ docker build -t 6gxc .
$ docker run --rm -it -v `pwd`:/workspace 6gxc:latest
> cd ~/build/buildroot-2018.11.3
> make menuconfig
> make -j
```

will generate `output/images/rootfs.tar.bz2`

### Build kernel 

```bash
> cd ~/build/A7-linux-src
> ./built-zImage.sh CHANGE-ME
> tar zcvf kernel.tar.gz arch/arm/boot/zImage
```

- dts file is in `arch/arm/boot/dts`

### Document

- [Buildroot](https://buildroot.org/downloads/manual/manual.html)
- [Linaro](https://www.linaro.org/downloads/)
- [eLinux Toolchains](https://elinux.org/Toolchains)
- [musl.cc](https://musl.cc/)
