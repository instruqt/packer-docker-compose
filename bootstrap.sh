#!/bin/bash
set -e

export HOME=/root

IP=$(ip addr show ens4 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
echo $IP > /etc/oldip

ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf

export DEBIAN_FRONTEND=noninteractive

echo "waiting 180 seconds for cloud-init to update /etc/apt/sources.list"
timeout 180 /bin/bash -c \
  'until stat /var/lib/cloud/instance/boot-finished 2>/dev/null; do echo waiting ...; sleep 1; done'

apt-get update
apt-get -y install \
    git curl wget \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    conntrack \
    jq vim nano emacs joe \
    inotify-tools \
    socat make golang-go \
    docker.io \
    bash-completion

apt-get -y remove sshguard

cp -a /tmp/bootstrap/*.sh /usr/bin
cp -a /tmp/bootstrap/*.service /lib/systemd/system/

curl -L https://github.com/docker/compose/releases/download/1.23.3/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

systemctl daemon-reload
systemctl enable docker
systemctl start docker

cp /tmp/bootstrap/compose/* /opt/docker-compose -a

# Read the readme in the data/compose directory and replace the service name
# with the directory name
for i in `find -type d -maxdepth 1 /data/compose`; do
  systemctl enable docker-compose@$i
  systemctl start docker-compose@$i
done
