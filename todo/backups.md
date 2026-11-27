# Backups: Kolab backup and restore

[Index](../TODO.md)

Backups failed on the old Horde setup (`main`) and must work on Kolab. Evidence from the server built from `main` (2026-11-27, `systemctl --failed`, journal): ten failed services (`dovecot`, `horde`, `ldap`, `opendkim`, `opendmarc`, `pdns`, `postfix`, `ssl`, `vsftpd`, `wg_vpn`); `mariadb` was fine. Causes: `/backup/ssl`, `/backup/ldap`, `/backup/vsftpd` (probably all) did not exist, so `tar` (GNU 1.30, `bzip2` installed) could not open its archive; the LDAP service used instance `mrak.suhan`, the instance is `slapd-mrak` (`dirsrv@mrak`); the postfix service hit the 90 s start timeout of a forking service archiving `/var/vmail`. Done = proven by CI (templates or dummy-service test); in progress = needs a real server or a test not run yet. Full verification (MariaDB, LDAP, mailbox restore) comes after the full deployment. Fixes for what only `main` has (Dovecot and Horde services, `tasks/backups.yml`, its LDAP template) are in #66, not in this branch.

- [x] each service creates its directory (`ExecStartPre=/usr/bin/mkdir -p /backup/<name>`); test starts without directories; passed on bd51374
- [ ] in progress: LDAP backup and restore use `mailserver_hostname` as instance (as the role does elsewhere), dependency names unquoted; templates test checks the unit, the real instance on Kolab is unchecked
- [x] `Type=oneshot`, no `RemainAfterExit`: no start timeout, daily timer can rerun; test runs every service twice; real `/var/vmail` size untested
- [x] retention after the new backup, `-mindepth 1`, `-exec ... +` (escaped semicolon made systemd warn); test plants an old archive; passed on bd51374
- [x] timers wanted by `timers.target` (templates test)
- [ ] in progress: MariaDB password moved from the unit to `/etc/mariabackup.cnf` (`u=rw,go=`, `no_log` task); unit checked, writing task untested, restore (`--prepare`, `--copy-back`) must be shown to need no password. `main` still has it on the command line (#66 kept small)
- [x] tarball uses `--ignore-failed-read` (unmatched patterns no longer fail); test runs it (Kolab paths are sample files)
- [ ] in progress: Kolab equivalent of the Horde backup: `kolab` backup of `/etc/kolab`, `/etc/roundcubemail`, `/etc/iRony`, `/etc/kolab-freebusy`, restored without stopping a service; works with samples; not checked on Kolab that the four are right and complete (web admin, Syncroton config may be missing)
- [ ] in progress: Kolab equivalent of the Dovecot config backup: `cyrus-imap` backs up `/etc/imapd.conf`, `/etc/cyrus.conf`, `/etc/imap`, `/etc/cyrus-imap`; unit `cyrus-imapd.service` (`unit` field, also for restore); paths unchecked on Kolab
- [ ] in progress: Kolab equivalent of the Dovecot mail backup: `cyrus-imap-data` backs up `/var/lib/imap` and `/var/spool/imap` after a best-effort mailbox list dump (`ctl_mboxlist -d` to `/var/lib/imap/mailboxes.dump.json` as `cyrus`; failure does not fail the backup); restore variable `cyrus_imap_data_backup_path`, stops and starts `cyrus-imapd`; the dump never ran
- [ ] in progress: Kolab data in MariaDB (Roundcube, Kolab, Syncroton) covered by the MariaDB backup, directory data by the LDAP backup; nothing shows the backups hold it
- [ ] Cyrus data archive from a running server is only crash-consistent; best practice: stop Cyrus, snapshot, start, archive the snapshot, or replicate (`sync_client`, `backupd`); decide (open decision), test a mailbox restore first
- [ ] check on a Kolab server: `/usr/lib/cyrus-imapd/ctl_mboxlist` (dump silently skipped if wrong), `/etc/iRony`, `/etc/kolab-freebusy`, user `cyrus`
- [ ] `postfix` backup still archives `/var/vmail` (Dovecot Maildirs); keep while the migration reads them, then remove
- [ ] in progress: restore tasks for Cyrus config and mail data run only when `cyrus_imap_backup_path` or `cyrus_imap_data_backup_path` is defined; the `when` guards run in no test
- [ ] in progress: restore variable naming `<name>_backup_path` (hyphens to underscores): Cyrus ones renamed from `imap_backup_path`, `imap_data_backup_path` (43e8b42; breaking, unreleased; release notes); `tasks/backups/main.yml`, `README.md` updated; other uses not excluded (code search returned nothing); untested until the full deployment sets them
- [ ] after the next deploy: `systemctl --failed | grep backup`, start every backup service, read `journalctl -u <name>-backup.service`; units from `main` stay old until the role runs
- [x] CI test stage 1 (see the tests file)
- [ ] CI test stages 2 and 3, after the full deployment: MariaDB and LDAP backup and restore, Cyrus dump, mailbox restore; backups stay in progress until MariaDB, LDAP and a test mailbox restore passed in CI and on a server
- [ ] confirm the Kolab and Cyrus backups work (original list)
- [ ] in progress: separate PR for the Dovecot and Horde backups and the LDAP template on `main`: #66 merged (2.6.3, 2f56b83); not verified on a server
