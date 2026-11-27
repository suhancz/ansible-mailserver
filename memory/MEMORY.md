# Memory of this repository

Durable, non-sensitive lessons and decisions for every agent that works on this repository. Read it together with `AGENTS.md`, and record a new lesson here in the same commit as the change that taught it. Keep the entries short. The shared rules of `ai-agent-config` apply as well, and generic lessons also belong in its shared memory.

## Lessons from linter outputs

- `Super-Linter` runs with the tag `latest` here, so its linters change between runs; read the first lines of the real log to see what ran before comparing it with the configuration (no version is recorded yet)
- `NATURAL_LANGUAGE` (the terminology rule of `textlint`) checks every Markdown file, including `TODO.md` and `AGENTS.md`, and a single finding fails the whole lint job
- the terms that it rejected so far, with the wording that passes: `Code Base` as the name of the CI job (write the lint job or `codebase`), `linter warning` (write `linting warning`), `file name` and `file names` (write `filename` and `filenames`), `lint rule` (write `linter rule`), `host names` (write `hostnames`), and the lowercase `bash` in running text (write `Bash`)
- it also rejected an all-capitals `Ansible` or `EditorConfig` and plain-text tool names that look like product names, so put the names of linters and tools in code spans, and quote a rejected term only inside a code span
- `yamllint` only warns here (line length over 80, spaces inside braces, indentation of `defaults/main.yml` and of flow-style items), and `Prettier` decides the YAML style (one bot commit formatted 26 files), so do not fix these warnings by hand
- `ansible-lint` reports two known ignored warnings: `schema[meta]` for the platform `AIX` in `meta/main.yml`, and `syntax-check[specific]` for `tests/role_syntax.yml`, which is listed in `.ansible-lint-ignore`
- `Checkov` and `Trivy` ignore the three Dockerfile findings DS-0001, DS-0002 and DS-0026 by decision of the owner (`.trivyignore` and the `Checkov` configuration); a fake password value in a test template probably triggered `Checkov` once
- the excerpt at the top of `lint.log` stops after 300 lines and the `yamllint` warnings fill it, so the errors of later linters can be cut off; the first lines name the linted commit, which has to be the commit that was pushed

## Notes on the tools

- the GitHub connector returns only the first part of a large file (about 40 KB; `TODO.md` is about 50 KB) and writes only whole files; to change a large file, read all of it with a scrape of its raw URL at a commit SHA, change only the needed lines, push the complete file, and scrape the new commit to check that nothing else changed
- tests run only in the CI containers (AlmaLinux 8), not on the machine of the agent

## Decisions of the owner

- never pin the version of a tool, an action, a collection or a package in this repository; the shared rules of `ai-agent-config` pin a `Super-Linter` image tag, which is an open decision in `TODO.md`
- all AI instructions of this repository, including this memory file, stay in the branch and go to `main` with the release of Kolab; only `TODO.md` is deleted before the merge
- every commit carries the update of `TODO.md` and a CI test for every change of what the server does
