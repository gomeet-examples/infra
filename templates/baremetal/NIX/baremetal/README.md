# Gomeet infrastructure on baremetal

## Dependencies

- [http://supervisord.org](http://supervisord.org)

## Files description

- ./README.md this file
- ./etc the content of this directory must be linked in system /etc directory

## Installation

### On Ubuntu Xenial

```shell
sudo apt install supervisor curl
useradd -d /opt/gomeet -m -u 1001 -s /bin/bash gomeet
cd /opt/gomeet

```



