# Agent instructions

This file is for every AI agent that works in this repository, whatever its product or name.

## Read the shared instructions first

Before you start a task, read and follow the canonical instructions in the repository [suhancz/ai-agent-config](https://github.com/suhancz/ai-agent-config). Start with its root [AGENTS.md](https://github.com/suhancz/ai-agent-config/blob/main/AGENTS.md) and follow the policy links that apply.

## Rules of this repository

These rules add to the shared instructions; they do not replace them. If a rule here and a shared rule really conflict, do not decide alone: describe the conflict and ask the user.

- Check the CI first and fix what is red before you start new work. The test logs are on the `ci-results` branch (`test-users.log`, `test-role.log`, `test-unit.log`), the Super-Linter log is `lint.log` on the `ci-lint-results` branch. Read the real logs.
- High priority: every change of what the server does needs a CI test in the same commit (a new or extended test in `.github/workflows/tests.yml` or in the converge workflow). Check this every time before you prepare a commit: name the functionality the commit changes, and name the test that covers it. If no test covers it, add one; if that is not possible yet, say so in the commit message, add the gap to the high-priority section of `TODO.md` and tell the user. Never hide a missing test.
- Add the tasks that are in progress, with their next steps, to `TODO.md` in every commit. Remove them when they are done.
- Run tests only in the CI containers (AlmaLinux 8, see `.github/workflows/tests.yml`). Add new tests there.
- Never pin the version of a tool, an action, a collection or a package. Always use the latest, and use the canonical (current) names of modules and collections.
- Scripts that have to be executable are listed in `.github/executable-files.txt`; add every new script there. Line endings are LF everywhere (`.gitattributes`). The lint workflow repairs both with a bot commit.
- When the owner gives a permanent instruction for this repository, add it to this file or to `TODO.md` in the same task, and keep your own memory of it where you have one.
- Name files after what they do.
- Explain changes in plain language and work independently; ask only when something is really unclear.
- Read `README.md` for the role variables and keep it current when behaviour changes.
