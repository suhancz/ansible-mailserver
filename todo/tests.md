# Tests: a CI test per change

[Index](../TODO.md)

Owner rule: every change of server behavior gets a CI test in the same commit (also in `AGENTS.md`). Before every commit name the functionality and the test. Gaps go in the commit message and here.

Order (owner, also in `AGENTS.md`): backup and restore tests against the full deployment only when a full deployment is possible, that is when every other item is done. Until then keep the individual tests (templates, derivation, unit, syntax, dummy-service backup) and give each new change its own. Work order: other items first (easiest first, each with a test), then the full deployment (request 2), then backup and restore stages 2 and 3; the area tests also run against it.

- [ ] request 2, blocked until all else is done: test a full deployment in a systemd AlmaLinux 8 container (the `8-init` image, already working in the backup test). Stages: OS and packages, LDAP, MariaDB, Postfix, Kolab, rest. Run the converge twice and fail on any change in run 2. Keep the container for later checks (login, mail delivery, redirects, DNS, TLS). Publish masked logs on `ci-results`
- [ ] request 1, stages 2 and 3, after request 2: stage 2 MariaDB (`mariabackup`, `--prepare`, `--copy-back`, password file), LDAP (instance `mailserver_hostname`, `dsconf backup create`, `dsctl bak2db`), Cyrus mailbox list dump with real Cyrus, restore of a test mailbox; stage 3 every backup service and restore on the full deployment
- [x] request 1, stage 1: dummy-service test (c8187f5, bd51374; `tests/backups_functional.yml`, `tests/backup_restore_one.yml`, job _Backups and restores in a systemd container_): tarball services run twice, archives, retention, restore through the role's restore task file; passed on bd51374 and 024dc51 (`ok=80 failed=0`). Stays until the full deployment exists
- [x] shared tarball service list `vars/backup_services.yml` (`backup_tarball_services`): loaded by `tasks/backups/main.yml` (`include_vars`), read by the test (`vars_files`); the test adds sample files and the vsftpd template service and fails if a service has no sample files; proven on 024dc51 (ten services, `failed=0`; syntax check passes)
- [ ] before every commit: name functionality and covering test; add the test or gap here; update the status files in the same commit
- [ ] gap: the task writing `/etc/mariabackup.cnf`, the `include_vars` task and service loop, the restore `when` guards, the LDAP, MariaDB, Cyrus and Kolab restore tasks and the backup mount run in no test until the full deployment exists (syntax check only parses them)
- [ ] one test per area (individual until the full deployment exists, then also against it); closes when green in CI:
- [ ] test: users, LDAP entries, mail addresses (derivation tested; LDAP write not)
- [ ] test: MariaDB setup and schema (`tasks/mariadb`)
- [ ] test: Postfix, aliases, sender rules (`tasks/mail`)
- [ ] test: Kolab install and login through the Kolab API (`tasks/kolab`)
- [ ] test: Apache virtual hosts and TLS (`tasks/httpd`, `tasks/security/ssl.yml`)
- [ ] test: DKIM and DMARC (`tasks/mail/dkim.yml`, `dmarc.yml`)
- [ ] test: DNS and DynDNS (`tasks/dns`)
- [ ] test: WireGuard (`tasks/wireguard`)
- [ ] test: FTP, fail2ban, firewall, AIDE, antivirus (`tasks/misc`, `tasks/security`)
- [ ] test: backup and restore on running systemd against the full deployment (request 1, stages 2 and 3)
- [ ] test: Horde to Kolab migration on a prepared Horde sample
- [ ] test: redirects of old Horde URLs (web, CalDAV, CardDAV, push, other client URLs) to Kolab
- [x] existing: username and address derivation, whole-role syntax check, unit tests of `files/misc/ascii_name.py` (`tests.yml`)
- [x] backup template test (`tests/backup_templates.yml`, entry _Backup service templates_); green on eca7618, 5fa138a, bd51374
