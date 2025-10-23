# zrepl Role

 This role installs and configures zrepl for ZFS replication on Ubuntu 22.04.

 ## Requirements

 - Ubuntu 22.04
- ZFS filesystem support
- TLS certificates for secure communication

 ## Role Variables

 Configure jobs and TLS certificates in host_vars for each host.

 ## Example Host Variables

 ```yaml
zrepl_tls_ca: |
  -----BEGIN CERTIFICATE-----
  ...CA certificate content...
  -----END CERTIFICATE-----

 zrepl_tls_cert: |
  -----BEGIN CERTIFICATE-----
  ...Host certificate content...
  -----END CERTIFICATE-----

 zrepl_tls_key: |
  -----BEGIN PRIVATE KEY-----
  ...Private key content...
  -----END PRIVATE KEY-----

 zrepl_jobs:
  - name: "backup_to_remote"
    type: "push"
    connect:
      address: "backup-server:8888"
      server_cn: "backup-server"
    filesystems:
      - path: "tank/data"
        policy: "ok"
    send:
      encrypted: false
    snapshotting:
      prefix: "zrepl_"
      interval: "1h"
    pruning:
      keep_sender:
        - type: "last_n"
          count: 10
      keep_receiver:
        - type: "last_n"
          count: 20
```

