# Lint: Super-Linter, wording, pins, Trivy, modules, executables

[Index](../TODO.md)

## Super-Linter log and findings

Owner rule (2026-11-27): when the linter fails, read [lint.log](https://github.com/suhancz/ansible-mailserver/blob/ci-lint-results/lint.log) on `ci-lint-results` and fix the findings at their cause on the same branch, unasked. Check the linted commit in the first lines is the pushed one, look for errors of every linter in the full log (the excerpt holds 300 lines), say when the log is cut before the failure, never hide a finding with an ignore unless the owner decided, reread after every fix. Also in `AGENTS.md` (9a9ae0f).

- [x] the lint job publishes the masked `lint.log` on `ci-lint-results` (seen up to b7e2b79); the branch keeps only the latest log (one commit), so older logs cannot be read
- [x] failures read and fixed: c57b4b9 (CHECKOV, NATURAL_LANGUAGE: `ssl` and `bash` in the old file, now code span and `Bash`); 5fa138a (`args[module]` for `modification_format` in `tests/backups_functional.yml` line 163; `file name` in `AGENTS.md`; `lint rule` in the old file; all fixed in bd51374); bd51374 (`linter warning` twice; fixed in 1a3f230); 95c24ca (the CI job name in plain words, twice; fixed in 9a92cab, memory file records it)
- [x] heads of `lint.log` of 9a92cab and 5c491b8 read: success, linted commit as pushed, Checkov 3.3.19 (3.4.11 available) with 0 failed (60, 164, 11 passed), only the two known ignored Ansible warnings, Python 3.14 (in `memory/MEMORY.md`)
- [ ] resolve the versions of the other linters under `latest` from a lint log (only Checkov 3.3.19 and the Python 3.14 runtime of the Ansible linter are known; not the Ansible linter version)
- [x] Checkov follow-up of c57b4b9: finding did not return (0 failed in 5fa138a, bd51374, 9a92cab, 5c491b8); probable cause a fake password in `tests/backup_templates.yml` (replaced in 647bee6); exact rule and file unknown (log overwritten, connector cannot read run logs); closed as not reproducible
- [ ] in progress: read `lint.log` for the commit of this revision, fix what is red (lint job of b7e2b79 green; its log not read)
- [x] Ansible linter cannot find role `ansible_mailserver` for `tests/role_syntax.yml`; ignored as `syntax-check[specific]` in `.ansible-lint-ignore`
- [x] NATURAL_LANGUAGE wording for Markdown: `Ansible` (not all capitals), `EditorConfig`, `filename`, `filenames`, `hostnames`, `linter rule`, `linting warning`, `Bash`, `codebase` or the lint job; tool and linter names as code spans; quote a rejected term only inside a code span
- [x] line endings pass (e730605); editorconfig-checker passes (eacf254, cb9e339)
- [x] owner decisions: Prettier ran once via the Super-Linter fixer (workflow `prettier-fix-yaml.yml` added in 7d4c2d4, bot commit 652bb7a, deleted in e2471bf); Trivy ignores the three Dockerfile findings like Checkov (`.trivyignore`, 7d4c2d4)
- [ ] change the excerpt at the top of `lint.log`: it stops after 300 lines filled with yamllint warnings (seen again on 5c491b8), cutting off later linters. Put errors and the Super-Linter result table first, cap warnings in a separate section, keep the full masked log; read `linter.yml` first; verify in a CI run. The fetch tool also cuts the file, so a failed check cannot always be traced
- [ ] add indentation and trailing whitespace rules to `.editorconfig` after checking existing files
- [ ] check after the next run: `AIX` in `meta/main.yml` platforms (ignored as `schema[meta]`), `min_ansible_version` 2.9 far too old, other aliases (`user:`, `db:`, `daemon-reload`)
- [ ] yamllint only warns (line length over 80, braces spacing, indentation of `defaults/main.yml` and flow-style items in `tasks/backups/main.yml`); Prettier decides style; decide whether `.yamllint` should follow Prettier

## Never pin tool versions

Owner decision (2026-11-27): keep `latest` and adjust the linters when a new version needs it; this holds for `ai-agent-config` too (it overrides its older pinned-image policy).

- [x] workflows (actions at `@main`, Super-Linter `@latest`, `ansible-core` and `Unidecode` unpinned, zizmor `unpinned-uses` off in `.github/linters/zizmor.yml`) and collections in `collections/requirements.yml`; latest `ansible-core` needs Python 3.12, so the test containers install `python3.12` as interpreter (ran with `ansible-core` 2.21.6): the role is not tested with the EL8 platform Python 3.6; the systemd container uses `quay.io/almalinuxorg/8-init:latest`
- [x] `ai-agent-config` on `latest`: PR #19 merged (29bd253): workflow `super-linter/super-linter@latest`, the linting-before-push rule and its memory; its 12 checks were green (Super-Linter, regression tests, CodeQL); the run on its `main` not read
- [ ] look for other pins in tasks (Git checkout `version:`, package versions); newest collections may break old tasks, read the first full run
- [ ] keep the rule for new workflows, image tags, `pip`, `npm`, collections
- [ ] `main` has `microsoft/DevSkim-Action@v1` (only runner, checkout, upload fixed in #66); this branch uses `@main`; goes away with the merge

## Trivy

- [x] vulnerability scanner off (5fa10ab): database download fails on runners, no dependency manifest; misconfiguration scanner runs
- [ ] switch `vuln` on in `.github/linters/trivy.yaml` once a manifest exists; if its check download still fails, stop running Trivy here (Checkov covers Ansible and workflows)

## Executable files workflow

- [x] `.github/executable-files.txt` lists scripts; `linter.yml` repairs missing modes with a bot commit (first run 78424c1)
- [ ] add every new script (the repair only adds the bit)

## Canonical module names

- [x] `mysql_db`, `mysql_user`, `mysql_query`, `collections/requirements.yml`, `meta/main.yml` use `ansible.mysql` (`fqcn[canonical]` was real, 20 tasks)
- [ ] `ansible.mysql` 6.0.0 drops MariaDB support for `ansible.mariadb` (`mariadb_db`, `mariadb_user`, `mariadb_query`); plan the move before it arrives
- [ ] check `ansible.posix`, `community.general`, `community.crypto`, `community.dns` for renames or deprecated redirects in the next lint log
