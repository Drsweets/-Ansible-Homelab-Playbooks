# Ansible Homelab Playbooks

Production-ready Ansible automation for Ubuntu node preparation, system hardening, Docker installation, and K3s cluster deployment across mixed physical/virtual nodes.

## Architecture

```
Ansible Control Node (Proxmox VM / Laptop)
         |
         | SSH (port 22)
         ▼
┌─────────────────────────────────────────────┐
│  Physical Node      Virtual Node 1/2        │
│  192.168.1.10       192.168.1.15/16        │
│  (K3s Server)       (K3s Agents)           │
└─────────────────────────────────────────────┘
```

## Quick Start

```bash
# Install Ansible & collections
pip install ansible
ansible-galaxy collection install -r requirements.yml

# Test connectivity
ansible-playbook playbooks/test.yml

# Full deployment
ansible-playbook playbooks/site.yml
```

## Playbooks

| Playbook | Purpose |
|----------|---------|
| `site.yml` | Full homelab setup (common + hardening + docker + k3s) |
| `bootstrap.yml` | First-run node preparation (Python, apt cache) |
| `k3s-cluster.yml` | Deploy/upgrade K3s cluster only |
| `hardening.yml` | Security hardening only (fail2ban, auditd, auto-updates) |
| `test.yml` | Connectivity and fact gathering test |

## Inventory

Edit `inventory/production/hosts.ini` with your node IPs, then run:

```bash
ansible-playbook -i inventory/production/hosts.ini playbooks/site.yml
```

## Roles

- **common** — Packages, NTP, timezone, sysctl, users, SSH keys
- **ssh-hardening** — SSH daemon hardening (port, auth, ciphers)
- **docker** — Docker CE + Buildx + Compose plugin + daemon config
- **k3s-server** — K3s control plane installation + kubeconfig
- **k3s-agent** — K3s worker node joining

## K3s Token

The K3s cluster token is auto-generated once and stored in:
`inventory/production/group_vars/all.yml` (or override via extra vars).

## Skills Demonstrated

- Ansible roles, tasks, handlers, templates, vars
- Idempotent infrastructure automation
- Mixed physical/virtual inventory management
- System hardening (SSH, fail2ban, unattended-upgrades)
- Container runtime provisioning (Docker CE)
- Kubernetes cluster bootstrapping (K3s)
- Jinja2 templating and conditional logic
# -Ansible-Homelab-Playbooks
