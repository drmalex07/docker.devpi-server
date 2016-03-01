# docker.devpi-server

A dockerized devpi (PyPi) server.
See more on the devpi project at http://doc.devpi.net/latest/index.html

### Run server

Build the image:

    docker build -t local/devpi-server .
    
Run a local instance of a devpi server:

    docker run -d -p 3141:3141 --name devpi-server local/devpi-server

### Create an index for development

Suppose the `devpi-server` is running as a container, and we want to create an index 
(based on root/pypi) for user `tester`. We can use one-off client containers for this task:

```bash
# Create devpi user named `tester`
docker run -it --rm --link devpi-server:devpi-server \
   local/devpi-server bash scripts/create-user.sh tester

# Login and create index tester/devel based on root/pypi
docker run -it --rm --link devpi-server:devpi-server \
   local/devpi-server bash scripts/create-index.sh tester/devel
```

We now must configure our `~/.pypirc` to use our local development index as an upload target:
```ini
[distutils]
index-servers = 
    devel

[devel]
repository: http://localhost:3141/tester/devel/
username: tester
password: tester
```

Upload a package to `devel` PyPi repository:

    python setup.py sdist upload -r devel


