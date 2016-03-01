# docker.devpi-server

A dockerized devpi (PyPi) server.
See more on the devpi project at http://doc.devpi.net/latest/index.html

### Run server

Build the image:

    docker build -t local/devpi-server .
    
Run a local instance of a devpi server:

    docker run -d -p 3141:3141 --name devpi-server \
       -e PUBLIC_URL=http://devpi.localdomain \
       local/devpi-server

Prefer a plain HTTP endpoint as `PUBLIC_URL`, otherwise devpi clients should be configured to 
trust the HTTPS server's certificate (so the next example wont work).

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

### Download from index

Configure pip to communicate to our local repository (will complain if a non-HTTPS endpoint is given):

     export PIP_INDEX_URL=https://devpi.localdomain/tester/devel
     pip install jinja2


### Upload from index

Configure distutils/setuptools to communicate to our local repository on `setup.py upload`. Edit `~/.pypirc`:
```ini
[distutils]
index-servers = 
    devel

[devel]
repository: http://devpi.localdomain/tester/devel/
username: tester
password: t3ster
```

Upload your package:

    python setup.py sdist upload -r devel
