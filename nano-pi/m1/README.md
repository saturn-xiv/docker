## Usage

### build for yourself

```bash
docker build -t nano-pi-m1 .
# test
docker run --rm -it -v $HOME/workspace:/workspace -v $HOME/.ssh:/root/.ssh nano-pi-m1:latest
```
