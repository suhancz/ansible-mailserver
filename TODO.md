# Work status

Status file of the work on `feature/kolab` (draft pull request #65). It follows the work-status format of the shared `ai-agent-config` instructions: goal, current state and revision, remaining steps in order, open decisions and a resume prompt. **This file is deleted in the last commit before pull request #65 is merged** (decided by the owner). Every open box is finished first, or moved to a place the owner names, before that commit.

## Goal

Make the Kolab version of the role complete and releasable as 3.0.0: working and tested backups and restore, clean instructions without copies of the shared rules, green CI, and the open items of the owner below.

## Current state

Revision at the last update: 3dbf835 on `feature/kolab` (draft pull request #65, work stays on this branch).

- CI: the pull request run of 3dbf835 is green. The lint job reports success (a full run that includes the YAML files; only yamllint warnings remain) and all tests pass (username and address derivation, whole-role syntax check, unit tests). Earlier, Super-Linter had failed on eacf254 in Pylint, shfmt, codespell, Prettier (26 YAML files) and Trivy (3 Dockerfile findings); the fixes are the Pylint, shfmt and `aci` changes (4a64f43), the bot commit that formatted the 26 YAML files (652bb7a), `.trivyignore` (7d4c2d4), the typo fix in `tasks/os/packages.yml` (c44c463) and the code spans for linter names in this file (3dbf835). The success is the overall result of the job; the per-linter result table was cut off in the fetched log, so no single linter line was read
- tests: only the username and address derivation, the syntax check and the script unit tests exist; nothing tests what the role does on a server (see the high-priority section)
- backups: read, not fixed and not verified; they count as not working until a backup and a restore ran in a test
- instructions: `AGENTS.md` no longer copies the shared rules (2cc2922) and has the CI test rule

## Remaining steps

### High priority: a CI test for every changed functionality

Rule of the owner (2026-11-27): every change of what the server does gets a CI test in the same commit, and this is checked every time before a commit is prepared (the rule is in `AGENTS.md`). A gap is never hidden: it is named in the commit message and listed here.

- [ ] before every commit: name the functionality the commit changes and the test that covers it; add the test or the gap to this list
- [ ] build the converge workflow (a new file `.github/workflows/converge.yml`, or new entries in `tests.yml`): a systemd-enabled AlmaLinux 8 container (the `Dockerfile` already uses the `8-init` image) that runs the role in stages and publishes the masked logs like the existing tests do (`ci-results` branch); stages: OS and packages, LDAP, MariaDB, Postfix, Kolab, then the rest
- [ ] run the converge twice and fail on any change in the second run (idempotence)
- [ ] one test per functional area; each box closes when the test runs green in CI:
- [ ] test: users, LDAP entries and mail addresses of the role (the derivation of names and addresses is tested already; the LDAP write is not)
- [ ] test: MariaDB setup and schema (`tasks/mariadb`)
- [ ] test: Postfix, aliases and sender rules (`tasks/mail`)
- [ ] test: Kolab installation and a login through the Kolab API (`tasks/kolab`)
- [ ] test: Apache virtual hosts and TLS (`tasks/httpd`, `tasks/security/ssl.yml`)
- [ ] test: DKIM and DMARC (`tasks/mail/dkim.yml`, `dmarc.yml`)
- [ ] test: DNS and DynDNS (`tasks/dns`)
- [ ] test: WireGuard (`tasks/wireguard`)
- [ ] test: FTP, fail2ban, firewall, AIDE and antivirus (`tasks/misc`, `tasks/security`)
- [ ] test: backups and restore (see the Kolab backup section; this one comes first because the backups do not work)
- [ ] test: the Horde to Kolab migration on a prepared Horde sample
- [ ] test: the redirects of the old Horde URLs (web, CalDAV, CardDAV, push and the other client URLs) to Kolab (see the section about the switch from Horde to Kolab)
- [x] existing: username and address derivation, whole-role syntax check, unit tests of `files/misc/ascii_name.py` (`tests.yml`)

### CI first

- [x] fix the red Super-Linter findings at their cause (the pull request run of 3dbf835 shows the lint job green; an automatic summary had named files the log did not confirm, so it was not followed blindly)
- [x] Pylint `C0415` in `files/misc/ascii_name.py`, shfmt in `files/ldap/extract_user_data_to_migrate.sh` and `tests/mask_log.sh`, codespell `aci`: pushed in 4a64f43, green in the pull request run of 3dbf835
- [x] codespell: the typo in the comment at `tasks/os/packages.yml:208` is fixed in c44c463 (one word changed); this file describes it without the misspelled word; green in the pull request run of 3dbf835
- [x] Prettier: the temporary workflow ran the Prettier fixer of Super-Linter once, and the bot commit 652bb7a formatted exactly the 26 files of the lint log (424 additions, 165 deletions); the lint job of the pull request run of 3dbf835 succeeded with the YAML files included, and the syntax-check test passed after the reformat
- [x] Trivy: `.trivyignore` at the repository root lists DS-0001, DS-0002 and DS-0026 (7d4c2d4, the same three decisions as the Checkov skips); the lint job of 3dbf835 succeeded, so the three findings do not come back
- [ ] optional check: read the Super-Linter result table of the next full lint log once, to see each linter line (the fetched log was cut off before it)
- [x] codespell typo in `tasks/mariadb/create_mariadb_schema.yml` fixed (5cac1f6)
- [x] the three tests passed (15c78c6, eacf254, c44c463, 813194b, 11115ea, 3dbf835)
- [ ] read the logs after every push and keep the tests green

### Kolab backup and restore

The backups did not work on the old Horde setup (`main`) and have to work on Kolab. A read of `tasks/backups/main.yml` and `templates/systemd/` found the points below; none is fixed or verified yet. The test for them is the first item of the high-priority section.

- [ ] the timer services use `Type=forking` with `RemainAfterExit=yes`: a finished service stays active, and starting an active service does nothing, so the daily timer probably never runs it a second time; use `Type=oneshot` without `RemainAfterExit` and test that two runs in a row both write a backup
- [ ] retention: `find /backup/<name>/ -maxdepth 1 -mtime +7 -exec rm -rf {} \;` also matches the backup directory itself when nothing new was written for seven days; add `-mindepth 1` and never remove the newest backup
- [ ] the backup timers are wanted by `basic.target`; use `timers.target`
- [ ] the MariaDB backup service has the password on the command line of a unit file that every user can read (`mode: u=rw,og=r`); move it to an option file that only root can read
- [ ] the tarball command appends `*` to every path, and a pattern that matches nothing makes `tar` fail (for example when only one of the two Cyrus configuration directories exists); check the paths on a real Kolab installation
- [ ] the Cyrus archive holds the configuration only (`/etc/imap`, `/etc/cyrus-imap`), not the mailboxes and not the mailbox database; the Dovecot maildir archive of Postfix (`/var/vmail`) does not apply to Kolab; decide how to back up the mail data consistently (open decision)
- [ ] the tarball services require `<name>.service`, so `cyrus-imap.service` has to exist; check the real unit name of the Cyrus server on Kolab (probably `cyrus-imapd`) and the names of the other units
- [ ] restore: the task for `cyrus-imap` has no `when` and reads `imap_backup_path`, while the other tarballs use `<name>_backup_path`; guard it, use one naming scheme and document it in `README.md`
- [ ] add a CI test in a systemd-enabled AlmaLinux 8 container: run every backup service twice, restore into a fresh container, and compare a test mailbox, the MariaDB data and the LDAP data; the backups stay marked as not verified until that test passed
- [ ] confirm that the Kolab- and Cyrus-related backups work (this item was in the original list)

### Instruction cleanup

- [x] copies of the shared rules removed from `AGENTS.md` (2cc2922)
- [x] decided: this file is deleted before pull request #65 is merged
- [x] `AGENTS.md` rule for a CI test with every change of functionality added
- [ ] update the `TODO.md` rule in `AGENTS.md` to match: keep this file in the work-status format while the work is open, update it in every commit, delete it in the last commit before the merge
- [ ] read the workflows and the comments in the tasks and templates for more copies of the shared rules (the first read of `linter.yml` and `tests.yml` failed)
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

The workflow `.github/workflows/tests.yml` (name _Tests_) runs three entries in an AlmaLinux 8 container: the username and address derivation, `ansible-playbook --syntax-check` of the whole role with the latest collections, and the unit tests of `files/misc/ascii_name.py`. The logs are `test-users.log`, `test-role.log` and `test-unit.log` on the `ci-results` branch. The converge test is the first item of the high-priority section.

- [x] all three entries and the log publishing pass (15c78c6, eacf254, c44c463, 813194b, 11115ea, 3dbf835)
- [ ] add a converge test: a systemd-enabled AlmaLinux 8 container that runs the OS and LDAP parts of the role (`tasks/os`, `tasks/ldap`), then Postfix and finally the Kolab installation
- [ ] check idempotence by running the converge twice

### Super-Linter log and findings

- [x] the lint job saves the log, masks it and publishes `lint.log` on the `ci-lint-results` branch (seen for 2cc2922, 5cac1f6, eacf254, c44c463, 813194b, cb9e339, b446022, 11115ea and 3dbf835)
- [x] the Ansible linter could not find the role `ansible_mailserver` for `tests/role_syntax.yml`; ignored as `syntax-check[specific]` in `.ansible-lint-ignore`, and it only shows as an ignored warning
- [x] the natural language linter rejected an all-capitals Ansible, `file name` and `file names` in running text of this file; they are `Ansible`, `filename` and `filenames`
- [x] the natural language linter also rejected an all-capitals EditorConfig and `host names` in running text of this file; they are `EditorConfig` and `hostnames` (cb9e339, b446022)
- [x] the natural language linter rejected plain-text linter names that look like product names (Ansible, EditorConfig, Markdown) in the CI bullet of the current state; linter names are code spans in this file (3dbf835)
- [x] line endings: the check passed and the repair job was skipped on e730605 (the files were LF already)
- [x] editorconfig-checker accepts the files (EditorConfig passed in the logs of eacf254 and cb9e339)
- [x] decided by the owner: Prettier is run once by a temporary workflow that uses the Super-Linter fixer, so the Prettier configuration is the same as in the lint job; the workflow `prettier-fix-yaml.yml` was added in 7d4c2d4, ran once (bot commit 652bb7a) and was deleted in e2471bf
- [x] decided by the owner: Trivy gets the same ignores as Checkov for the three Dockerfile findings (`.trivyignore`, 7d4c2d4)
- [ ] the excerpt at the top of `lint.log` stops after 300 lines and the yamllint warnings fill it, so errors of later linters are cut off; match only errors and failures there, or put the Super-Linter result table first
- [ ] add indentation and trailing whitespace rules to `.editorconfig` once the existing files are checked
- [ ] check after the next run: `AIX` in the platforms of `meta/main.yml` (an old warning, ignored as `schema[meta]`), `min_ansible_version` 2.9 is far too old, other aliases in other tasks (`user:`, `db:`, `daemon-reload`)
- [ ] yamllint only warns (line length over 80, spaces inside braces, and the indentation rule on `defaults/main.yml`, still listed in the run of 3dbf835); Prettier now decides the style, so decide if the `.yamllint` rules should follow Prettier

### Never pin tool versions

- [x] done for the CI workflows (actions at `@main`, Super-Linter `@latest`, `ansible-core` and `Unidecode` without a version range, the `unpinned-uses` rule of zizmor is off in `.github/linters/zizmor.yml`) and for the Ansible collections in `collections/requirements.yml`; the latest `ansible-core` needs Python 3.12 or newer, so the AlmaLinux 8 test container installs `python3.12` and uses it as the interpreter of the test hosts (it ran with `ansible-core` 2.21.6), which means the real role is not tested with the EL8 platform Python 3.6
- [ ] look for other pins in the tasks (for example `version:` of the Git checkouts, package versions) and decide for each if it is a tool pin; the newest collections may break tasks that were written for the old ones, so read the results of the first full run
- [ ] keep this rule for every new workflow, container image tag of a tool, `pip`, `npm` or Ansible collection requirement

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
- [ ] the release workflow has not been run yet
- [ ] check that nothing from the deleted Horde changes is needed (for example the utf8mb4 settings for Kolab or Roundcube data)
- [ ] compare the whole branch with `main` once more for non-Horde changes that did not arrive (the merge base is old, so changes of the 2.x line, for example AIDE, FQCN or linter fixes, may exist on only one side)
- [ ] keep the branch up to date with `main`: merge `main` into the branch with _Update branch_ (that needs a conflict-free state: set the release files and `tasks/horde.yml` to the content of `main` first, merge, then restore them and delete the Horde files again, as done for 5172692), and discard diffs that are specific to Horde
- [ ] mention the move from Horde to Kolab in the release notes before merging, because old setups need changes (the new variables are in `README.md`)
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
- [ ] CI test for both redirect items: in the converge container, request a list of old Horde URLs (web, CalDAV, CardDAV, push) with `curl` and check the status code and the `Location` header against the expected Kolab URL; the list of old URLs is part of the test data

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
- [ ] run the whole role on a test machine or in a CI container: nothing in the recent commits (`policy_uid`, `primary_mail`, usernames, addresses) has been executed against Kolab yet
- [ ] the built-in Cyrillic and Greek tables are a simple, readable scheme, not an official standard (for example ISO 9 or ELOT 743); check the results for your family's names
- [ ] users created by hand in the Kolab web admin follow `policy_uid`/`primary_mail`, and Kolab's own parser strips accents differently (it uses iconv transliteration and drops non-Latin letters), so check that both give identical names
- [ ] two users whose derived names become identical (for example two people called Anna in family mode, or `Kovács` and `Kovacs`) are not detected yet
- [ ] audit the remaining tasks (WireGuard, FTP, imapsync, backups, DKIM, DMARC) for assumptions about `user.name`, and read the `main` branch for comparison
- [ ] consider setting the OS account comment (GECOS) from the first name and surname

### Agent instructions

- [x] `AGENTS.md` sends every agent to the `ai-agent-config` repository and lists the rules of this repository
- [x] decided: squash the commits of a branch into one commit before the pull request is merged
- [x] decided: this file is removed before the pull request is merged (see Instruction cleanup for the remaining edit)

## Order of the owner

CI tests for every functionality first (high priority above), then LDAP and Postfix aliases (address scheme above), then the Roundcube identities, the decision about PostfixAdmin, the Cyrus items and the Horde to Kolab migration (including the redirects of the old Horde URLs). Lowest hanging fruits first, and keep this file up to date.

## Open decisions

- how the Kolab mail data (Cyrus mailboxes and mailbox database) is backed up consistently
- the shared rule to lint with a pinned Super-Linter image against the rule here to never pin anything
- where the long-term items go when this file is deleted (for example the Horde to Kolab migration plan and the address scheme work, if they are not finished before the merge): `README.md`, issues, or finish them first

## Working rules of the owner

- agents read the shared instructions of the `ai-agent-config` repository first; `AGENTS.md` points to them
- every change of server functionality gets a CI test in the same commit; check it before every commit
- all tests run in CI containers (AlmaLinux 8), not on the machine of the assistant; read the logs on the `ci-results` branch (tests) and the `ci-lint-results` branch (Super-Linter)
- check the CI results at the start of every task and fix what is red; ask only when something is really unclear
- explain changes in plain language, work independently, and keep the changes of `main` that are not Horde related
- name files after what they do
- check the claims of automatic CI summaries against the real log and the documentation before following or rejecting them (a summary was wrong that `fetch-depth: 0` was missing and that `actions/checkout@v4` should be pinned, and right that `community.mysql` was renamed to `ansible.mysql`)

## Resume prompt

In `suhancz/ansible-mailserver`, work on `feature/kolab` (draft pull request #65). Read the shared instructions of `suhancz/ai-agent-config` first, then this file. The CI of 3dbf835 is green; read the CI logs for the head commit (`ci-results` and `ci-lint-results`) and keep them green. Then work through the high-priority section first: build the converge workflow and one CI test per functional area, and before every commit name the functionality it changes and the test that covers it. Then work through the other open boxes in the order above, update this file in every commit, and wait for the CI runs after every push. Do not mark the backups as working until a backup and a restore ran in the CI test. Delete this file in the last commit before the pull request is merged.
