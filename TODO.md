# TODO

List of things not implemented yet, but planned

- fix Roundcube login
- fix mail sending via Postfix
- if possible, configure `adduser` and so to work on LDAP
- confirm if PostfixAdmin is needed at all
- set up sieves for Cyrus
- set up SSL for Cyrus
- set up DKIM for Cyrus
- set up DMARC for Cyrus
- confirm Kolab- and Cyrus-related backups working
- clean up code (and enable VALIDATE_JSCPD in <.github/workflows/linter.yml>)

## Working rules of the owner

- every commit lists the tasks that are in progress in this file (section _In progress_), with the next steps
- all tests run in CI containers (AlmaLinux 8), not on the machine of the assistant; read the logs on the `ci-results` branch (tests) and the `ci-lint-results` branch (Super-Linter)
- never pin tool versions, always use the latest of everything (details below)
- check the CI results at the start of every task and fix what is red; ask only when something is really unclear
- explain changes in plain language, work independently, and keep the changes of `main` that are not Horde related
- name files after what they do (the test workflow is `tests.yml`, not `test-users.yml`, because it runs more than the user tests)
- do not take the suggestions of automatic CI summaries over without checking them (for example `ansible.mysql.*` does not exist, `fetch-depth: 0` was already set, and a pinned `actions/checkout@v4` would break the no-pins rule); read the real log instead

## In progress

- **All tests in CI containers** (started in the commit that adds `tests/role_syntax.yml` and `tests/test_ascii_name.py`). The workflow `.github/workflows/tests.yml` (name _Tests_, renamed from `test-users.yml`) runs three entries in an AlmaLinux 8 container: the username and address derivation, `ansible-playbook --syntax-check` of the whole role with the latest collections, and the unit tests of `files/misc/ascii_name.py`. The logs are `test-users.log`, `test-role.log` and `test-unit.log` on the `ci-results` branch (a log keeps the name of its test). All three entries and the log publishing passed on e730605. Next steps:
  - read the logs of the three entries and keep them green
  - add a converge test: a systemd-enabled AlmaLinux 8 container that runs the OS and LDAP parts of the role (`tasks/os`, `tasks/ldap`), then Postfix and finally the Kolab installation
  - check idempotence by running the converge twice
- **Super-Linter log** (started in the commit that publishes it): the lint job saves the log, the output of every linter and the summary, masks them and `report-lint` publishes `lint.log` on the `ci-lint-results` branch. Next steps:
  - check that the log files are where Super-Linter puts them (`super-linter.log`, `super-linter-output/`, `super-linter-summary.md`); if `lint.log` is empty, find the right paths
  - read the findings from `lint.log` and fix them, instead of working from summaries
- **Line endings and file modes** (`.gitattributes` and `.editorconfig` were added in 5e58450, the normalisation job in e730605): text files use LF and UTF-8 everywhere, binary types are never converted. `linter.yml` checks with `git add --renormalize .` (in the temporary checkout only), and the job `repair-script-modes` commits the executable modes and then the normalisation as separate bot commits (`Normalize line endings according to .gitattributes`) and starts the linter again. On e730605 the check passed and the repair job was skipped: the files were LF already. Next steps:
  - check that editorconfig-checker accepts the files (final newline); it is part of the same Super-Linter run
  - add indentation and trailing whitespace rules to `.editorconfig` once the existing files are checked
- **Super-Linter findings on e730605** (the run reached the linters; the fetch of the merge commit works): ANSIBLE: the role `ansible_mailserver` is not found for `tests/role_syntax.yml` (the repository is the role and is only mounted under that name in the test container), now ignored as `syntax-check[specific]` in `.ansible-lint-ignore`; if the rule name does not match, the finding stays and the real log shows it. NATURAL_LANGUAGE: the terminology rule rejected the all-capitals spelling of the open work file name in running text (line 37 of this file); the sentence is rewritten, file names in code spans are fine. The automatic summary asked for `ansible.mysql.*` again; that collection does not exist, the modules stay `community.mysql.*` (the `user:` and `db:` aliases that really failed were fixed in 929b9c1). To check after the next run: `AIX` in the platforms of `meta/main.yml` (an old warning, ignored as `schema[meta]`), `min_ansible_version` 2.9 is far too old, other aliases in other tasks (`user:`, `db:`, `daemon-reload`)
- **Proceed with this list in this order**: tests in containers, then LDAP and Postfix aliases (address scheme below), then the Roundcube identities, the decision about PostfixAdmin, the Cyrus items and the Horde to Kolab migration

