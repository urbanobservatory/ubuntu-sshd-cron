# ubuntu-sshd-cron

Schedule regular tasks that require `ssh` connection for copying files over to the container. Build on top of [official Ubuntu](https://registry.hub.docker.com/_/ubuntu/) image.

**DISCLAIMER: Please note that this is for specific use case and not for stable production use.**

## Installed packages

Base:

- [Bionic (18.04) minimal](http://packages.ubuntu.com/bionic/ubuntu-minimal)

Image specific:

- [openssh-server](https://help.ubuntu.com/community/SSH/OpenSSH/Configuring)
- [rsync](https://help.ubuntu.com/community/rsync)
- [cron](https://help.ubuntu.com/community/CronHowto)

Config:

- default command: `cron -f`

## Example setup

Using Host-Based Authentication:

This expects that you have already setup Host-Based Authentication on your `target` server. Refer to https://en.wikibooks.org/wiki/OpenSSH/Cookbook/Host-based_Authentication for setting up host-based authentication.

- generate private and public key pair for your client
  ```bash
  ssh-keygen -t rsa -C "server comment field"
  ```
- create and populate `known_hosts` file with target host public key
  ```bash
  ssh-keyscan target.example.com | tee -a known_hosts
  ```
- create `config` file for client ssh (refer to [ssh-config](http://man.openbsd.org/ssh_config.5))

  ```bash
  Host target
      HostName target.example.com
      Port 22
      User username
      HostbasedAuthentication yes
      EnableSSHKeysign yes
  ```

- Populate `target` server with client's public key

- start the container and add the ssh files as a volume

  ```bash
  docker run -it --rm \
  -v "/path_to_ssh_settings:/tmp/.ssh:ro" \
  -v "/my_data_drive:/data:rw" \
  -v "/path_to_script:/etc/cron.daily/script \
  urbanobservatory/ubuntu-sshd-cron
  ```

  or

  ```yml
  datacopy:
    image: urbanobservatory/ubuntu-sshd-cron
    restart: unless-stopped
    volumes:
      - ./path_to_ssh_settings:/tmp/.ssh:ro
      - ./my_data_drive:/data:rw
      - ./script.sh:/etc/cron.daily/script
  ```
