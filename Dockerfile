FROM ubuntu:18.04

MAINTAINER Urban Observatory "https://github.com/urbanobservatory"

RUN apt-get update && apt-get install -y openssh-server rsync cron
RUN mkdir /var/run/sshd

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["cron", "-f"]