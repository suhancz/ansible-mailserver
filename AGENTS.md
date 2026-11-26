# Agent instructions

This file is for every AI agent that works in this repository, whatever its product or name.

## Read the shared instructions first

Before you start a task, read and follow the canonical instructions in the repository [suhancz/ai-agent-config](https://github.com/suhancz/ai-agent-config):

1. Read its root [AGENTS.md](https://github.com/suhancz/ai-agent-config/blob/main/AGENTS.md) and follow the links in it. Load every policy that applies, including the global preferences, the shared memory, the reporting, mail routing and Git safety policies, and the entry instructions and adapter guide of your own agent.
2. Use the latest version, not a cached copy or a summary, and read them again at every task boundary.
3. If you cannot read that repository, say so in your answer instead of claiming that you follow it.
4. Do not copy private values (addresses, account names, credentials, hostnames) from your own configuration into this repository.

## Rules of this repository

These rules add to the shared instructions; they do not replace them. If a rule here and a shared rule really conflict, do not decide alone: describe the conflict and ask the user.

- Check the CI first and fix what is red before you start new work. The test logs are on the `ci-results` branch (`test-users.log`, `test-role.log`, `test-unit.log`), the Super-Linter log is `lint.log` on the `ci-lint-results` branch. Read the real logs; do not trust automatic summaries without checking them.
- Add the tasks that are in progress, with their next steps, to `TODO.md` in every commit. Remove them when they are done.
- Run tests only in the CI containers (AlmaLinux 8, see `.github/workflows/tests.yml`). Add new tests there.
- Never pin the version of a tool, an action, a collection or a package. Always use the latest.
- Scripts that have to be executable are listed in `.github/executable-files.txt`; add every new script there. Line endings are LF everywhere (`.gitattributes`). The lint workflow repairs both with a bot commit.
- Name files after what they do.
- Explain changes in plain language and work independently; ask only when something is really unclear.
- Read `README.md` for the role variables and keep it current when behaviour changes.
