#!/bin/sh

set -ouex pipefail

systemctl disable zincati.service

systemctl enable ucore-paths-provision.service
systemctl enable rpm-ostreed-automatic.timer

sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf

# workaround to enable cockpit web logins
rm /etc/ssh/sshd_config.d/40-disable-passwords.conf

# workaround until distrobox patch for this makes it into repos
ln -s  ../usr/share/zoneinfo/UTC /etc/localtime

# switch to server profile to allow cockpit by default
cp -a /etc/firewalld/firewalld-server.conf /etc/firewalld/firewalld.conf
