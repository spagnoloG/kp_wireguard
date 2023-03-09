#!/bin/bash

set -eux

NETWORK_NAME="kp_wg_network"

sudo virsh net-destroy $NETWORK_NAME 
sudo virsh net-undefine $NETWORK_NAME 
