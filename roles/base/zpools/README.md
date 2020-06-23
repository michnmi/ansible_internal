# Ansible Role: zpools
*`roles/base/zpools`*

An ansible role that provisions [zpools](https://wiki.ubuntu.com/ZFS) on the box.

## Purpose
Since no [ansible module](https://docs.ansible.com/ansible/latest/modules/modules_by_category.html) exists that manages `zpools` I would prefer if this role doesn't actually create or delete them. Hence, I'm keeping it simply to _import_ the already existing `zpools`. 

## How To Use

### Variables (Defaults)

- None 

### Variables (Required)

- `zpool_list`  
        Default: Nothing
        The name of the `zpools` to _import_

### files

- None

## Playbooks

Here is an example playbook:

```
- name: "Setup the VM Hosts"
  hosts: hypervisors
  become: yes
  become_method: sudo
  roles:
    - luks_storage
    - zpools
    - vmhost
```