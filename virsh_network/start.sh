#!/bin/bash

set -eux

NETWORK_NAME="kp_wg_network"

sudo virsh net-define "${NETWORK_NAME}.xml"
sudo virsh net-start $NETWORK_NAME 
sudo virsh net-autostart $NETWORK_NAME 

sudo virsh net-list --all
