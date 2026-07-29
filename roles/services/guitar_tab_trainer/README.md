# Ansible Role: guitar_tab_trainer
*`roles/services/guitar_tab_trainer`*

An ansible role that runs [guitar-tab-trainer](https://github.com/michnmi/guitar-tab-trainer)
as a Docker container on a host already provisioned by `docker_host`.

## Purpose

Templates a `docker-compose.yml` and runs it via `community.docker.docker_compose_v2`,
pulling `ghcr.io/michnmi/guitar-tab-trainer`, built and pushed by a GitHub Actions
workflow on every push to `main`. The compose project lives in
`services_guitar_tab_trainer_compose_project_dir` on the host, so it can also be
driven by hand with `docker compose` for debugging.

The app is a stateless static-file server (a Go binary) - practice history/settings
are kept client-side in the browser's `localStorage`, so no volumes are mounted and
no host data directory is required.

Since the `ghcr.io/michnmi/guitar-tab-trainer` package is currently private, the
role logs in to `ghcr.io` with a GitHub PAT (`read:packages` scope) before pulling.
Once/if the package is made public, set `services_guitar_tab_trainer_ghcr_login_enabled`
to `false` to skip that step entirely.

After the stack comes up, the role polls `GET /healthz` on the host port and
expects an HTTP 200 with body `ok` before considering the deploy successful. A
container-level `HEALTHCHECK` wasn't used because the image has no
shell/curl/wget to run one with.

TODO_LIST:
  - NONE

## How To Use

### Variables (Defaults)

- `services_guitar_tab_trainer_version` - image tag to deploy (default `latest`)
- `services_guitar_tab_trainer_host_port` - host port mapped to the container's `8080`
- `services_guitar_tab_trainer_ghcr_login_enabled` - whether to `docker login` to
  `ghcr.io` before pulling (default `true`, since the package is currently private)
- `services_guitar_tab_trainer_ghcr_username` - GitHub username to log in with
- `services_guitar_tab_trainer_ghcr_password` - GitHub PAT used to authenticate
  to `ghcr.io` (store this vault-encrypted). Generate a **classic** PAT
  dedicated to this purpose (e.g. named `docker-host-ghcr-pull`) with only the
  `read:packages` scope checked - no `repo` or other scopes, and set an
  expiration so it gets rotated periodically. Fine-grained PATs are tighter in
  theory (scoped to one repo) but GHCR container pulls don't reliably support
  them yet - check the token-creation UI for a "Packages" permission on the
  repo before trusting one. Note that classic `read:packages` grants read
  access to every private package you can see, not just this one.

### Variables (Required)

- `services_guitar_tab_trainer_ghcr_username` and
  `services_guitar_tab_trainer_ghcr_password` - required when
  `services_guitar_tab_trainer_ghcr_login_enabled` is `true` (the default)

### files

- None

### templates

- `opt_guitar_tab_trainer_docker-compose.yml.j2`

## Playbooks

An example playbook could be like this:

```yaml
---
- name: "Setup guitar-tab-trainer host"
  hosts: guitar_tab_trainer
  become: yes
  become_method: sudo
  roles:
    - common
    - node_exporter
    - virtiofs_client
    - docker_host
    - guitar_tab_trainer
    - splunk_forwarder
```
