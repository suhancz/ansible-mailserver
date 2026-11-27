# Work status

Status file of the work on `feature/kolab` (draft pull request #65). It follows the work-status format of the shared `ai-agent-config` instructions: goal, current state and revision, remaining steps in order, open decisions and a resume prompt. **This file is deleted in the last commit before pull request #65 is merged** (decided by the owner). Every open box is finished first, or moved to a place the owner names, before that commit.

Status marks (owner rule, 2026-11-27): `[x]` is done and verified, `[ ]` is to do, and `[ ] in progress:` marks an item whose success is not verified (written but not proven by CI or on a server, or proven only for an older version). Whenever unsure that an item succeeded, it is in progress. There is no other state. An in-progress item becomes done only when a CI run or a check on the server proves it.

## Goal

Make the Kolab version of the role complete and releasable as 3.0.0: working and tested backups and restore, clean instructions without copies of the shared rules, green CI, and the open items of the owner below.

## Current state

Revision at the last update: the commit that moves the list of the tarball backup services into `vars/backup_services.yml` (shared by the role and the container test) and introduces the in-progress mark, after 1a3f230 (the lint wording fix and the green systemd backup test), bd51374 (the test ordering rules and the two fixes), 5fa138a (this file with the two container test requests), c8187f5 (the first stage of the backup and restore test in a systemd container), eca7618 (`tasks/backups.yml` deleted again) and a1aedd8 (the Kolab versions restored after the merge commit 7effafb of `main`, release 2.6.3). Work is on `feature/kolab` (draft pull request #65). The branch is not behind `main`. Earlier commits: f03549e (terminology fix), 647bee6 (test password), c57b4b9 (the failed backups fixed, the Kolab backup coverage), 9a9ae0f and af56382 (the rule to fix lint failures).

- CI of 1a3f230: the owner reported the lint job green (I did not read that `lint.log` myself); I have not read the test logs of 1a3f230 yet, they were not expected to change because only this file changed
- CI of bd51374 (read from the check runs of pull request #65, from `test-backups-functional.log` and from `lint.log` on 2026-11-27): all tests were green, including the new systemd job: its `PLAY RECAP` shows `ok=79 changed=45 failed=0` (the log of the push run; the check run of the pull request run is green too). The lint job failed only in NATURAL_LANGUAGE, which rejected a term that this file used twice (`linter warning`, use `linting warning`; fixed in 1a3f230). Checkov summaries showed `Failed checks: 0` (60, 164 and 11 passed checks). yamllint only warns, also for `tests/backups_functional.yml` (line length; the `paths: []` warning is gone with this revision)
- tests: the username and address derivation, the syntax check, the script unit tests, the check of the backup templates and the functional backup test with dummy services (stage 1, the ten tarball services run twice, retention, restore through the restore task file of the role, services active again) ran green on bd51374; this revision changes the functional test to read the service list of the role, so it is in progress until the run of this revision is read; nothing tests what the whole role does on a server (see the high-priority section)
- backups: on the server built on `main` ten backup services were failed on 2026-11-27 (see the evidence below); the templates of this branch fix the causes found in the journal and cover the Kolab equivalents of what `main` backed up for Horde and Dovecot; the tarball services passed the container test with dummy services, but the whole role has not run on a server, MariaDB and LDAP are not covered, and the real services (Cyrus, Postfix and so on) are replaced by dummies, so the backups are in progress, not working
- `main`: the Dovecot and Horde side of the same backup fixes was merged as pull request #66 (release 2.6.3, squash commit 2f56b83); `main` also got the DevSkim runner fix (the old `ubuntu-20.04` runner image no longer exists, so the job never started)
- instructions: `AGENTS.md` no longer copies the shared rules (2cc2922), has the CI test rule, the work-status rule for this file, the rule to read the lint log and fix lint failures automatically (9a9ae0f) and the order of the tests (bd51374). Owner rules (2026-11-27), recorded in this file: every commit carries its `TODO.md` update, never a separate commit afterwards; items of unverified success are in progress, the others are done or to do

## Remaining steps

### High priority: a CI test for every changed functionality

Rule of the owner (2026-11-27): every change of what the server does gets a CI test in the same commit, and this is checked every time before a commit is prepared (the rule is in `AGENTS.md`). A gap is never hidden: it is named in the commit message and listed here.

Order of the tests (rule of the owner, 2026-11-27, also in `AGENTS.md`):

- backup and restore tests against the full deployment happen only after a full deployment is possible
- a full deployment is only possible once every other item of this file is done, except the full deployment itself and the backup and restore tests
- until a full deployment is possible, the individual tests stay as they are (templates, name derivation, unit tests, syntax check, and the backup test with dummy services), and every new change gets its own individual test

So the order of the work is: all other items first (lowest hanging fruit first), each with an individual test; then the full deployment (request 2); then the backup and restore tests against it (request 1, stages 2 and 3); the deployment tests per functional area also run against the full deployment once it exists.

Requests of the owner (2026-11-27):

- [ ] request 2, blocked until every other item of this file is done (except request 1): a full deployment of the role is tested in a container, and all tests run against that one deployment (one converge, many checks), instead of each test building its own setup. Plan: build the converge workflow in stages in a systemd-enabled AlmaLinux 8 container (the `Dockerfile` already uses the `8-init` image; the systemd container of the backup test is the first working harness: it started systemd as PID 1 and ran the whole backup test in the run of bd51374): OS and packages, LDAP, MariaDB, Postfix, Kolab, then the rest; run the converge twice and fail on any change in the second run (idempotence); keep the container running (or build it once per workflow run and share it) so that the later tests (login, mail delivery, redirects, DNS, TLS) only check against it; publish the masked logs on `ci-results`
- [ ] request 1, stages 2 and 3, only after request 2 works: backup and restore tests against the full deployment. Stage 2: MariaDB (`mariabackup`, backup and `--prepare` and `--copy-back` restore, with the password file) and LDAP (389 Directory Server instance `mailserver_hostname`, `dsconf backup create` and `dsctl bak2db`), then the Cyrus mailbox list dump with a real Cyrus, and a restore of a test mailbox. Stage 3: run every backup service and restore on the full deployment instead of dummy services
- [ ] in progress: request 1, stage 1, an individual test with dummy services (c8187f5, fixed in bd51374, `tests/backups_functional.yml` and `tests/backup_restore_one.yml`, job _Backups and restores in a systemd container_ in `tests.yml`): the tarball services run twice, the archives, the retention and the restore through the role's restore task file are checked; it passed in the run of bd51374 (`failed=0`) but this revision changed it to read the service list of the role from `vars/backup_services.yml`, so it is done only when the run of this revision passes; it stays as it is until the full deployment exists
- [ ] before every commit: name the functionality the commit changes and the test that covers it; add the test or the gap to this list; include the update of this file in the same commit
- [ ] in progress: the list of tarball services is shared: `vars/backup_services.yml` (variable `backup_tarball_services`) is loaded by `tasks/backups/main.yml` with `include_vars` and read by the container test with `vars_files`; the test only adds sample files per service and the vsftpd service (own template) and fails when a service of the role has no sample files; written in this revision, nothing has run yet: the run has to prove that the relative `vars_files` path works and the syntax check has to prove the role-relative `include_vars`
- [ ] gap of the backup commits: the task that writes `/etc/mariabackup.cnf`, the `include_vars` task and the loop over the service list in `tasks/backups/main.yml`, the `when` guards of the restore block, the restore tasks of LDAP, MariaDB, Cyrus and Kolab configuration and the mount of the backup directory are not executed by any test until the full deployment exists
- [ ] one test per functional area; until the full deployment exists each one is an individual test (a template or script test, or a test in the systemd container with dummy services), afterwards it also runs against the full deployment; each box closes when the test runs green in CI:
- [ ] test: users, LDAP entries and mail addresses of the role (the derivation of names and addresses is tested already; the LDAP write is not)
- [ ] test: MariaDB setup and schema (`tasks/mariadb`)
- [ ] test: Postfix, aliases and sender rules (`tasks/mail`)
- [ ] test: Kolab installation and a login through the Kolab API (`tasks/kolab`)
- [ ] test: Apache virtual hosts and TLS (`tasks/httpd`, `tasks/security/ssl.yml`)
- [ ] test: DKIM and DMARC (`tasks/mail/dkim.yml`, `dmarc.yml`)
- [ ] test: DNS and DynDNS (`tasks/dns`)
- [ ] test: WireGuard (`tasks/wireguard`)
- [ ] test: FTP, fail2ban, firewall, AIDE and antivirus (`tasks/misc`, `tasks/security`)
- [ ] test: backups and restore on a running systemd against the full deployment (request 1, stages 2 and 3)
- [ ] test: the Horde to Kolab migration on a prepared Horde sample
- [ ] test: the redirects of the old Horde URLs (web, CalDAV, CardDAV, push and the other client URLs) to Kolab (see the section about the switch from Horde to Kolab)
- [x] existing: username and address derivation, whole-role syntax check, unit tests of `files/misc/ascii_name.py` (`tests.yml`)
- [x] new: render and check the systemd templates of the backups (`tests/backup_templates.yml`, entry _Backup service templates_ in `tests.yml`); read green in the check runs of eca7618, 5fa138a and bd51374
- [ ] in progress: new: stage 1 of request 1, the functional backup test with dummy services; green in the run of bd51374, changed in this revision

### CI first

- [x] fix the red Super-Linter findings at their cause (the pull request run of 3dbf835 shows the lint job green; an automatic summary had named files the log did not confirm, so it was not followed blindly)
- [x] Pylint `C0415` in `files/misc/ascii_name.py`, shfmt in `files/ldap/extract_user_data_to_migrate.sh` and `tests/mask_log.sh`, codespell `aci`: pushed in 4a64f43, green in the pull request run of 3dbf835
- [x] codespell: the typo in the comment at `tasks/os/packages.yml:208` is fixed in c44c463 (one word changed); this file describes it without the misspelled word; green in the pull request run of 3dbf835
- [x] Prettier: the temporary workflow ran the Prettier fixer of Super-Linter once, and the bot commit 652bb7a formatted exactly the 26 files of the lint log (424 additions, 165 deletions); the lint job of the pull request run of 3dbf835 succeeded with the YAML files included, and the syntax-check test passed after the reformat
- [x] Trivy: `.trivyignore` at the repository root lists DS-0001, DS-0002 and DS-0026 (7d4c2d4, the same three decisions as the Checkov skips); the lint job of 3dbf835 succeeded, so the three findings do not come back
- [x] the tests of bd51374 are read and green (the systemd job got past the `modification_time_format` task and passed)
- [x] the lint job of 1a3f230 is green (reported by the owner; NATURAL_LANGUAGE is fixed)
- [ ] in progress: read the tests and the lint job of the commit of this revision: the systemd job must still pass with the shared service list (watch for a failure of `vars_files` or of the `sample_files` lookup), the syntax check must pass with the new `include_vars` task, and the Ansible linter must accept `vars/backup_services.yml`
- [ ] optional check: read the Super-Linter result table of the next full lint log once, to see each linter row (in the log of bd51374 the table was readable but the fetched excerpt only showed the failing row)
- [x] codespell typo in `tasks/mariadb/create_mariadb_schema.yml` fixed (5cac1f6)
- [x] the three tests passed (15c78c6, eacf254, c44c463, 813194b, 11115ea, 3dbf835)
- [ ] read the logs after every push and keep the tests green
- [x] DevSkim never started on `main`: its workflow asked for the removed `ubuntu-20.04` runner image; fixed on `main` (pull request #66) and already fixed on this branch (`ubuntu-latest`); the DevSkim check of #66 ran green afterwards, and the DevSkim checks of #65 were green in the check runs of eca7618, 5fa138a and bd51374

### Kolab backup and restore

The backups did not work on the old Horde setup (`main`) and have to work on Kolab. Evidence from the server built on `main` (2026-11-27, `systemctl --failed` and the journal): ten backup services were failed (`dovecot`, `horde`, `ldap`, `opendkim`, `opendmarc`, `pdns`, `postfix`, `ssl`, `vsftpd`, `wg_vpn`), `mariadb` was not. The causes found: the directories `/backup/ssl`, `/backup/ldap`, `/backup/vsftpd` (and probably the others) did not exist, so `tar` could not open its archive (`bzip2` is installed, GNU tar is 1.30); the LDAP service used the instance name `mrak.suhan`, but the instance is `slapd-mrak` (`dirsrv@mrak`); the postfix service was killed by the 90 second start timeout of its forking service while archiving `/var/vmail`. Items marked done are proven by a CI test (the templates test or the container test with dummy services); items marked in progress are written but depend on a real server or on a test that has not run yet. The full verification (MariaDB, LDAP, mailbox restore) comes after the full deployment exists (see the order of the tests). The fixes for what only `main` has (the Dovecot and Horde services, `tasks/backups.yml`, its LDAP template with the wrong instance name) are in pull request #66 against `main` (merged, release 2.6.3) and are not part of this branch.

- [x] every backup service creates its own directory (`ExecStartPre=/usr/bin/mkdir -p /backup/<name>`), so a missing directory cannot fail a backup; the container test starts from missing directories and passed in the run of bd51374
- [ ] in progress: the LDAP backup service and the LDAP restore use the instance name `mailserver_hostname` (the role uses it for `slapd-` and `dirsrv@` everywhere else); the dependency names are no longer quoted; the templates test checks the rendered unit, but the real instance name on a Kolab server is not checked
- [x] the services are `Type=oneshot` without `RemainAfterExit`: no start timeout (the postfix archive of `/var/vmail` ran into the 90 second limit), and the daily timer can start them again every day (the container test runs every tarball service twice in a row and passed; the size of the real `/var/vmail` is not tested)
- [x] retention: the old backups are removed after the new backup is written, with `-mindepth 1` and `-exec ... +` (the escaped semicolon made systemd warn about unknown escape sequences); the container test plants an old archive and checks that only it is removed (passed in the run of bd51374)
- [x] the backup timers are wanted by `timers.target` (checked by the templates test)
- [ ] in progress: the MariaDB backup password moved from the readable unit file to `/etc/mariabackup.cnf` (mode `u=rw,go=`, written by a task with `no_log`); the templates test checks the unit, but the task that writes the file does not run in any test and the restore commands (`mariabackup --prepare` and `--copy-back`) need to be shown to need no password. `main` still has the password on the command line of the unit (not changed in #66, to keep that fix small)
- [x] the tarball command uses `--ignore-failed-read`, so a path pattern that matches nothing no longer fails the backup (the container test runs it; the Kolab paths are sample files there)
- [ ] in progress: Kolab equivalent of the Horde backup (`/etc/horde` on `main`): the `kolab` backup holds `/etc/kolab`, `/etc/roundcubemail`, `/etc/iRony` and `/etc/kolab-freebusy`, and it is restored like the Horde one, without stopping a service; the archive and restore work with sample files, but it is not checked on a Kolab server that these four directories are the right ones and complete (for example the Kolab web admin and Syncroton configuration may be missing)
- [ ] in progress: Kolab equivalent of the Dovecot configuration backup (`/etc/dovecot` on `main`): the `cyrus-imap` backup holds `/etc/imapd.conf` and `/etc/cyrus.conf` besides `/etc/imap` and `/etc/cyrus-imap`; the Cyrus service is `cyrus-imapd.service` (the Kolab 16 install log shows that name), set by the `unit` field of the backup definition, also for the restore; the paths are not checked on a Kolab server
- [ ] in progress: Kolab equivalent of the Dovecot mail data backup (`/var/vmail` in the postfix backup on `main`): the `cyrus-imap-data` backup holds `/var/lib/imap` (mailbox list database, sieve scripts, quotas) and `/var/spool/imap` (the messages), after a best-effort dump of the mailbox list (`ctl_mboxlist -d`, a JSON file written to `/var/lib/imap/mailboxes.dump.json` as the `cyrus` user; a failure of the dump does not fail the backup); restore variable `imap_data_backup_path`, the restore stops and starts `cyrus-imapd`; the dump command itself has never run (the dummy service test does not run it)
- [ ] in progress: the data of Kolab in MariaDB (Roundcube, Kolab, Syncroton) is covered by the MariaDB backup, the directory data by the LDAP backup; nothing has run to show that the backups contain the Kolab data
- [ ] the Cyrus data archive is taken from a running server and is therefore only crash-consistent; the best practice from the Cyrus mailing list is to stop Cyrus, take a snapshot of the volume, start it again and archive the snapshot, or to replicate the mailboxes to a Cyrus backup server (`sync_client`, `backupd`); decide which one (open decision), and test a restore of a mailbox before trusting it
- [ ] check the paths on a Kolab server: `/usr/lib/cyrus-imapd/ctl_mboxlist` (the dump is silently skipped when the path is wrong), `/etc/iRony`, `/etc/kolab-freebusy`, and the `cyrus` user
- [ ] the `postfix` backup still archives `/var/vmail` (Dovecot Maildirs); keep it while the Horde to Kolab migration reads them in place, and remove it afterwards
- [ ] in progress: restore: the task for the Cyrus configuration only runs when `imap_backup_path` is defined, and the one for the mailbox data when `imap_data_backup_path` is defined; the `when` guards are not executed by any test (the container test uses the restore task file, not the guards)
- [ ] restore: use one naming scheme for the backup path variables (the Cyrus ones are `imap_backup_path` and `imap_data_backup_path`, the others are `<name>_backup_path`) and document them in `README.md`
- [ ] after the next deploy on a server: run `systemctl --failed | grep backup`, start every backup service by hand and read `journalctl -u <name>-backup.service`; the units installed from `main` still have the old content until the role runs again
- [ ] in progress: CI test, stage 1 of request 1, an individual test with dummy services: the tarball services run twice in a systemd container, restored through the restore task file; passed in the run of bd51374, changed in this revision
- [ ] CI test, stages 2 and 3 of request 1, only after the full deployment exists: MariaDB and LDAP backup and restore, the Cyrus mailbox list dump and a mailbox restore against the full deployment; the backups stay in progress until a restore of MariaDB, LDAP and a test mailbox passed in CI and on a server
- [ ] confirm that the Kolab- and Cyrus-related backups work (this item was in the original list)
- [ ] in progress: separate branch and pull request against `main` for the Dovecot and Horde backups and the LDAP template there: #66 is merged as 2f56b83, release 2.6.3 (the pull request description has the one-liner for the running server); not verified on a server

### Instruction cleanup

- [x] copies of the shared rules removed from `AGENTS.md` (2cc2922)
- [x] decided: this file is deleted before pull request #65 is merged
- [x] `AGENTS.md` rule for a CI test with every change of functionality added
- [x] the `TODO.md` rule in `AGENTS.md` matches this file now (work-status format, update in every commit, delete before the merge)
- [x] `AGENTS.md` rule added (9a9ae0f) to read `lint.log` and fix lint failures automatically; the same rule is in the working rules below
- [x] `AGENTS.md` rule added (bd51374) for the order of the tests; the same rule is in the working rules below
- [x] the owner rules of 2026-11-27 (every commit includes the update of this file; items of unverified success are in progress) are recorded in this file (status marks at the top, working rules below); they are not in `AGENTS.md` yet, add them there if the owner wants every agent to follow them
- [ ] read the workflows and the comments in the tasks and templates for more copies of the shared rules (the first read of `linter.yml` and `tests.yml` failed; `tests.yml` was read since and has none)
- [ ] remove the copies in the working rules below once the open decisions are settled
- [ ] the shared rules ask for timestamps in every message and for a completion report by email; neither is done in this work so far

### Items that were in the file at the start

- [ ] fix Roundcube login
- [ ] fix mail sending via Postfix
- [ ] if possible, configure `adduser` and so to work on LDAP
- [ ] confirm if PostfixAdmin is needed at all
- [ ] set up sieves for Cyrus
- [ ] set up SSL for Cyrus
- [ ] set up DKIM for Cyrus
- [ ] set up DMARC for Cyrus
- [ ] clean up code (and enable VALIDATE_JSCPD in <.github/workflows/linter.yml>)

### Canonical module names

- [x] all `mysql_db`, `mysql_user` and `mysql_query` tasks, `collections/requirements.yml` and `meta/main.yml` use `ansible.mysql`; `fqcn[canonical]` was a real finding (20 tasks), and the earlier statement that this collection does not exist was wrong
- [ ] `ansible.mysql` 6.0.0 will drop MariaDB support and move it to the `ansible.mariadb` collection (`mariadb_db`, `mariadb_user`, `mariadb_query`); this role runs MariaDB, so plan the move before 6.0.0 arrives
- [ ] check the other collections (`ansible.posix`, `community.general`, `community.crypto`, `community.dns`) for renames or deprecated redirects in the next lint log

### All tests in CI containers

The workflow `.github/workflows/tests.yml` (name _Tests_) has two kinds of jobs. The matrix job runs four entries in a minimal AlmaLinux 8 container: the username and address derivation, `ansible-playbook --syntax-check` of the whole role with the latest collections, the unit tests of `files/misc/ascii_name.py`, and the rendering check of the backup service templates. The job _Backups and restores in a systemd container_ (c8187f5) runs a privileged `8-init` container with systemd as PID 1 and the functional backup and restore test with dummy services. The logs are `test-users.log`, `test-role.log`, `test-unit.log`, `test-backups.log` and `test-backups-functional.log` on the `ci-results` branch. The converge test (request 2) comes last, see the order of the tests.

- [x] the first three entries and the log publishing pass (15c78c6, eacf254, c44c463, 813194b, 11115ea, 3dbf835)
- [x] the fourth entry (backup service templates) ran green on the extended version (check runs of eca7618, 5fa138a and bd51374)
- [x] the systemd container starts in CI (`systemd state: running`, privileged, cgroup namespace of the host, mount of `/sys/fs/cgroup`) and the backup test passed in it (run of bd51374)
- [ ] add the converge test (request 2), only when every other item is done: a systemd-enabled AlmaLinux 8 container that runs the OS and LDAP parts of the role (`tasks/os`, `tasks/ldap`), then MariaDB, Postfix and finally the Kolab installation, and shares the running container with the later tests
- [ ] check idempotence by running the converge twice

### Super-Linter log and findings

Rule of the owner (2026-11-27): whenever the linter fails on this repository, read [lint.log](https://github.com/suhancz/ansible-mailserver/blob/ci-lint-results/lint.log) on the `ci-lint-results` branch and fix the findings automatically, at their cause, on the same branch, without waiting to be asked. Check that the linted commit in the first lines is the pushed one, look for errors of every linter in the full log (the excerpt only holds the first 300 matching lines), say so when the readable log is cut off before the failure, do not hide a finding with an ignore entry unless the owner decided that, and read the log again after every fix. The rule is in `AGENTS.md` too (9a9ae0f).

- [x] the lint job saves the log, masks it and publishes `lint.log` on the `ci-lint-results` branch (seen for 2cc2922, 5cac1f6, eacf254, c44c463, 813194b, cb9e339, b446022, 11115ea, 3dbf835, c57b4b9, 5fa138a and bd51374)
- [x] read `lint.log` of c57b4b9: the lint job failed, and only CHECKOV and NATURAL_LANGUAGE show a failure in the readable log; the Ansible linter only reports its two known ignored warnings
- [x] NATURAL_LANGUAGE of c57b4b9: the terms `ssl` (the list of failed backup services) and `bash` (a working rule) in this file; the service names are code spans and the word is `Bash` now
- [x] read `lint.log` of 5fa138a: the lint job failed; findings: the Ansible linter reported `args[module]` for `modification_format` in `tests/backups_functional.yml` (line 163), and NATURAL_LANGUAGE rejected `file name` (`AGENTS.md`, line 14) and `lint rule` (this file, line 11); all three were fixed in bd51374. The two known ignored warnings (`schema[meta]`, `syntax-check[specific]`) are unchanged
- [x] read `lint.log` of bd51374: the lint job failed only in NATURAL_LANGUAGE: it rejected `linter warning` twice in this file (line 64 and line 145, use `linting warning`); fixed in 1a3f230 (the owner reported the lint job of 1a3f230 green); the Ansible linter reported no finding for `tests/backups_functional.yml`, only its two known ignored warnings
- [ ] in progress: CHECKOV of c57b4b9: in the readable part of the logs of 5fa138a and bd51374 the three check summaries show `Failed checks: 0`, so the finding probably did not come back; the earlier cause was probably the fake password value in `tests/backup_templates.yml` (replaced in 647bee6); the summaries are not labeled in the excerpt, so this is not confirmed by a named linter row
- [ ] in progress: read `lint.log` for the commit of this revision and fix what is red under the rule above
- [x] the Ansible linter could not find the role `ansible_mailserver` for `tests/role_syntax.yml`; ignored as `syntax-check[specific]` in `.ansible-lint-ignore`, and it only shows as an ignored warning
- [x] the natural language linter rejected an all-capitals Ansible, `file name` and `file names` in running text of this file; they are `Ansible`, `filename` and `filenames`
- [x] the natural language linter also rejected an all-capitals EditorConfig and `host names` in running text of this file; they are `EditorConfig` and `hostnames` (cb9e339, b446022)
- [x] the natural language linter rejected plain-text linter names that look like product names (Ansible, EditorConfig, Markdown) in the CI bullet of the current state; linter names are code spans in this file (3dbf835)
- [x] the natural language linter rejected `file name` in `AGENTS.md`, `lint rule` and `linter warning` in this file; reworded. Rule of thumb for every Markdown file: write `filename`, `linter rule` and `linting warning`, put names of linters and tools in code spans, and quote a rejected term only inside a code span
- [x] line endings: the check passed and the repair job was skipped on e730605 (the files were LF already)
- [x] editorconfig-checker accepts the files (EditorConfig passed in the logs of eacf254 and cb9e339)
- [x] decided by the owner: Prettier is run once by a temporary workflow that uses the Super-Linter fixer, so the Prettier configuration is the same as in the lint job; the workflow `prettier-fix-yaml.yml` was added in 7d4c2d4, ran once (bot commit 652bb7a) and was deleted in e2471bf
- [x] decided by the owner: Trivy gets the same ignores as Checkov for the three Dockerfile findings (`.trivyignore`, 7d4c2d4)
- [ ] the excerpt at the top of `lint.log` stops after 300 lines and the yamllint warnings fill it, so errors of later linters are cut off; match only errors and failures there, or put the Super-Linter result table first (the lint workflow `linter.yml` has to be read first). The fetch tool also cuts the file before the later linters, so a failed check cannot always be traced to its file
- [ ] add indentation and trailing whitespace rules to `.editorconfig` once the existing files are checked
- [ ] check after the next run: `AIX` in the platforms of `meta/main.yml` (an old warning, ignored as `schema[meta]`), `min_ansible_version` 2.9 is far too old, other aliases in other tasks (`user:`, `db:`, `daemon-reload`)
- [ ] yamllint only warns (line length over 80, spaces inside braces, and the indentation rule on `defaults/main.yml` and on the flow-style items of `tasks/backups/main.yml`, listed in the run of bd51374); Prettier now decides the style, so decide if the `.yamllint` rules should follow Prettier

### Never pin tool versions

- [x] done for the CI workflows (actions at `@main`, Super-Linter `@latest`, `ansible-core` and `Unidecode` without a version range, the `unpinned-uses` rule of zizmor is off in `.github/linters/zizmor.yml`) and for the Ansible collections in `collections/requirements.yml`; the latest `ansible-core` needs Python 3.12 or newer, so the AlmaLinux 8 test containers install `python3.12` and use it as the interpreter of the test hosts (it ran with `ansible-core` 2.21.6), which means the real role is not tested with the EL8 platform Python 3.6; the systemd container uses the image tag `latest` of `quay.io/almalinuxorg/8-init`
- [ ] look for other pins in the tasks (for example `version:` of the Git checkouts, package versions) and decide for each if it is a tool pin; the newest collections may break tasks that were written for the old ones, so read the results of the first full run
- [ ] keep this rule for every new workflow, container image tag of a tool, `pip`, `npm` or Ansible collection requirement
- [ ] `main` still has `microsoft/DevSkim-Action@v1` (its devskim workflow was only fixed for the runner, checkout and upload actions in #66); this branch uses `@main`; the pins on `main` go away with the merge of #65

### Trivy

- [x] the vulnerability scanner was switched off in 5fa10ab, because its database download fails on the runners and the repository has no dependency manifest (only the misconfiguration scanner runs)
- [ ] switch `vuln` back on in `.github/linters/trivy.yaml` once there is a manifest worth scanning; if Trivy still fails on its own check download, stop running Trivy on this repository (Checkov covers Ansible and the workflows)

### Executable files workflow

- [x] `.github/executable-files.txt` lists the scripts, `linter.yml` repairs missing modes with a bot commit and runs again; the first run worked (bot commit 78424c1)
- [ ] add every new script to the manifest (the repair only adds the executable bit and never removes it from files that are not listed)

### Release 3.0

This branch is meant to become version 3.0.0 (`VERSION`); merging it into `main` publishes the release through `.github/workflows/release.yml`. The commits of the branch are squashed into one commit before the pull request is merged.

- [x] draft pull request #65 (`feature/kolab` into `main`) exists
- [x] the release workflow, `RELEASING.md` and `VERSION` were taken over from `main` (2.6.2); the workflow was hardened a little (write permission only on the job, no manual inputs because of Checkov `CKV_GHA_7`, `actions/github-script` at `@main` like every other tool)
- [x] `main` was merged into this branch (5172692); its Horde-only changes are not carried over on purpose: `tasks/horde_utf8mb4.yml` and the change in `tasks/horde.yml` are deleted again after the merge (Horde is replaced by Kolab here)
- [x] `main` was merged into this branch again after release 2.6.3 (merge commit 7effafb), so the branch is not behind `main`; done in three steps because the tools cannot create a merge commit directly: a temporary commit (29c31b2) set the files that differ on both sides (four backup templates, `tasks/backups.yml`, `VERSION`, the DevSkim workflow) to the content of `main`, the merge went through without conflicts, and the next commits (a1aedd8, eca7618) restored the Kolab versions and deleted `tasks/backups.yml` (the Dovecot and Horde backups, not used here)
- [ ] the release workflow has not been run yet for 3.0.0 (it ran for 2.6.3 on `main`: the release exists)
- [ ] check that nothing from the deleted Horde changes is needed (for example the utf8mb4 settings for Kolab or Roundcube data)
- [ ] compare the whole branch with `main` once more for non-Horde changes that did not arrive (the merge base is old, so changes of the 2.x line, for example AIDE, FQCN or linter fixes, may exist on only one side)
- [ ] keep the branch up to date with `main`: merge `main` into the branch with _Update branch_ (that needs a conflict-free state: set the files that differ on both sides to the content of `main` first, merge, then restore the Kolab versions and delete the Horde files again, as done for 5172692 and 7effafb), and discard diffs that are specific to Horde
- [ ] mention the move from Horde to Kolab in the release notes before merging, because old setups need changes (the new variables are in `README.md`; the new `vars/backup_services.yml` is internal)
- [ ] decide if a `2.x` maintenance branch is needed (the 2.x line stays on `main` until the merge)

### In-place switch from Horde to Kolab

New option, for example `migrate_from_horde: true`: fetch mail, calendars, contacts, tasks and whatever else Horde holds, remove the Horde suite (and Dovecot), deploy the Kolab suite, then upload the saved data to the matching user. It has to work without any remote machine (the owner started something with `imapsync`, which needs a second IMAP server).

- [ ] take a full `mysqldump` of the `horde` database as a safety copy before anything is removed
- [ ] mail: read the Dovecot Maildirs in `/var/vmail/<domain>/<user>/Maildir` in place (they are never deleted) and upload them with plain IMAP `APPEND` into the Cyrus mailbox of the user (flags from the Maildir filenames, original dates, folder names mapped to the Cyrus separator and special folders such as `Spam`); keep the existing `imapsync` tasks for the case that a remote server exists
- [ ] calendars, tasks and contacts: export them through the CalDAV and CardDAV interface of Horde with the password of each user into `/var/backups/horde-migration/<user>/`, then `PUT` them into the Kolab CalDAV/CardDAV interface (iRony) of the same user
- [ ] notes, wiki pages and the Ingo mail filters (sieve) are copied into the backup directory but not imported automatically; decide later how to import them
- [ ] make every step repeatable and safe (skip what was imported, never delete the backup, stop before removing Horde if an export failed)
- [ ] unit-test the Maildir and DAV code in CI containers; the full migration cannot be tested without a real Horde installation, so mark it as untested until it ran on a copy of the real server
- [ ] redirect the web URLs after the switch: once the role has converged to Kolab, the old Horde URLs (the Horde web interface and its sub-applications on the old hostnames and paths) redirect to the matching Kolab page (Roundcube, the Kolab web admin), and unknown old paths land on the Kolab login instead of an error; collect the real old URLs from the Apache configuration of the Horde setup (`templates/httpd` and the Horde virtual host on `main`) and the access log first
- [ ] redirect the client URLs after the switch: the CalDAV, CardDAV, push (ActiveSync and similar) and other protocol URLs that clients of the old Horde setup have stored must keep working; the old URLs redirect to, or are served by, the Kolab equivalents (iRony for CalDAV and CardDAV, the ActiveSync endpoint of Kolab, and so on); check per client type what it follows (many DAV clients ignore a redirect on `PROPFIND` and need the URL served in place or a `/.well-known/caldav` and `/.well-known/carddav` redirect), and collect the exact old paths from the Horde setup before writing the rules
- [ ] CI test for both redirect items: a test of the generated web server configuration and, once the full deployment exists, a request of a list of old Horde URLs (web, CalDAV, CardDAV, push) with `curl` against it, checking the status code and the `Location` header against the expected Kolab URL; the list of old URLs is part of the test data

### Email address scheme

Goal: normal users get `givenname.surname@domain`, family domains give `givenname@surname-domain`, a user can have a preferred username (for example `sha@suhan.cz`), the administrator can add any alias, and every user can have an optional display name. The display name is chosen per address: if the local part contains a word of the first name or surname (compared as plain Latin) it is the official full name in Unicode (`Akos Balla` for `akos@...`), otherwise the nickname (`suhanc` for `sha@...`). The nickname is the optional `display_name`, else the explicit `name` as written, else the official name. The user-level `display_name` is the one of the primary address.

- [x] `mail_domains` (domain, style, optional family surname) and the generation of `primary_address`, `generated_aliases`, `all_addresses`, `address_display_names` and `display_name` per user in `tasks/misc/generate_addresses.yml`, tested in CI with the example of the owner, and documented in `README.md`
- [ ] write the new addresses to LDAP: `mail` = primary address, `alias` = all addresses (`tasks/kolab/add_kolab_user.yml`, `tasks/ldap/convert_user_to_ldif.yml`); `displayName` already comes from `display_name`
- [ ] Roundcube: create one identity per address with its display name from `address_display_names` (LDAP has only one display name per user); check how the Kolab Roundcube plugins create identities from the LDAP `alias` attribute
- [ ] Postfix: map every alias to the primary address (`tasks/mail/user_mail_alias.yml`), and stop the wildcard `@custom-domain` mapping to the main domain when `mail_domains` is set
- [ ] Kolab recipient policy `primary_mail` per domain style (for users created in the Kolab web admin), instead of the global `family_mode`
- [ ] allow a user to send from every own address (sender login maps)
- [ ] make sure all `mail_domains` get their DNS records, certificates, DKIM and DMARC (they use `custom_domains`, which is now derived from `mail_domains`)
- [ ] detect addresses that would belong to two users (for example the same `givenname@family-domain`)
- [ ] administrator aliases whose local part does not look like a name (for example `info@`) get the nickname as display name; decide if that is wanted

### Leftovers from the username work

- [x] the username and address tests passed in CI (merge commit 5172692, `ansible-core` 2.21.6 on Python 3.12)
- [ ] run the whole role on a test machine or in a CI container: nothing in the recent commits (`policy_uid`, `primary_mail`, usernames, addresses) has been executed against Kolab yet (this is the full deployment, request 2, which comes last)
- [ ] the built-in Cyrillic and Greek tables are a simple, readable scheme, not an official standard (for example ISO 9 or ELOT 743); check the results for your family's names
- [ ] users created by hand in the Kolab web admin follow `policy_uid`/`primary_mail`, and Kolab's own parser strips accents differently (it uses iconv transliteration and drops non-Latin letters), so check that both give identical names
- [ ] two users whose derived names become identical (for example two people called Anna in family mode, or `Kovacs` with and without the accent) are not detected yet
- [ ] audit the remaining tasks (WireGuard, FTP, imapsync, backups, DKIM, DMARC) for assumptions about `user.name`, and read the `main` branch for comparison
- [ ] consider setting the OS account comment (GECOS) from the first name and surname

### Agent instructions

- [x] `AGENTS.md` sends every agent to the `ai-agent-config` repository and lists the rules of this repository
- [x] decided: squash the commits of a branch into one commit before the pull request is merged
- [x] decided: this file is removed before the pull request is merged

## Order of the owner

Order of the tests (2026-11-27): first every other item of this file, lowest hanging fruit first, each with its own individual test (CI tests for every functionality, LDAP and Postfix aliases from the address scheme, the Roundcube identities, the decision about PostfixAdmin, the Cyrus items, the Horde to Kolab migration including the redirects of the old Horde URLs, and the other open boxes). Only when all of them are done, the full deployment in a container (request 2) and then the backup and restore tests against it (request 1, stages 2 and 3). Until then the individual tests stay as they are. Keep this file up to date, in the same commit as every change.

## Open decisions

- how the Kolab mail data (Cyrus mailboxes and mailbox database) is backed up consistently: stop and snapshot, or replicate to a Cyrus backup server (the data archive of a running server is crash-consistent only)
- the shared rule to lint with a pinned Super-Linter image against the rule here to never pin anything
- where the long-term items go when this file is deleted (for example the Horde to Kolab migration plan and the address scheme work, if they are not finished before the merge): `README.md`, issues, or finish them first
- whether the status marks and the rule that every commit includes its `TODO.md` update go into `AGENTS.md` (so that every agent follows them) or stay only in this file

## Working rules of the owner

- agents read the shared instructions of the `ai-agent-config` repository first; `AGENTS.md` points to them
- every change of server functionality gets a CI test in the same commit; check it before every commit
- every commit includes the update of `TODO.md` (owner rule, 2026-11-27); never push the update as a separate commit afterwards
- status marks (owner rule, 2026-11-27): done `[x]`, to do `[ ]`, and `[ ] in progress:` whenever the success of an item is not verified; no other state
- order of the tests: backup and restore tests against the full deployment only after a full deployment is possible; a full deployment is only possible once every other item of this file is done, except the full deployment and the backup and restore tests; until then keep the individual tests as they are
- all tests run in CI containers (AlmaLinux 8), not on the machine of the assistant; read the logs on the `ci-results` branch (tests) and the `ci-lint-results` branch (Super-Linter)
- whenever the linter fails, read `lint.log` on the `ci-lint-results` branch and fix the findings automatically at their cause on the same branch (see the Super-Linter section)
- check the CI results at the start of every task and fix what is red; ask only when something is really unclear
- explain changes in plain language, work independently, and keep the changes of `main` that are not Horde related
- fixes that only matter for what `main` has (not used on this branch) go to a separate branch and pull request against `main`; what is in neither branch is given to the owner as instructions (a Bash one-liner for the server, also as part of the `main` fix when useful)
- name files after what they do
- check the claims of automatic CI summaries against the real log and the documentation before following or rejecting them (a summary was wrong that `fetch-depth: 0` was missing and that `actions/checkout@v4` should be pinned, and right that `community.mysql` was renamed to `ansible.mysql`)

## Resume prompt

In `suhancz/ansible-mailserver`, work on `feature/kolab` (draft pull request #65). Read the shared instructions of `suhancz/ai-agent-config` first, then this file, including the status marks at the top: an item whose success is not verified is `in progress`, and it only becomes done when a CI run or a check on the server proves it. Read the CI logs for the head commit (`ci-results` and `ci-lint-results`), including `test-backups-functional.log` (the systemd container test with dummy services; it now reads the service list of the role from `vars/backup_services.yml`, so read it for the commit that introduced that) and `test-backups.log`, close the in-progress items that the logs prove, and keep the tests green; whenever the linter fails, read `lint.log` and fix the findings automatically at their cause. Follow the order of the tests: work through all other open boxes first, lowest hanging fruit first, each with its own individual test (before every commit name the functionality it changes and the test that covers it). Include the update of this file in every commit. Build the full deployment in a container (request 2) only when every other item is done, then the backup and restore tests against it (request 1, stages 2 and 3). Wait for the CI runs after every push. Fixes that only concern `main` go to a separate branch and pull request against `main`. Do not mark the backups as working until a backup and a restore ran in the CI test. Delete this file in the last commit before the pull request is merged.
