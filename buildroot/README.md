### Start docker

- Build by self

```bash
$ docker build -t buildroot .
$ docker run --rm -it --network host -v `pwd`:/workspace buildroot:latest
```

- From `https://hub.docker.com`

```bash
$ docker pull chonglou/buildroot:latest
$ docker run --rm -it --network host -v `pwd`:/workspace chonglou/buildroot:latest
```

### 

```bash
$ sudo dd if=output/images/sdcard.img of=/dev/sdb bs=1M conv=fsync
```

### Document

- [Buildroot](https://buildroot.org/downloads/manual/manual.html)
- [NanoPi Duo2](http://wiki.friendlyarm.com/wiki/index.php/NanoPi_Duo2)
- [Win32 Disk Imager](https://sourceforge.net/projects/win32diskimager/)
