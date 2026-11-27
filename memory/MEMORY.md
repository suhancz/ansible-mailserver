# Memory of this repository

Durable, non-sensitive lessons and decisions for every agent that works on this repository. Read it together with `AGENTS.md`, and record a new lesson here in the same commit as the change that taught it. Keep the entries short. The shared rules of `ai-agent-config` apply as well, and generic lessons also belong in its shared memory.

## Lessons from linter outputs

- `Super-Linter` runs with the tag `latest` here, so its linters change between runs, and the bundled version trails the newest release: the log of `9a92cab` shows `Checkov` 3.3.19 while 3.4.11 was available, and the Ansible linter runs on Python 3.14; read the versions from the output of a real log, not from the project pages (the other linters are not recorded yet)
- `NATURAL_LANGUAGE` (the terminology rule of `textlint`) checks every Markdown file, including the status files and `AGENTS.md`, and a single finding fails the whole lint job
- the terms that it rejected so far, with the wording that passes: `Code Base` as the name of the CI job (write the lint job or `codebase`), `linter warning` (write `linting warning`), `file name` and `file names` (write `filename` and `filenames`), `lint rule` (write `linter rule`), `host names` (write `hostnames`), and the lowercase `bash` in running text (write `Bash`)
- it also rejected an all-capitals `Ansible` or `EditorConfig` and plain-text tool names that look like product names, so put the names of linters and tools in code spans, and quote a rejected term only inside a code span
- `yamllint` only warns here (line length over 80, spaces inside braces, indentation of `defaults/main.yml` and of flow-style items), and `Prettier` decides the YAML style (one bot commit formatted 26 files), so do not fix these warnings by hand
- `ansible-lint` reports two known ignored warnings: `schema[meta]` for the platform `AIX` in `meta/main.yml`, and `syntax-check[specific]` for `tests/role_syntax.yml`, which is listed in `.ansible-lint-ignore`
- `Checkov` and `Trivy` ignore the three Dockerfile findings DS-0001, DS-0002 and DS-0026 by decision of the owner (`.trivyignore` and the `Checkov` configuration); a fake password value in a test template probably triggered `Checkov` once (the exact rule is unknown, the log was overwritten)
- the excerpt at the top of `lint.log` stops after 300 lines and the `yamllint` warnings fill it, so the errors of later linters can be cut off; the first lines name the linted commit, which has to be the commit that was pushed
- the lint job takes about 2 to 6 minutes (the pull request run is the slower one, 6 minutes 3 seconds for `5c491b8`); the limit of 20 minutes is far above

## Notes on the tools

- the GitHub connector cuts large reads and writes only whole files: a 32 KB file came back cut off, so 30 KB is the limit and every AI-generated file stays under 25 KB (`TODO.md` was about 55 KB, was cut off, and is now an index plus category files in `todo/`); to change a larger file, read all of it with a scrape of its raw URL at a commit SHA, change only the needed lines, push the complete file, and check the size of the new commit
- `lint.log` on `ci-lint-results` is overwritten by every run (its history shows one commit) and is about 940 KB, and the connector cuts it off, so for a run whose log was overwritten the result of the job in the check runs is the proof; the commit message on that branch names the linted commit
- the connector has no tool for workflow runs or for the check runs of a branch: read the status of a pull request from its check runs; the Actions page of a repository could not be fetched either, so the status of a branch such as `main` after a merge stays unread unless a pull request shows it
- tests run only in the CI containers (AlmaLinux 8), not on the machine of the agent

## Decisions of the owner

- never pin the version of a tool, an action, a collection or a package in this repository; the same holds in `ai-agent-config`, where `Super-Linter` runs with `latest` too (2026-11-27, PR #19); adjust the linters when a new version needs it
- all AI instructions of this repository, including this memory file, stay in the branch and go to `main` with the release of Kolab; only `TODO.md` and `todo/` are deleted before the merge
- no merge into `main` and no release until every item of the status files is solved; the exception is a release candidate, set explicitly as `-rc.N` in `VERSION`, with a new number whenever a long-term or grouped item is done; fixes are allowed on the branch they fix (2026-11-27)
- back up the Cyrus mail data from a snapshot, without downtime (2026-11-27)
- every commit carries the update of the status files and a CI test for every change of what the server does; the marks and this rule stay in the status index and are not copied into `AGENTS.md`
- write as few words as possible while keeping the meaning, and always work around the truncation risk; keep all AI-generated content small and split by topic (2026-11-27; the shared rules are merged in `ai-agent-config`, PR #15 and PR #16)
- status files: index `TODO.md` with counts of items and categories, one file per task category in `todo/`; counts are recounted in every commit
