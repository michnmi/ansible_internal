# Ansible Role: storage
*`roles/base/storage`*

An ansible role that provisions a system for use as a NAS.

## Purpose


## How To Use

### Variables (Defaults)


### Variables (Required)

### files
 
 - None

## Playbooks

An example playbook can look like this:

```
---
- name: "Setup the NAS hosts"
  hosts: storage_servers
  become: yes
  become_method: sudo
  roles:
    - storage
```
