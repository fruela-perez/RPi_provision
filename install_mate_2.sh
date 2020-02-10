#!/bin/bash

# Fix Policy Kit for applications that need elevated privileges

sudo echo "[Configuration]" >> /etc/polkit-1/localauthority.conf.d/60-desktop-policy.conf
sudo echo "AdminIdentities=unix-user:pi;unix-user:0" >> /etc/polkit-1/localauthority.conf.d/60-desktop-policy.conf

sudo reboot