#!/usr/bin/env bash
set -e

cp -R /tmp/.ssh /root/.ssh
chmod 700 /root/.ssh
chmod 600 /root/.ssh/id_rsa
chmod 600 /root/.ssh/config
chmod 644 /root/.ssh/known_hosts
chmod 644 /root/.ssh/id_rsa.pub

cron -f