## Outstanding requests of the owner

- **Never pin tool versions, always use the latest of everything**: done for the CI workflows (actions at `@main`, Super-Linter `@latest`, `ansible-core` and `Unidecode` without a version range, the `unpinned-uses` rule of zizmor is off in `.github/linters/zizmor.yml`) and for the Ansible collections in `collections/requirements.yml`. Keep this rule for every new workflow, container image tag of a tool, `pip`, `npm` or Ansible collection requirement. The latest `ansible-core` needs Python 3.12 or newer, so the AlmaLinux 8 test container installs `python3.12` and uses it as the interpreter of the test hosts (it ran with `ansible-core` 2.21.6); the real role is therefore not tested with the EL8 platform Python 3.6. Still to look for: other pins in the tasks (for example `version:` of the Git checkouts, package versions) and decide for each if it is a tool pin. The newest collections may break tasks that were written for the old ones, so read the results of the first full run.
- **In-place switch from Horde to Kolab** (new option, for example `migrate_from_horde: true`): fetch mail, calendars, contacts, tasks and whatever else Horde holds, remove the Horde suite (and Dovecot), deploy the Kolab suite, then upload the saved data to the matching user. It has to work without any remote machine (the owner started something with `imapsync`, which needs a second IMAP server). Plan:
  - take a full `mysqldump` of the `horde` database as a safety copy before anything is removed
  - mail: read the Dovecot Maildirs in `/var/vmail/<domain>/<user>/Maildir` in place (they are never deleted) and upload them with plain IMAP `APPEND` into the Cyrus mailbox of the user (flags from the Maildir filenames, original dates, folder names mapped to the Cyrus separator and special folders such as `Spam`); keep the existing `imapsync` tasks for the case that a remote server exists
  - calendars, tasks and contacts: export them through the CalDAV and CardDAV interface of Horde with the password of each user into `/var/backups/horde-migration/<user>/`, then `PUT` them into the Kolab CalDAV/CardDAV interface (iRony) of the same user
  - notes, wiki pages and the Ingo mail filters (sieve) are copied into the backup directory but not imported automatically; decide later how to import them
  - make every step repeatable and safe (skip what was imported, never delete the backup, stop before removing Horde if an export failed)
  - unit-test the Maildir and DAV code in CI containers; the full migration cannot be tested without a real Horde installation, so mark it as untested until it ran on a copy of the real server
- **Trivy**: the vulnerability scanner was switched off in 5fa10ab, because its database download fails on the runners and the repository has no dependency manifest (only the misconfiguration scanner runs). Switch `vuln` back on in `.github/linters/trivy.yaml` once there is a manifest worth scanning. If Trivy still fails on its own check download, stop running Trivy on this repository (Checkov covers Ansible and the workflows).
- **Keep the branch up to date with `main`**: the draft pull request #65 (`feature/kolab` into `main`) exists. Merge `main` into the branch with _Update branch_ (that needs a conflict-free state: set the release files and `tasks/horde.yml` to the content of `main` first, merge, then restore them and delete the Horde files again, as done for 5172692), and discard diffs that are specific to Horde.
- **Executable files workflow** (like in `ai-agent-config`): `.github/executable-files.txt` lists the scripts, `linter.yml` repairs missing modes with a bot commit and runs again. The first run worked (bot commit 78424c1). It only adds the executable bit and never removes it from files that are not listed; add every new script to the manifest.

## Release 3.0

