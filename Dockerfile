FROM ubuntu:18.04

MAINTAINER Urban Observatory "https://github.com/urbanobservatory"

RUN apt-get update && install -y openssh-server rsync cron
RUN mkdir /var/run/sshd

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]