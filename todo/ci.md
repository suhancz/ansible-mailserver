# CI: results, test containers, timeouts

[Index](../TODO.md)

## CI results

- 257a908 (2026-11-27): all 16 checks done and green, 2 repair jobs skipped (two workflow runs). Lint 2m46s (push) and 3m00s (PR), limit 20 min. Users and addresses 1m20s, unit 37s, syntax check 1m24s, systemd test 1m55s, backup templates 50s. Log-publishing jobs green. The four test logs are read (see the item below); `lint.log` not read. Sizes after the push of 257a908: `todo/ci.md` 5,481 bytes, `todo/lint.md` 6,097.
- 00b2209 (2026-11-27): all 16 checks done and green, 2 repair jobs skipped (two workflow runs). Lint 4m16s (push) and 3m11s (PR), limit 20 min. Users and addresses 1m44s, unit 41s, syntax check 3m15s (slow against 1m15s earlier), systemd test 1m49s, backup templates 48s. Log-publishing jobs green. Logs not read. Sizes after the push of 00b2209: `todo/lint.md` 6,085 bytes, `todo/backups.md` 5,040, `memory/MEMORY.md` 5,216, all under 25 KB.
- 55b9ac6 (2026-11-27): all 16 checks done and green, 2 repair jobs skipped (two workflow runs). Lint 2m33s (push) and 2m23s (PR), limit 20 min. Users and addresses 1m20s, unit 38s, syntax check 1m15s, systemd test 1m22s, backup templates 35s. Log-publishing jobs green. Logs not read.
- 7daafac (2026-11-27): all 16 checks done and green, 2 repair jobs skipped (two workflow runs). Lint 2m40s and 2m56s, limit 20 min. Users and addresses 1m21s, unit 36s, syntax check 1m15s, systemd test 2m00s, backup templates 38s. Log-publishing jobs green. Logs not read. Sizes after the push of 7daafac: `TODO.md` 6.2 KB, `todo/ci.md` 4.3 KB, `todo/instructions.md` 2.2 KB.
- 8b6a5af (2026-11-27): all 16 checks done and green, 2 repair jobs skipped. Lint 2m31s (push) and 2m29s (PR), limit 20 min. Users and addresses 1m47s, unit 36s, syntax check 1m38s, systemd test 1m34s, backup templates 3m54s (slow against 41s earlier; inside the 10 min limit). `lint.log` names 8b6a5af (log not read). Log-publishing jobs green.
- b7e2b79: all 16 checks done, none failed, 2 repair jobs skipped. Lint 3m54s (push) and 4m07s (PR). Syntax check 2m46s, systemd test 2m09s. `lint.log` names b7e2b79 (log not read).
- 5c491b8: 14 green, 2 skipped. `lint.log` and `test-unit.log` read: success; 9 unit tests; Checkov 0 failed (60, 164, 11 passed); only the two known ignored Ansible findings; Python 3.14. The excerpt is cut off in yamllint warnings. Other four test logs not read.
- 024dc51: logs read. Systemd test `ok=80 failed=0 skipped=10` with all ten services of the shared list; syntax check passes with `include_vars`.
- Older: green since 1a3f230; earlier failures were only NATURAL_LANGUAGE wording. 507056c: one `microdnf` hang over 13 min, not seen again.
- Tests (green on 024dc51 by logs, on 5c491b8, b7e2b79, 8b6a5af, 7daafac, 55b9ac6 and 00b2209 by status, on 257a908 by logs): users and addresses, whole-role syntax, unit, backup templates, systemd backup test with dummy services. Nothing tests the whole role on a server.

## CI first

- [x] Red Super-Linter findings fixed at their cause (green on 3dbf835): Pylint `C0415` in `files/misc/ascii_name.py`, shfmt in `files/ldap/extract_user_data_to_migrate.sh` and `tests/mask_log.sh`, codespell (`aci`; typos in `tasks/os/packages.yml:208` and `tasks/mariadb/create_mariadb_schema.yml`), Prettier (one run of the Super-Linter fixer, bot commit 652bb7a, 26 files), Trivy (`.trivyignore`: DS-0001, DS-0002, DS-0026, same as the Checkov skips)
- [x] Tests and lint job read and green: bd51374, 1a3f230 (owner report), 024dc51, and 5c491b8 by job status (14 green, 2 skipped; `lint.log` head and `test-unit.log` read)
- [x] the four other test logs read for 257a908 (`test-users.log`, `test-role.log`, `test-backups.log`, `test-backups-functional.log`): all `result of all tests: success`, tested commit as pushed; users: five cases `failed=0`, `case_missing` rescued once on purpose (no username derivable); role: syntax check passes, five `port` warnings (lint file); templates: `ok=16 failed=0`, every assertion passed; systemd test: `ok=80 changed=45 failed=0 skipped=10`, `systemd state: running`; the connector cuts the long logs, so the systemd log is read only up to the dummy services and its recap comes from the excerpt at the top
- [ ] optional: read the Super-Linter result table of a full lint log, to see each linter row
- [ ] after every push: read the logs, keep tests green
- [x] DevSkim never started on `main` (removed `ubuntu-20.04` image); fixed on `main` (#66) and here (`ubuntu-latest`); green on #65

## CI test containers

`.github/workflows/tests.yml` (_Tests_): matrix job, four entries in minimal AlmaLinux 8 (users and addresses, whole-role `ansible-playbook --syntax-check` with the latest collections, unit tests of `files/misc/ascii_name.py`, backup template rendering) and job _Backups and restores in a systemd container_ (privileged `8-init`, systemd PID 1, dummy-service test). Logs on `ci-results`: `test-users.log`, `test-role.log`, `test-unit.log`, `test-backups.log`, `test-backups-functional.log`. The converge test (request 2) comes last.

- [x] first three entries and log publishing pass (15c78c6, eacf254, c44c463, 813194b, 11115ea, 3dbf835); fourth entry green on eca7618, 5fa138a, bd51374
- [x] systemd container starts (`systemd state: running`, privileged, host cgroup namespace, `/sys/fs/cgroup` mounted); backup test passed in it (bd51374)
- [ ] in progress: `tests.yml` job timeout 10 min instead of 30 (the 507056c hang lasted over 13 min); slowest job 2 to 4 min; runs of c973397, 024dc51, 5c491b8, b7e2b79, 8b6a5af stayed inside, but no hang has shown the limit working; gaps: no test covers a timeout, and the `microdnf` step has no retry (the option for metadata retries is unverified)
- [x] `linter.yml` timeouts: 5 min for `check-permissions` and `repair-script-modes`, 20 min for `lint` (normally 2 to 6 min); before 95c24ca only `report-lint` had one (5 min); `release.yml` and `devskim.yml` have none (short); runs of 024dc51, 5c491b8, b7e2b79 and 8b6a5af stayed inside (permission check at most 11 s; lint at most 6m03s); gaps: no timeout test, 20 min is a guess
- [ ] converge test (request 2), only when all else is done: systemd AlmaLinux 8 container running `tasks/os`, `tasks/ldap`, then MariaDB, Postfix, Kolab; shared with later tests
- [ ] check idempotence by converging twice
