# armbian

rust-nightly & nodejs development environment for armbian.


### build for yourself

```bash
docker build -t armbian .
# test
docker run --rm -it -v `pwd`:/workspace armbian:latest
```
