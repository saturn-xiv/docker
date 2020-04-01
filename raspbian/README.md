# armbian

rust & nodejs development environment for raspbian.

### build for yourself

```bash
docker pull debian:buster
docker build -t raspbian .
# test
docker run --rm -it -v `pwd`:/workspace raspbian:latest
```