This branch is meant to become version 3.0.0 (`VERSION`); merging it into `main` publishes the release through `.github/workflows/release.yml`. The pull request is a draft (#65) for that reason.

- the release workflow, `RELEASING.md` and `VERSION` were taken over from `main` (2.6.2); the workflow was hardened a little (write permission only on the job, no manual inputs because of Checkov `CKV_GHA_7`, `actions/github-script` at `@main` like every other tool) and has not been run yet
- `main` was merged into this branch (5172692). Its Horde-only changes are not carried over on purpose: `tasks/horde_utf8mb4.yml` and the change in `tasks/horde.yml` are deleted again after the merge (Horde is replaced by Kolab here); check that nothing from them is needed (for example the utf8mb4 settings for Kolab or Roundcube data)
- compare the whole branch with `main` once more for non-Horde changes that did not arrive (the merge base is old, so changes of the 2.x line, for example AIDE, FQCN or linter fixes, may exist on only one side)
- mention the move from Horde to Kolab in the release notes before merging, because old setups need changes (the new variables are in `README.md`)
- the 2.x line stays on `main` until the merge; decide if a `2.x` maintenance branch is needed

## Email address scheme (in progress)

Goal: normal users get `givenname.surname@domain`, family domains give `givenname@surname-domain`, a user can have a preferred username (for example `sha@suhan.cz`), the administrator can add any alias, and every user can have an optional display name.

Done: `mail_domains` (domain, style, optional family surname) and the generation of `primary_address`, `generated_aliases`, `all_addresses`, `address_display_names` and `display_name` per user in `tasks/misc/generate_addresses.yml`, tested in CI with the example of the owner, and documented in `README.md`.
The display name is chosen per address: if the local part contains a word of the first name or surname (compared as plain Latin) it is the official full name in Unicode (`Akos Balla` for `akos@...`), otherwise the nickname (`suhanc` for `sha@...`).
The nickname is the optional `display_name`, else the explicit `name` as written, else the official name.
The user-level `display_name` is the one of the primary address.

Still to do:

- write the new addresses to LDAP: `mail` = primary address, `alias` = all addresses (`tasks/kolab/add_kolab_user.yml`, `tasks/ldap/convert_user_to_ldif.yml`); `displayName` already comes from `display_name`
- Roundcube: create one identity per address with its display name from `address_display_names` (LDAP has only one display name per user); check how the Kolab Roundcube plugins create identities from the LDAP `alias` attribute
- Postfix: map every alias to the primary address (`tasks/mail/user_mail_alias.yml`), and stop the wildcard `@custom-domain` mapping to the main domain when `mail_domains` is set
- Kolab recipient policy `primary_mail` per domain style (for users created in the Kolab web admin), instead of the global `family_mode`
- allow a user to send from every own address (sender login maps)
- make sure all `mail_domains` get their DNS records, certificates, DKIM and DMARC (they use `custom_domains`, which is now derived from `mail_domains`)
- detect addresses that would belong to two users (for example the same `givenname@family-domain`)
- administrator aliases whose local part does not look like a name (for example `info@`) get the nickname as display name; decide if that is wanted

## Leftovers from the username work

- the username and address tests passed in CI (merge commit 5172692, `ansible-core` 2.21.6 on Python 3.12); check `ci-results/test-users.log`, `test-role.log` and `test-unit.log` after every push
- run the whole role on a test machine or in a CI container: nothing in the recent commits (`policy_uid`, `primary_mail`, usernames, addresses) has been executed against Kolab yet (see _In progress_)
- the built-in Cyrillic and Greek tables are a simple, readable scheme, not an official standard (for example ISO 9 or ELOT 743); check the results for your family's names
- users created by hand in the Kolab web admin follow `policy_uid`/`primary_mail`, and Kolab's own parser strips accents differently (it uses iconv transliteration and drops non-Latin letters), so check that both give identical names
- two users whose derived names become identical (for example two people called Anna in family mode, or `Kovács` and `Kovacs`) are not detected yet
- audit the remaining tasks (WireGuard, FTP, imapsync, backups, DKIM, DMARC) for assumptions about `user.name`, and read the `main` branch for comparison
- consider setting the OS account comment (GECOS) from the first name and surname
