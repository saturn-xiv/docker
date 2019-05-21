Java+Python+NodeJs+OCCI
---

![packages](packages.png)

### Start docker

- Build by self

```bash
$ docker build -t jpno .
$ docker run --rm -it -v `pwd`:/workspace jpno:latest
```

## from hub

```bash
$ docker pull chonglou/jpno:latest
```

## Resources

- [OCCI](https://www.oracle.com/technetwork/database/database-technologies/instant-client/downloads/index.html)
- [cx_Oracle](https://cx-oracle.readthedocs.io/en/latest/installation.html#quick-start-cx-oracle-installation)
- [alembic](https://alembic.sqlalchemy.org/en/latest/tutorial.html)