# Ansible Role: kavita
*`roles/services/kavita`*

An ansible role that provisions a system that can act as a [kavita self hosted solution](https://github.com/Kareadita/Kavita).

## Purpose

This role makes sure we can have one running in a VM while keeping track of the `/config` of the service, so we can keep redeploying without losing the database and everything else. 


TODO_LIST:
  - NONE

## How To Use

### Variables (Defaults)

- `kavita_version`

### Variables (Required)

- `kavita_config_dir`
- `kavita_installation_dir`

### files

- None

### templates

- `etc_systemd_system_kavita.service.j2`: The systemd file for starting _kavita_ as a service.

## Playbooks

An example playbook could be like this:

```yaml
---
- name: "Setup kavita host"
  hosts: kavita
  become: yes
  become_method: sudo
  roles:
    - kavita
  vars:
    - kavita_config_dir: '/opt/kavita/config'
    - kavita_installation_dir: '/opt/kavita'
```
