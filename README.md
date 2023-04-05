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
