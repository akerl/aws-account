FROM akerl/arch
MAINTAINER akerl
EXPOSE 53
ADD config/nsd.conf /etc/nsd/nsd.conf
ADD config/linode.slaves /etc/nsd/linode.slaves
ADD zones /opt/zones
RUN pacman -S --noconfirm nsd
RUN nsd-control-setup
CMD ["/usr/bin/nsd", "-d", "-c", "/opt/dns/nsd.conf"]
