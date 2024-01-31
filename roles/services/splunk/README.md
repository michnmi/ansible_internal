# Ansible Role: splunk
*`roles/services/jenkins`*

An ansible role that provisions a system that can act as a [free splunk enterprise host](https://www.splunk.com/en_us/products/splunk-enterprise.html).

## Purpose

This role will just make sure the mountpoints are in place and the installation package is [downloaded](https://download.splunk.com/products/splunk/releases/9.1.3/linux/splunk-9.1.3-d95b3299fa65-linux-2.6-amd64.deb). It will not be setting up the splunk enterprise server.


TODO_LIST:
  - NONE

## How To Use

### Variables (Defaults)

- None

### Variables (Required)

- None

### files

- None

### templates

- None

## Playbooks

An example playbook could be like this:
```yaml
---
- name: "Setup splunk host"
  hosts: splunk
  become: yes
  become_method: sudo
  roles:
    - splunk
```
