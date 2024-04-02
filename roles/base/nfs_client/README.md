# Ansible Role: jenkins
*`roles/base/nfs_client`*

An ansible role that provisions a system to mount NFS shares.

## Purpose

This role will be setting up `NFS` mount points on a server. It will not be setting the users to read those shares here. 

## How To Use

### Variables (Defaults)

- `base_nfs_mount_base_mountpoint`  
   Default value : `mnt`
   The directory under the mount points will exist

- `base_nfs_mounts`  
   Default value : `[]`
   An array of mount points with this structure: 
   
   ```
   - name: 'server1_mount1'
      server: 'vb_nfs_server01'
      share_name: 'data/share1'
      mount_point: 'server01_share1'
      filesystem: 'nfs4'
      opts: 'ro'
   ```

### Variables (Required)

- None

### files

- None

### templates

- None


## Playbooks

```
---
- name: "Setup nfs mounts"
  hosts: nfs_client
  become: yes
  become_method: sudo
  roles:
    - nfs_client
  vars:
    nfs_mounts: 
      - name: 'server1_mount1'
        server: 'vb_nfs_server01'
        share_name: 'data/share1'
        mount_point: 'server01_share1'
        filesystem: 'nfs4'
        opts: 'ro'
```
