# Release 3.0 and the merge

[Index](../TODO.md)

This branch becomes 3.0.0 (`VERSION`); the merge into `main` publishes it via `.github/workflows/release.yml`. Commits are squashed into one before the merge.

- [x] draft PR #65 exists; release workflow, `RELEASING.md`, `VERSION` taken from `main` (2.6.2), workflow hardened (write permission on the job only, no manual inputs for `CKV_GHA_7`, `actions/github-script@main`)
- [x] `main` merged (5172692; Horde-only changes dropped: `tasks/horde_utf8mb4.yml`, the `tasks/horde.yml` change) and again after 2.6.3 (7effafb) in three steps, as the tools cannot make merge commits: a temporary commit (29c31b2) set files differing on both sides (four backup templates, `tasks/backups.yml`, `VERSION`, DevSkim workflow) to `main`; merge without conflicts; then a1aedd8 and eca7618 restored Kolab versions and deleted `tasks/backups.yml`
- [ ] release workflow not run for 3.0.0 (ran for 2.6.3 on `main`)
- [ ] check nothing from the deleted Horde changes is needed (utf8mb4 for Kolab or Roundcube data)
- [ ] compare the branch with `main` for non-Horde changes that did not arrive (old merge base: AIDE, FQCN, linter fixes)
- [ ] keep up to date with `main` (_Update branch_ needs a conflict-free state: set differing files to `main`, merge, restore Kolab versions, delete Horde files again, as for 5172692 and 7effafb)
- [ ] release notes before the merge: the Horde to Kolab move, new variables in `README.md`; `vars/backup_services.yml` is internal
- [ ] decide on a `2.x` maintenance branch (2.x stays on `main` until the merge)
