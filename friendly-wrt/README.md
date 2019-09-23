### Start docker

- Build by self

```bash
$ docker build -t friendly-wrt .
$ docker run --rm -it -v `pwd`/workspace:/workspace -v `pwd`/output:/home/deploy/friendlyarm/manifests/out friendly-wrt:latest
```

- From `https://hub.docker.com`

```bash
$ docker run --rm -it -v `pwd`/workspace:/workspace -v `pwd`/output:/home/deploy/friendlyarm/manifests/out chonglou/friendly-wrt:latest
```

### build for yourself toolchain

```bash
> cd ~/build/buildroot-2019.02
> make menuconfig 
> make -j
```

### 

```bash
$ sudo dd if=output/images/sdcard.img of=/dev/sdb bs=1M conv=fsync
```

### Document

- [Buildroot](https://buildroot.org/downloads/manual/manual.html)
- [NanoPi Duo2](http://wiki.friendlyarm.com/wiki/index.php/NanoPi_Duo2)
- [Win32 Disk Imager](https://sourceforge.net/projects/win32diskimager/)
