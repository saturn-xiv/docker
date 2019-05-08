# armbian

rust-nightly & nodejs development environment for armbian.


### build for yourself

```bash
docker pull ubuntu:bionic
docker build -t armbian .
# test
docker run --rm -it -v `pwd`:/workspace armbian:latest
```
