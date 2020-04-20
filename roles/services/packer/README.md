# Ansible Role: packer
*`roles/services/packer`*

An ansible role that provisions a system that can use [`packer`](https://www.packer.io/).

## Purpose

This role will download and setup `packer` in `/usr/local/bin`, from its release website -> [packer releases](https://releases.hashicorp.com/packer/)

## How To Use

### Variables (Defaults)
- `packer_base_url`  
    Default = `"https://releases.hashicorp.com/packer"`
- `packer_version`  
    Default = `"1.5.5"`
- `packer_arch`  
    Default = `"linux_amd64"`

### Variables (Required)

- None

### files

- None

## Playbooks

- None
