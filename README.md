# Wireguard automated install with vagrant and asnible provision


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

