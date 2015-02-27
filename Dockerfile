# Dockerfile for a Raspbian image containing MongoDB.
# Starts an SSH server and mongod instance by default.
# Image tag should read "rgreschner/rpi-raspbian-mongodb".
#
# Licensed under MIT License, for details see 'LICENSE'.

FROM rgreschner/rpi-raspbian-base
MAINTAINER ralph.greschner.dev@gmail.com

# Download MongoDB ARM build.
ADD http://facat.github.io/mongodb-2.6.4-arm.7z /tmp/mongodb.7z

# Install stuff.
RUN apt-get install p7zip -y;cd /tmp; 7zr x /tmp/mongodb.7z;
RUN mv /tmp/mongodb/bin/* /usr/local/bin; rm -rf /usr/local/bin/mongo; rm -rf /tmp/mongodb; mkdir -p /data/db;
RUN rm -rf /run.sh;
ADD run.sh /run.sh

# Add compatible version of mongo client (2.4) from blobs.
ADD blobs/mongo /usr/local/bin/mongo

# Permissions & cleanup.
RUN chmod +x /run.sh; chmod a+x /usr/local/bin/mongo; apt-get remove p7zip -y;

VOLUME ["/data"]
EXPOSE 27017

CMD ["/run.sh"]
