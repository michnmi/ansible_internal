# Ansible Role: komga
*`roles/services/komga`*

An ansible role that provisions a system that can act as a [komga self hosted solution](https://komga.org/).

## Purpose

This expects that we already have a komga configuration. So it can overwrite it with the existing databases. If not, a simple `is_migration` variable can fix this, like with `emby`.

TODO_LIST:
  - NONE

## How To Use

### Variables (Defaults)

- `service_komga_version`

### Variables (Required)

- `service_komga_config_dir`

### files

- None

### templates

- None

## Playbooks

An example playbook could be like this:

```yaml
---
- name: "Setup komga host"
  hosts: komga
  become: yes
  become_method: sudo
  roles:
    - kavita
  vars:
    - service_komga_config_dir: '/opt/komga/config'
```
