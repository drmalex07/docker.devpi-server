# docker.devpi-server

A dockerized devpi (PyPi) server.
See more on the devpi project at http://doc.devpi.net/latest/index.html

### Example usage

Build the image:

    docker build -t local/devpi-server .
    
Run a local instance of a devpi server:

    docker run -d -p 3141:3141 --name devpi-server local/devpi-server

