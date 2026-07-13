# Ansible Role: audiobookshelf
*`roles/services/audiobookshelf`*

An ansible role that runs [Audiobookshelf](https://www.audiobookshelf.org/) as a Docker
container on a host already provisioned by `docker_host`.

## Purpose

Templates a `docker-compose.yml` and runs it via `community.docker.docker_compose_v2`,
mapping config/metadata/audiobooks/podcasts directories from a host-provided data
directory into the container. The compose project lives in
`services_audiobookshelf_compose_project_dir` on the host, so it can also be driven
by hand with `docker compose` for debugging.

TODO_LIST:
  - NONE

## How To Use

### Variables (Defaults)

- `services_audiobookshelf_version`
- `services_audiobookshelf_host_port`
- `services_audiobookshelf_timezone`

### Variables (Required)

- `services_audiobookshelf_data_dir` — host path for config/metadata/podcasts (e.g. `/mnt/audioshelfbook`)
- `services_audiobookshelf_audiobooks_dir` — host path for the audiobooks library, expected
  to be an NFS share already mounted by `nfs_client` (e.g. `/mnt/Audiobooks`)

### files

- None

### templates

- `opt_audiobookshelf_docker-compose.yml.j2`

## Playbooks

An example playbook could be like this:

```yaml
---
- name: "Setup Audiobookshelf host"
  hosts: audiobookshelf
  become: yes
  become_method: sudo
  roles:
    - common
    - node_exporter
    - virtiofs_client
    - nfs_client
    - docker_host
    - audiobookshelf
    - splunk_forwarder
  vars:
    - services_audiobookshelf_data_dir: '/mnt/audioshelfbook'
    - services_audiobookshelf_audiobooks_dir: '/mnt/Audiobooks'
```
