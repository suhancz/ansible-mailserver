# Work status

Work on `feature/kolab` (draft PR #65). **Deleted in the last commit before the merge** (owner). Before that, finish every open box or move it where the owner says.

Marks (owner, 2026-11-27): `[x]` done and verified; `[ ]` to do; `[ ] in progress:` success not verified (not proven by CI or on a server, or only for an older version). When unsure, in progress. An item closes only on CI or server proof.

Style (owner, 2026-11-27): as few words as possible, same meaning. Keep this file under 30 KB. Read it whole before editing (the connector cuts at about 40 KB), push the whole file, check the size after.

## Goal

Kolab role complete and releasable as 3.0.0: tested backups and restore, no copies of shared rules in the instructions, green CI, owner items below.

## Current state

Head before this commit: 5c491b8. Earlier: 024dc51, 9a92cab (job-name fix, memory file), 95c24ca (`linter.yml` timeouts), 43e8b42 (Cyrus restore variables renamed to `cyrus_imap_backup_path`, `cyrus_imap_data_backup_path`), c973397 (`tests.yml` timeout 10 min), 507056c (list in `vars/backup_services.yml`), 1a3f230, bd51374, 5fa138a, c8187f5 (systemd container backup test), eca7618, a1aedd8 (Kolab versions restored after merge 7effafb of `main` 2.6.3), c57b4b9 (backup fixes), 647bee6, f03549e. Branch not behind `main`.

- CI of 5c491b8 (2026-11-27): 14 checks green, 2 skipped, none failed. Lint 4m38s push, 6m03s PR (limit 20 min). `lint.log` and `test-unit.log` name 5c491b8: success; 9 unit tests; Checkov 0 failed (60, 164, 11 passed); only the two known ignored Ansible findings; Python 3.14. The excerpt is cut off in yamllint warnings. Syntax check 2m20s, systemd test 1m28s. The other four test logs are not read.
- CI of 024dc51: logs read. Systemd test `ok=80 failed=0 skipped=10` with all ten services of the shared list; syntax check passes with `include_vars`.
- Older CI: green since 1a3f230; earlier failures were only NATURAL_LANGUAGE wording (see Super-Linter). 507056c: one `microdnf` hang over 13 min, not seen again.
- Tests (green on 024dc51 by logs, on 5c491b8 by status): users and addresses, whole-role syntax, unit, backup templates, systemd backup test with dummy services. Nothing tests the whole role on a server.
- Backups: ten backup services failed on the server built from `main` (evidence below). This branch fixes the causes and adds the Kolab equivalents; only passed with dummy services. In progress, not working.
- `main`: Dovecot and Horde backup fixes merged as #66 (2.6.3, 2f56b83); DevSkim runner fixed.
- `ai-agent-config`: the terse and truncation rule is merged (PR #15, ffd6f41).
- Owner rules: every commit carries its `TODO.md` update; marks as above.

## High priority: a CI test per change

Owner rule: every change of server behavior gets a CI test in the same commit (also in `AGENTS.md`). Before every commit name the functionality and the test. Gaps go in the commit message and here.

Order (owner, also in `AGENTS.md`): backup and restore tests against the full deployment only when a full deployment is possible, that is when every other item is done. Until then keep the individual tests (templates, derivation, unit, syntax, dummy-service backup) and give each new change its own. Work order: other items first (easiest first, each with a test), then the full deployment (request 2), then backup and restore stages 2 and 3; the area tests also run against it.

- [ ] request 2, blocked until all else is done: test a full deployment in a systemd AlmaLinux 8 container (the `8-init` image, already working in the backup test). Stages: OS and packages, LDAP, MariaDB, Postfix, Kolab, rest. Run the converge twice and fail on any change in run 2. Keep the container for later checks (login, mail delivery, redirects, DNS, TLS). Publish masked logs on `ci-results`
- [ ] request 1, stages 2 and 3, after request 2: stage 2 MariaDB (`mariabackup`, `--prepare`, `--copy-back`, password file), LDAP (instance `mailserver_hostname`, `dsconf backup create`, `dsctl bak2db`), Cyrus mailbox list dump with real Cyrus, restore of a test mailbox; stage 3 every backup service and restore on the full deployment
- [x] request 1, stage 1: dummy-service test (c8187f5, bd51374; `tests/backups_functional.yml`, `tests/backup_restore_one.yml`, job _Backups and restores in a systemd container_): tarball services run twice, archives, retention, restore through the role's restore task file; passed on bd51374 and 024dc51 (`ok=80 failed=0`). Stays until the full deployment exists
- [x] shared tarball service list `vars/backup_services.yml` (`backup_tarball_services`): loaded by `tasks/backups/main.yml` (`include_vars`), read by the test (`vars_files`); the test adds sample files and the vsftpd template service and fails if a service has no sample files; proven on 024dc51 (ten services, `failed=0`; syntax check passes)
- [ ] before every commit: name functionality and covering test; add the test or gap here; update this file in the same commit
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

## CI first

- [x] Red Super-Linter findings fixed at their cause (green on 3dbf835): Pylint `C0415` in `files/misc/ascii_name.py`, shfmt in `files/ldap/extract_user_data_to_migrate.sh` and `tests/mask_log.sh`, codespell (`aci`; typos in `tasks/os/packages.yml:208` and `tasks/mariadb/create_mariadb_schema.yml`), Prettier (one run of the Super-Linter fixer, bot commit 652bb7a, 26 files), Trivy (`.trivyignore`: DS-0001, DS-0002, DS-0026, same as the Checkov skips)
- [x] Tests and lint job read and green: bd51374, 1a3f230 (owner report), 024dc51, and 5c491b8 by job status (14 green, 2 skipped; `lint.log` head and `test-unit.log` read)
- [ ] in progress: read the four other test logs of 5c491b8 (`test-users.log`, `test-role.log`, `test-backups.log`, `test-backups-functional.log`); jobs are green, only `test-unit.log` is read
- [ ] optional: read the Super-Linter result table of a full lint log, to see each linter row
- [ ] after every push: read the logs, keep tests green
- [x] DevSkim never started on `main` (removed `ubuntu-20.04` image); fixed on `main` (#66) and here (`ubuntu-latest`); green on #65

## Kolab backup and restore

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
- [ ] in progress: restore variable naming `<name>_backup_path` (hyphens to underscores): Cyrus ones renamed from `imap_backup_path`, `imap_data_backup_path` (breaking, unreleased; release notes); `tasks/backups/main.yml`, `README.md` updated; other uses not excluded (code search returned nothing); untested until the full deployment sets them
- [ ] after the next deploy: `systemctl --failed | grep backup`, start every backup service, read `journalctl -u <name>-backup.service`; units from `main` stay old until the role runs
- [x] CI test stage 1 (see above)
- [ ] CI test stages 2 and 3, after the full deployment: MariaDB and LDAP backup and restore, Cyrus dump, mailbox restore; backups stay in progress until MariaDB, LDAP and a test mailbox restore passed in CI and on a server
- [ ] confirm the Kolab and Cyrus backups work (original list)
- [ ] in progress: separate PR for the Dovecot and Horde backups and the LDAP template on `main`: #66 merged (2.6.3, 2f56b83); not verified on a server

## Instruction cleanup

- [x] copies of shared rules removed from `AGENTS.md` (2cc2922); `AGENTS.md` rules added: CI test per change, work-status file, lint log fix (9a9ae0f), test order (bd51374), terse and truncation rule (this commit)
- [x] decided: this file is deleted before the merge; `TODO.md` rule in `AGENTS.md` matches
- [x] the four workflows hold no copies of shared rules
- [x] owner rules of 2026-11-27 (commit carries its update; unverified is in progress) are in this file; not in `AGENTS.md` (add if the owner wants)
- [ ] read comments in tasks, templates, scripts for copies of shared rules (not read)
- [ ] remove the copies in the working rules below once the open decisions are settled
- [ ] timestamps in every message and a completion email report (shared rules): not done in this work

## Items from the start

- [ ] fix Roundcube login
- [ ] fix mail sending via Postfix
- [ ] if possible, make `adduser` and the like work on LDAP
- [ ] confirm whether PostfixAdmin is needed
- [ ] sieves, SSL, DKIM, DMARC for Cyrus
- [ ] clean up code; enable VALIDATE_JSCPD in <.github/workflows/linter.yml>

## Canonical module names

- [x] `mysql_db`, `mysql_user`, `mysql_query`, `collections/requirements.yml`, `meta/main.yml` use `ansible.mysql` (`fqcn[canonical]` was real, 20 tasks)
- [ ] `ansible.mysql` 6.0.0 drops MariaDB support for `ansible.mariadb` (`mariadb_db`, `mariadb_user`, `mariadb_query`); plan the move before it arrives
- [ ] check `ansible.posix`, `community.general`, `community.crypto`, `community.dns` for renames or deprecated redirects in the next lint log

## CI test containers

`.github/workflows/tests.yml` (_Tests_): matrix job, four entries in minimal AlmaLinux 8 (users and addresses, whole-role `ansible-playbook --syntax-check` with the latest collections, unit tests of `files/misc/ascii_name.py`, backup template rendering) and job _Backups and restores in a systemd container_ (privileged `8-init`, systemd PID 1, dummy-service test). Logs on `ci-results`: `test-users.log`, `test-role.log`, `test-unit.log`, `test-backups.log`, `test-backups-functional.log`. The converge test (request 2) comes last.

- [x] first three entries and log publishing pass (15c78c6, eacf254, c44c463, 813194b, 11115ea, 3dbf835); fourth entry green on eca7618, 5fa138a, bd51374
- [x] systemd container starts (`systemd state: running`, privileged, host cgroup namespace, `/sys/fs/cgroup` mounted); backup test passed in it (bd51374)
- [ ] in progress: `tests.yml` job timeout 10 min instead of 30 (the 507056c hang lasted over 13 min); slowest job 2 to 3 min; runs of c973397, 024dc51, 5c491b8 stayed inside, but no hang has shown the limit working; gaps: no test covers a timeout, and the `microdnf` step has no retry (the option for metadata retries is unverified)
- [x] `linter.yml` timeouts: 5 min for `check-permissions` and `repair-script-modes`, 20 min for `lint` (normally 2 to 6 min); before 95c24ca only `report-lint` had one (5 min); `release.yml` and `devskim.yml` have none (short); runs of 024dc51 and 5c491b8 stayed inside (permission check at most 9 s; lint 2m24s and 2m38s on 024dc51, 4m38s and 6m03s on 5c491b8); gaps: no timeout test, 20 min is a guess
- [ ] converge test (request 2), only when all else is done: systemd AlmaLinux 8 container running `tasks/os`, `tasks/ldap`, then MariaDB, Postfix, Kolab; shared with later tests
- [ ] check idempotence by converging twice

## Super-Linter log and findings

Owner rule (2026-11-27): when the linter fails, read [lint.log](https://github.com/suhancz/ansible-mailserver/blob/ci-lint-results/lint.log) on `ci-lint-results` and fix the findings at their cause on the same branch, unasked. Check the linted commit in the first lines is the pushed one, look for errors of every linter in the full log (the excerpt holds 300 lines), say when the log is cut before the failure, never hide a finding with an ignore unless the owner decided, reread after every fix. Also in `AGENTS.md` (9a9ae0f).

- [x] the lint job publishes the masked `lint.log` on `ci-lint-results` (seen up to 5c491b8); the branch keeps only the latest log (one commit), so older logs cannot be read
- [x] failures read and fixed: c57b4b9 (CHECKOV, NATURAL_LANGUAGE: `ssl` and `bash` in this file, now code span and `Bash`); 5fa138a (`args[module]` for `modification_format` in `tests/backups_functional.yml` line 163; `file name` in `AGENTS.md`; `lint rule` here; all fixed in bd51374); bd51374 (`linter warning` twice here; fixed in 1a3f230); 95c24ca (the CI job name in plain words, twice in line 18 here; fixed in 9a92cab, memory file records it)
- [x] heads of `lint.log` of 9a92cab and 5c491b8 read: success, linted commit as pushed, Checkov 3.3.19 (3.4.11 available) with 0 failed (60, 164, 11 passed), only the two known ignored Ansible warnings, Python 3.14 (in `memory/MEMORY.md`)
- [ ] resolve the versions of the other linters under `latest` from a lint log (only Checkov 3.3.19 and the Python 3.14 runtime of the Ansible linter are known; not the Ansible linter version)
- [x] Checkov follow-up of c57b4b9: finding did not return (0 failed in 5fa138a, bd51374, 9a92cab, 5c491b8); probable cause a fake password in `tests/backup_templates.yml` (replaced in 647bee6); exact rule and file unknown (log overwritten, connector cannot read run logs); closed as not reproducible
- [ ] in progress: read `lint.log` for the commit of this revision, fix what is red (lint job of 5c491b8 green, head of its log read; this revision's log not read)
- [x] Ansible linter cannot find role `ansible_mailserver` for `tests/role_syntax.yml`; ignored as `syntax-check[specific]` in `.ansible-lint-ignore`
- [x] NATURAL_LANGUAGE wording for Markdown: `Ansible` (not all capitals), `EditorConfig`, `filename`, `filenames`, `hostnames`, `linter rule`, `linting warning`, `Bash`, `codebase` or the lint job; tool and linter names as code spans; quote a rejected term only inside a code span
- [x] line endings pass (e730605); editorconfig-checker passes (eacf254, cb9e339)
- [x] owner decisions: Prettier ran once via the Super-Linter fixer (workflow `prettier-fix-yaml.yml` added in 7d4c2d4, bot commit 652bb7a, deleted in e2471bf); Trivy ignores the three Dockerfile findings like Checkov (`.trivyignore`, 7d4c2d4)
- [ ] change the excerpt at the top of `lint.log`: it stops after 300 lines filled with yamllint warnings (seen again on 5c491b8), cutting off later linters. Put errors and the Super-Linter result table first, cap warnings in a separate section, keep the full masked log; read `linter.yml` first; verify in a CI run. The fetch tool also cuts the file, so a failed check cannot always be traced
- [ ] add indentation and trailing whitespace rules to `.editorconfig` after checking existing files
- [ ] check after the next run: `AIX` in `meta/main.yml` platforms (ignored as `schema[meta]`), `min_ansible_version` 2.9 far too old, other aliases (`user:`, `db:`, `daemon-reload`)
- [ ] yamllint only warns (line length over 80, braces spacing, indentation of `defaults/main.yml` and flow-style items in `tasks/backups/main.yml`); Prettier decides style; decide whether `.yamllint` should follow Prettier

## Never pin tool versions

- [x] workflows (actions at `@main`, Super-Linter `@latest`, `ansible-core` and `Unidecode` unpinned, zizmor `unpinned-uses` off in `.github/linters/zizmor.yml`) and collections in `collections/requirements.yml`; latest `ansible-core` needs Python 3.12, so the test containers install `python3.12` as interpreter (ran with `ansible-core` 2.21.6): the role is not tested with the EL8 platform Python 3.6; the systemd container uses `quay.io/almalinuxorg/8-init:latest`
- [ ] look for other pins in tasks (Git checkout `version:`, package versions); newest collections may break old tasks, read the first full run
- [ ] keep the rule for new workflows, image tags, `pip`, `npm`, collections
- [ ] `main` has `microsoft/DevSkim-Action@v1` (only runner, checkout, upload fixed in #66); this branch uses `@main`; goes away with the merge

## Trivy

- [x] vulnerability scanner off (5fa10ab): database download fails on runners, no dependency manifest; misconfiguration scanner runs
- [ ] switch `vuln` on in `.github/linters/trivy.yaml` once a manifest exists; if its check download still fails, stop running Trivy here (Checkov covers Ansible and workflows)

## Executable files workflow

- [x] `.github/executable-files.txt` lists scripts; `linter.yml` repairs missing modes with a bot commit (first run 78424c1)
- [ ] add every new script (the repair only adds the bit)

## Release 3.0

This branch becomes 3.0.0 (`VERSION`); the merge into `main` publishes it via `.github/workflows/release.yml`. Commits are squashed into one before the merge.

- [x] draft PR #65 exists; release workflow, `RELEASING.md`, `VERSION` taken from `main` (2.6.2), workflow hardened (write permission on the job only, no manual inputs for `CKV_GHA_7`, `actions/github-script@main`)
- [x] `main` merged (5172692; Horde-only changes dropped: `tasks/horde_utf8mb4.yml`, the `tasks/horde.yml` change) and again after 2.6.3 (7effafb) in three steps, as the tools cannot make merge commits: a temporary commit (29c31b2) set files differing on both sides (four backup templates, `tasks/backups.yml`, `VERSION`, DevSkim workflow) to `main`; merge without conflicts; then a1aedd8 and eca7618 restored Kolab versions and deleted `tasks/backups.yml`
- [ ] release workflow not run for 3.0.0 (ran for 2.6.3 on `main`)
- [ ] check nothing from the deleted Horde changes is needed (utf8mb4 for Kolab or Roundcube data)
- [ ] compare the branch with `main` for non-Horde changes that did not arrive (old merge base: AIDE, FQCN, linter fixes)
- [ ] keep up to date with `main` (_Update branch_ needs a conflict-free state: set differing files to `main`, merge, restore Kolab versions, delete Horde files again, as for 5172692 and 7effafb)
- [ ] release notes before the merge: the Horde to Kolab move, new variables in `README.md`; `vars/backup_services.yml` is internal
- [ ] decide on a `2.x` maintenance branch (2.x stays on `main` until the merge)

## Switch from Horde to Kolab in place

Option such as `migrate_from_horde: true`: fetch mail, calendars, contacts, tasks and the rest from Horde, remove Horde (and Dovecot), deploy Kolab, upload the data to the matching user. No remote machine (the owner's `imapsync` start needs a second IMAP server).

- [ ] full `mysqldump` of the `horde` database before removal
- [ ] mail: read Dovecot Maildirs `/var/vmail/<domain>/<user>/Maildir` in place (never deleted), upload by IMAP `APPEND` into the user's Cyrus mailbox (flags from filenames, original dates, folders mapped to the Cyrus separator and special folders such as `Spam`); keep `imapsync` tasks for a remote server
- [ ] calendars, tasks, contacts: export from Horde by CalDAV and CardDAV with each user's password into `/var/backups/horde-migration/<user>/`, `PUT` into the user's Kolab CalDAV and CardDAV (iRony)
- [ ] notes, wiki pages, Ingo filters (sieve): copied to the backup directory, not imported; decide later
- [ ] every step repeatable and safe (skip imported items, never delete the backup, stop before removing Horde if an export failed)
- [ ] unit-test the Maildir and DAV code in CI; the full migration needs a real Horde, so untested until run on a copy of the real server
- [ ] redirect old web URLs: after the switch, old Horde URLs (web interface and sub-applications, old hostnames and paths) redirect to the matching Kolab page (Roundcube, web admin), unknown old paths land on the Kolab login; collect real URLs from the Apache config of the Horde setup (`templates/httpd`, Horde virtual host on `main`) and the access log first
- [ ] redirect old client URLs: CalDAV, CardDAV, push (ActiveSync and similar) and other stored protocol URLs keep working, redirected or served by Kolab equivalents (iRony, Kolab ActiveSync); many DAV clients ignore redirects on `PROPFIND`, so serve in place or add `/.well-known/caldav` and `/.well-known/carddav` redirects; collect exact old paths first
- [ ] CI test for both redirect items: test the generated web config and, after the full deployment, `curl` a list of old Horde URLs (web, CalDAV, CardDAV, push) checking status and `Location` against the expected Kolab URL; the list is test data

## Email address scheme

Goal: users get `givenname.surname@domain`; family domains `givenname@surname-domain`; optional preferred username (for example `sha@suhan.cz`); administrator can add any alias; optional display name. Display name per address: if the local part contains a word of the first name or surname (plain Latin comparison), the official full name in Unicode (`Akos Balla` for `akos@...`), else the nickname (`suhanc` for `sha@...`). Nickname: optional `display_name`, else explicit `name` as written, else official name. User-level `display_name` is the primary address's.

- [x] `mail_domains` (domain, style, optional family surname) and generation of `primary_address`, `generated_aliases`, `all_addresses`, `address_display_names`, `display_name` in `tasks/misc/generate_addresses.yml`; CI-tested with the owner's example; in `README.md`
- [ ] write to LDAP: `mail` = primary, `alias` = all (`tasks/kolab/add_kolab_user.yml`, `tasks/ldap/convert_user_to_ldif.yml`); `displayName` already from `display_name`
- [ ] Roundcube: one identity per address with its display name from `address_display_names` (LDAP holds one display name); check how Kolab Roundcube plugins build identities from the LDAP `alias` attribute
- [ ] Postfix: map every alias to the primary address (`tasks/mail/user_mail_alias.yml`); stop the wildcard `@custom-domain` mapping to the main domain when `mail_domains` is set
- [ ] Kolab recipient policy `primary_mail` per domain style (users created in the web admin) instead of global `family_mode`
- [ ] allow sending from every own address (sender login maps)
- [ ] DNS records, certificates, DKIM, DMARC for all `mail_domains` (`custom_domains` is derived from them)
- [ ] detect addresses belonging to two users (for example the same `givenname@family-domain`)
- [ ] administrator aliases that do not look like names (for example `info@`) get the nickname as display name; decide if wanted

## Leftovers from the username work

- [x] username and address tests passed in CI (5172692, `ansible-core` 2.21.6, Python 3.12)
- [ ] run the whole role on a test machine or in a container: nothing recent (`policy_uid`, `primary_mail`, usernames, addresses) ran against Kolab (the full deployment, request 2, last)
- [ ] built-in Cyrillic and Greek tables are a simple scheme, not ISO 9 or ELOT 743; check your family's names
- [ ] users created in the Kolab web admin follow `policy_uid` and `primary_mail`; Kolab's parser strips accents differently (iconv transliteration, drops non-Latin letters); check both give identical names
- [ ] derived names that become identical (two Annas in family mode, `Kovacs` with and without the accent) are not detected
- [ ] audit WireGuard, FTP, imapsync, backups, DKIM, DMARC for assumptions about `user.name`; compare with `main`
- [ ] consider setting the OS account comment (GECOS) from first name and surname

## Agent instructions

- [x] `AGENTS.md` points to `ai-agent-config` and lists this repository's rules
- [x] decided: squash a branch into one commit before the merge; remove this file before the merge
- [x] `memory/MEMORY.md` holds lessons, tool notes, owner decisions; `AGENTS.md` points to it (9a92cab); owner (2026-11-27): all AI instructions including the memory file stay and go to `main` with the Kolab release; only this file is deleted
- [x] terse and truncation rule recorded here (`AGENTS.md`, memory) and merged in `ai-agent-config` (PR #15)
- [ ] generic memory lessons (terms NATURAL_LANGUAGE rejects) also belong in the shared memory of `ai-agent-config`, only for repositories running Super-Linter defaults (its workflow enables a fixed list without the natural language linter); own branch and PR there

## Order of the owner

Order of the tests (2026-11-27): all other items first, easiest first, each with its own individual test (CI tests, LDAP and Postfix aliases, Roundcube identities, the PostfixAdmin decision, Cyrus items, Horde to Kolab migration with redirects, other open boxes). Then the full deployment in a container (request 2), then backup and restore against it (request 1, stages 2 and 3). Until then keep the individual tests. Update this file in the same commit as every change.

## Open decisions

- consistent backup of Kolab mail data (Cyrus mailboxes and mailbox database): stop and snapshot, or replicate to a Cyrus backup server (a running-server archive is crash-consistent only)
- shared rule pins a Super-Linter image, this repository never pins
- where long-term items go when this file is deleted (migration plan, address scheme, if unfinished): `README.md`, issues, or finish first
- whether the status marks and the "commit carries its `TODO.md` update" rule go into `AGENTS.md` or stay here

## Working rules of the owner

- read the shared instructions of `ai-agent-config` first; `AGENTS.md` points to them
- every server-behavior change gets a CI test in the same commit; every commit carries the update of this file, never a separate commit afterwards
- marks: `[x]` done, `[ ]` to do, `[ ] in progress:` when success is not verified; nothing else
- test order: backup and restore tests against the full deployment only after a full deployment is possible (all other items done); until then individual tests
- tests run in CI containers (AlmaLinux 8), not on the agent's machine; logs on `ci-results` (tests) and `ci-lint-results` (Super-Linter)
- when the linter fails, read `lint.log` and fix the findings at their cause on the same branch
- check CI at the start of every task and fix what is red; ask only when really unclear
- explain in plain language, work independently, keep the non-Horde changes of `main`
- fixes only for what `main` has go to a separate branch and PR against `main`; what is in neither branch goes to the owner as instructions (a Bash one-liner for the server, also in the `main` fix when useful)
- name files after what they do
- write as few words as possible, same meaning; work around truncation (files under 30 KB, read whole, push whole, check size)
- check claims of automatic CI summaries against the real log and documentation (one was wrong that `fetch-depth: 0` was missing and `actions/checkout@v4` should be pinned, and right that `community.mysql` was renamed to `ansible.mysql`)

## Resume prompt

In `suhancz/ansible-mailserver`, work on `feature/kolab` (draft PR #65). Read the shared instructions of `suhancz/ai-agent-config` first, then this file including the marks at the top: an unverified item is `in progress` and closes only on CI or server proof. Read the CI logs of the head commit (`ci-results`, `ci-lint-results`), including `test-backups-functional.log` and `test-backups.log`; close proven in-progress items and keep tests green; when the linter fails, read `lint.log` and fix at the cause. Follow the test order: all other open boxes first, easiest first, each with an individual test (name functionality and test before every commit). Update this file in every commit, in as few words as possible, under 30 KB, read whole and pushed whole. Build the full deployment in a container (request 2) only when all else is done, then backup and restore stages 2 and 3. Wait for CI after every push. Fixes only for `main` go to a separate branch and PR. Do not call backups working until a backup and restore ran in CI. Delete this file in the last commit before the merge.
