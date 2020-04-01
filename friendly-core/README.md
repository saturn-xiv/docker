# armbian

rust & nodejs development environment for friendly-core.

### build for yourself

```bash
docker pull ubuntu:xenial
docker build -t friendly-core .
# test
docker run --rm -it -v `pwd`:/workspace friendly-core:latest
```

### Documents

- [Friendlyarm](http://wiki.friendlyarm.com/wiki/index.php/Main_Page)
