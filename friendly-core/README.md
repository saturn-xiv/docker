# armbian

rust-nightly & nodejs development environment for armbian.


### build for yourself

```bash
docker pull ubuntu:xenial
docker build -t friendlyarm .
# test
docker run --rm -it -v `pwd`:/workspace friendlyarm:latest
```
