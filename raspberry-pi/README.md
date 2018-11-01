## Usage

### build for yourself

```bash
docker build -t raspberry-pi .
# test
docker run --rm -it -v $HOME/workspace:/workspace -v $HOME/.ssh:/root/.ssh raspberry-pi:latest
```
