#!/bin/sh
set -e
echo "Setting up philosophers container"

DEBIAN_FRONTEND=noninteractive NEEDRESTART_SUSPEND=1 apt-get install -y systemd-container
importctl -m pull-tar --verify=checksum https://github.com/NeilW/systemd-dining/releases/download/latest/philosophers.tar.xz
mkdir -p /etc/systemd/nspawn /etc/systemd/network/80-container-ve.network.d
[ ! -e /var/lib/machines/philosophers.nspawn ] || cp /var/lib/machines/philosophers.nspawn /etc/systemd/nspawn/philosophers.nspawn
cat > /etc/systemd/network/80-container-ve.network.d/ipv6prefix.conf <<-END
[IPv6Prefix]
Prefix=fd00:$(hexdump -v -n2 -e' /1 "%02x"' /dev/urandom)::/64
Assign=true
END

if [ -e /swapfile ]
then
    exit 0
fi
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
cat > /etc/systemd/system/swapfile.swap <<-SWAP
[Unit]
Description=Philosophers swapfile

[Swap]
What=/swapfile

[Install]
WantedBy=multi-user.target
SWAP
systemctl enable --now swapfile.swap
