# Ansible Role: vmhost
*`roles/base/vmhost`*

An ansible role that provisions a system for use as a Virtual Machine host.

## Purpose

This is used for the `Hypervisor` hosts that exist in my internal (home) environment. 
There are few things to be taken under consideration here: 
  01) The [`storage pools`](https://libvirt.org/storage.html) in my local environment **alwyays** exist within a [`zfs mirror`](https://docs.oracle.com/cd/E19253-01/819-5461/gamss/index.html) comprised of two external `USB` disks.
  02) That storage pool is setup **outside** of this playbook, *manually* by wiping the disks, encrypting them and then creating the `zpool`. That is why this role will **fail** if no disks are presented or now `zpool` exists in those disks. 

The above considerations make this a rather *narrow* role but for my purpose it is sufficient.  
If a case arises where this is becoming problematic, the `LUKS` and the `zfs` related *tasks* will be moved to different roles. 

This role sets up a host with all the required packages to run `qemu` images and also the auto import of the relevant `zfs` filesystems required to setup the *image* locations. 

## How To Use

### Variables (Defaults)

- `vmhost_storage_path`  
        Default: `"/zpools/vmhost_qcow"`  
        Where the `storage pools` will exist. 
- `vmhost_storage_pools`  
        Default: `["test", "prod", "default"]`  
        How the `storage pools` will be named

### Variables (Required)

- `network_interfaces`  
  A dictionary of all the network interfaces of the host. A [`netplan`](https://netplan.io/reference) template will be built out of them since no `ansible` module seems to exist yet.   
  An example:

```
  - name: "enp0s3"
    dhcp4: "no"
    addresses: [
      "192.168.1.162/24"
    ]
    gateway4: "192.168.1.254"
    nameservers:
      addresses: [
        "8.8.8.8",
        "192.168.1.254"
      ]
  - name: "enp0s8"
    dhcp4: "yes"
```

- `LUKS_devices`  
    An array of disks to be encyrpted. This can either be the `UUID` or some other form of unique identification under `/dev/disk/by-*`

- `vmhost_zpool_name`:  
    The `zpool` that will be `imported` from the disks. 

### files
 - None

## Playbooks

An example playbook can look like this:
```
---
- name: "Setup the VM Hosts"
  hosts: hypervisors
  become: yes
  become_method: sudo
  roles:
    - vmhost
```
