# Ansible Role: splunk_forwarder
*`roles/services/splunk_forwarder`*

An ansible role that installs the [universal forwarder](https://www.splunk.com/en_us/download/universal-forwarder) on a system and configures it.

## Purpose

This role will push the 9.1.3 deb package to the hosts and setup the forwarder. 

## How To Use

### Variables (Defaults)

- None

### Variables (Required)

- `splunkforwarder_username`: The credentials to make changes to the local splunk forwarder
- `splunkforwarder_password`: The credentials to make changes to the local splunk forwarder
- `splunk_forwarder_logs`   : An array of log paths or files to send to splunk
- `splunkforwarder_server`  : The splunk server instance

### files

- None

### templates

- None

## Playbooks

An example playbook could be like this:
```yaml
---
- name: "Setup splunk forwarder"
  hosts: cloud_vms
  become: yes
  become_method: sudo
  roles:
    - splunk_forwarder
```
