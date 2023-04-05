# Wireguard automated install with vagrant and ansible provision


## Dependencies:
System:

```bash
# apt install python3 python3-pip python3-venv
```

Python:

```bash
python3 -m venv .venv
source ./.venv/bin/activate
pip install -r requirements.txt
```
Ansible:

```bash
ansible-galaxy install -r requirements.yml
```

## Start
```bash
./virsh_network/start.sh
cd vg && vagrant up --provider=libvirt --no-parallel
```

## Destroy the environment
```bash
vagrant destroy
./virsh_network/destroy.sh
```


## Report
```bash
zathura report/report.pdf
```

## Wireshark captures
```bash
wireshark pcap/eth1_traffic.pcap # public interface (encrypted traffic)
wiershark pcap/wg0_traffic.pcap # wireguard interface (decrypted traffic)
wiershark pcap/keep_alive.pcap # public interface (encrypted traffic, keepalive packets)
```

## Good resource about wireguard
- [github](https://github.com/pirate/wireguard-docs)

## Enable IP forwarding on the peer through which other devices on the network will connect to WireGuard peer
```bash
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=1
```

## ENABLE logging for debugging
```bash
modprobe wireguard
echo module wireguard +p > /sys/kernel/debug/dynamic_debug/control
dmesg -wH
```

## Run in docker
```yml
version: '3'

services:
  wireguard:
    image: linuxserver/wireguard
    ports:
      - 51820:51820/udp
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    volumes:
      - /lib/modules:/lib/modules
      - ./wg0.conf:/config/wg0.conf:ro
```
