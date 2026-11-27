# Work status (index)

Work on `feature/kolab` (draft PR #65). `TODO.md` and the `todo/` directory are deleted together in the last commit before the merge (owner). Before that, finish every open box or move it where the owner says.

Marks (owner, 2026-11-27): `[x]` done and verified; `[ ]` to do; `[ ] in progress:` success not verified (not proven by CI or on a server, or only for an older version). When unsure, in progress. An item closes only on CI or server proof.

Format (owner, 2026-11-27; shared rule of `ai-agent-config`, PR #16): as few words as possible, same meaning. Items live in one category file each, under 25 KB, read whole before editing. Recount the counts below in the same commit as every change. Check sizes after the push.

## Summary

- Items: done 40, in progress 13, to do 79 (132 in total)
- Categories: done 0, in progress 7, not started 2

## Goal

Kolab role complete and releasable as 3.0.0: tested backups and restore, no copies of shared rules in the instructions, green CI, owner items in the category files.

## Current state

- Head before this commit: b7e2b79 (terse rule, shortened `TODO.md`). Earlier: 5c491b8, 024dc51, 9a92cab, 95c24ca, 43e8b42, c973397, 507056c, bd51374, c8187f5, a1aedd8 (Kolab versions restored after merge 7effafb of `main` 2.6.3), c57b4b9. Branch not behind `main`.
- CI of b7e2b79 (2026-11-27): all 16 checks done, none failed, 2 repair jobs skipped; lint 3m54s and 4m07s; five test jobs green; `lint.log` names b7e2b79 (log not read). Details in the CI file.
- Backups pass only with dummy services; the ten services that failed on the server built from `main` are not yet shown fixed on a server. In progress, not working.
- `main`: Dovecot and Horde backup fixes merged as #66 (2.6.3, 2f56b83). `ai-agent-config`: terse rule (PR #15) and the small-files and category-split rule (PR #16, 75a8b76) are merged.
- Owner rules: every commit carries its update of these files; marks as above; tests by the order below.

## Categories

State in progress, done 4, in progress 0, to do 17:
[tests: a CI test per change, area tests](todo/tests.md)

State in progress, done 6, in progress 2, to do 4:
[ci: CI first, test containers, timeouts](todo/ci.md)

State in progress, done 12, in progress 1, to do 12:
[lint: Super-Linter, wording, pins, Trivy, modules, executables](todo/lint.md)

State in progress, done 6, in progress 9, to do 6:
[backups: Kolab backup and restore](todo/backups.md)

State in progress, done 2, in progress 0, to do 6:
[release: release 3.0 and the merge](todo/release.md)

State not started, done 0, in progress 0, to do 9:
[migration: Horde to Kolab in place, redirects](todo/migration.md)

State in progress, done 2, in progress 0, to do 14:
[addresses: address scheme and username leftovers](todo/addresses.md)

State in progress, done 8, in progress 1, to do 5:
[instructions: instruction cleanup and agent files](todo/instructions.md)

State not started, done 0, in progress 0, to do 6:
[role: items from the start](todo/role.md)

## Order of the owner

Test order (2026-11-27): all other items first, easiest first, each with its own individual test. Then the full deployment in a container (request 2), then backup and restore against it (request 1, stages 2 and 3). Until then keep the individual tests. Update the files in the same commit as every change.

## Open decisions

- consistent backup of Kolab mail data (Cyrus mailboxes and mailbox database): stop and snapshot, or replicate to a Cyrus backup server (a running-server archive is crash-consistent only)
- shared rule pins a Super-Linter image, this repository never pins
- where long-term items go when these files are deleted (migration plan, address scheme, if unfinished): `README.md`, issues, or finish first
- whether the marks and the "commit carries its update" rule go into `AGENTS.md` or stay here

## Working rules of the owner

- read the shared instructions of `ai-agent-config` first; `AGENTS.md` points to them
- every server-behavior change gets a CI test in the same commit; every commit carries the update of these files, never a separate commit afterwards
- marks: `[x]` done, `[ ]` to do, `[ ] in progress:` when success is not verified; nothing else
- tests run in CI containers (AlmaLinux 8), not on the agent's machine; logs on `ci-results` (tests) and `ci-lint-results` (Super-Linter)
- when the linter fails, read `lint.log` and fix the findings at their cause on the same branch; check CI at the start of every task; ask only when really unclear
- explain in plain language, work independently, keep the non-Horde changes of `main`
- fixes only for what `main` has go to a separate branch and PR against `main`; what is in neither branch goes to the owner as instructions (a Bash one-liner for the server)
- name files after what they do; write as few words as possible, same meaning; all AI files small, split by category
- check claims of automatic CI summaries against the real log and documentation (one was wrong that `fetch-depth: 0` was missing and `actions/checkout@v4` should be pinned, and right that `community.mysql` was renamed to `ansible.mysql`)

## Resume prompt

In `suhancz/ansible-mailserver`, work on `feature/kolab` (draft PR #65). Read the shared instructions of `suhancz/ai-agent-config` first, then this index including the marks, then only the category files the task touches, each whole. An unverified item is `in progress` and closes only on CI or server proof. Read the CI logs of the head commit (`ci-results`, `ci-lint-results`); close proven in-progress items and keep tests green; when the linter fails, read `lint.log` and fix at the cause. Follow the test order: all other open boxes first, easiest first, each with an individual test (name functionality and test before every commit). Update the touched category files and the counts here in every commit, in as few words as possible. Build the full deployment in a container (request 2) only when all else is done, then backup and restore stages 2 and 3. Wait for CI after every push. Fixes only for `main` go to a separate branch and PR. Do not call backups working until a backup and restore ran in CI. Delete `TODO.md` and `todo/` in the last commit before the merge.
