#
# Aerospike Server Dockerfile
#
# http://github.com/aerospike/aerospike-server.docker
#

FROM debian:7

ENV AEROSPIKE_VERSION 3.5.9
ENV AEROSPIKE_SHA256 2dacf055d49e62d8be0a2508c11334a52a95982dc8389a7a93d36019d600c32c

# Install Aerospike
RUN apt-get update -y
RUN apt-get install -y wget logrotate ca-certificates python
RUN wget "https://www.aerospike.com/artifacts/aerospike-server-community/${AEROSPIKE_VERSION}/aerospike-server-community-${AEROSPIKE_VERSION}-debian7.tgz" -O aerospike-server.tgz
RUN echo "$AEROSPIKE_SHA256 *aerospike-server.tgz" | sha256sum -c -
RUN mkdir aerospike
RUN tar xzf aerospike-server.tgz --strip-components=1 -C aerospike
RUN dpkg -i aerospike/aerospike-tools-*.deb
RUN apt-get purge -y --auto-remove wget ca-certificates
RUN rm -rf aerospike-server.tgz aerospike /var/lib/apt/lists/*

CMD ["/bin/bash"]
