### Start docker

- Build by self

```bash
$ docker build -t nano-duo2 .
$ docker run --rm -it -v `pwd`/workspace:/workspace -v `pwd`/output:/home/deploy/build/buildroot-2019.05.1/output nano-duo2:latest
```

- From `https://hub.docker.com`

```bash
$ docker run --rm -it -v `pwd`/workspace:/workspace -v `pwd`/output:/home/deploy/build/buildroot-2019.05.1/output chonglou/nano-duo2:latest
```

### build for yourself toolchain

```bash
> cd ~/build/buildroot-2019.02
> make menuconfig 
> make -j
```

### 

```bash
$ sudo dd if=output/images/sdcard.img of=/dev/sdb bs=1M
```

### Document

- [Buildroot](https://buildroot.org/downloads/manual/manual.html)
- [NanoPi Duo2](http://wiki.friendlyarm.com/wiki/index.php/NanoPi_Duo2)
- [Win32 Disk Imager](https://sourceforge.net/projects/win32diskimager/)
