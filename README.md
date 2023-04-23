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
version: "3"
services:
  wireguard:
    image: lscr.io/linuxserver/wireguard:latest
    container_name: wireguard
    cap_add: # Possible container escape so keep that in mind
      - NET_ADMIN
      - SYS_MODULE
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Ljubljana
      - SERVERURL=xx.xx.xx.xx # Server IP
      - SERVERPORT=51820 # Check the firewall 
      - PEERS=1 # This is how many configs will be generated on initial start of container
      - PEERDNS=auto 
      - INTERNAL_SUBNET=10.13.13.0
      - ALLOWEDIPS=0.0.0.0/0 #
      - LOG_CONFS=true
    volumes:
      - ./wg-config:/config
      - /lib/modules:/lib/modules
    ports:
      - 51820:51820/udp
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1 # Enable router mode (share local network)
    restart: unless-stopped
```
