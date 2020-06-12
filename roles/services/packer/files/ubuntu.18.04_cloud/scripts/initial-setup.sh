#!/bin/bash

set -e -x

while [ ! -f /var/lib/cloud/instance/boot-finished ]
do 
  echo 'Waiting for cloud-init...'
  sleep 1
done

echo 'Disabling unattended upgrades since this image should be immutable'
echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic
cat << END >> /etc/apt/apt.conf.d/51-disable-unattended-upgrades
APT::Periodic::Enable "0";
APT::Periodic::Update-Package-Lists "0";
APT::Periodic::Download-Upgradeable-Packages "0";
APT::Periodic::Unattended-Upgrade "0";
END

echo 'Making sure all apt timers are never started'
systemctl stop apt-daily.timer
systemctl disable apt-daily.timer
systemctl mask apt-daily.timer
systemctl stop apt-daily-upgrade.timer
systemctl disable apt-daily-upgrade.timer
systemctl mask apt-daily-upgrade.timer

echo 'Make sure they are forever disabled when machine-id is removed later on for Nomad'
cat << END >> /lib/systemd/system-preset/10-disable-unattended-upgrades
disable apt-daily.timer
disable apt-daily-upgrade.timer
END

echo 'Who needs swap, after all ???'
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# echo 'Rebooting to clean up swap'
# reboot
