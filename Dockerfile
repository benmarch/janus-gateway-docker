FROM phusion/baseimage:0.9.15
MAINTAINER Marek Skrajnowski <m.skrajnowski@gmail.com>

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# add build & installation scripts
ADD build /root/build

# add janus configuration
ADD conf /etc/janus

# install janus
RUN /root/build/base.sh         # make gcc etc.
RUN /root/build/usrsctp.sh      # data channel support
RUN /root/build/libwebsock.sh   # websocket support
# RUN /root/build/rabbitmq.sh     # rabbitmq support
RUN /root/build/janus.sh        # janus

# add the janus service
RUN mkdir /etc/service/janus
ADD services/janus.sh /etc/service/janus/run

# expose janus http interface
EXPOSE 8088  # janus http
EXPOSE 8188  # janus websocket
EXPOSE 7088  # janus admin
EXPOSE 5002 5004 # janus streaming input

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
