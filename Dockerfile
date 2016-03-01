# vim: set syntax=dockerfile:

FROM python:2.7

RUN pip install --upgrade pip
RUN pip install devpi-server devpi-web devpi-client

RUN useradd -s /bin/bash -G daemon -m -d /var/lib/devpi devpi
ENV DEVPI_SERVERDIR=/var/lib/devpi/server
RUN mkdir /var/lib/devpi/server && chown devpi:devpi /var/lib/devpi/server 

WORKDIR /var/lib/devpi

ADD scripts scripts 
RUN chown devpi:devpi -R scripts

USER devpi
CMD ["devpi-server", "--host=0.0.0.0", "--port=3141"]

VOLUME /var/lib/devpi
