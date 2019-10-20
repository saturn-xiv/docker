### Start docker

- Build by self

```bash
$ docker build -t friendly-wrt .
$ docker run --rm -it --privileged -v /dev:/dev -v `pwd`:/workspace friendly-wrt:latest
```

- From `https://hub.docker.com`

```bash
$ docker run --rm -it --privileged -v /dev:/dev -v `pwd`:/workspace chonglou/friendly-wrt:latest
```

### build for yourself toolchain

```bash
> cd ~/friendlyarm/manifests
> ./build.sh nanopi_duo2.mk
```

### 

```bash
$ sudo dd if=output/images/sdcard.img of=/dev/sdb bs=1M conv=fsync
```

### Document

- [Buildroot](https://buildroot.org/downloads/manual/manual.html)
- [NanoPi Duo2](http://wiki.friendlyarm.com/wiki/index.php/NanoPi_Duo2)
- [Win32 Disk Imager](https://sourceforge.net/projects/win32diskimager/)
