# Instructions: instruction cleanup and agent files

[Index](../TODO.md)

## Instruction cleanup

- [x] copies of shared rules removed from `AGENTS.md` (2cc2922); `AGENTS.md` rules added: CI test per change, work-status files, lint log fix (9a9ae0f), test order (bd51374), terse and truncation rule (b7e2b79)
- [x] decided: the status files are deleted before the merge; the `AGENTS.md` rule matches
- [x] the four workflows hold no copies of shared rules
- [x] owner rules of 2026-11-27 (commit carries its update; unverified is in progress) are in the index; owner decided (2026-11-27): they stay there and are not copied into `AGENTS.md`
- [ ] read comments in tasks, templates, scripts for copies of shared rules (not read)
- [ ] remove the copies in the working rules of the index (open decisions settled 2026-11-27)
- [ ] timestamps in every message and a completion email report (shared rules): not done in this work

## Agent instructions

- [x] `AGENTS.md` points to `ai-agent-config` and lists this repository's rules
- [x] decided: squash a branch into one commit before the merge; remove the status files before the merge
- [x] `memory/MEMORY.md` holds lessons, tool notes, owner decisions; `AGENTS.md` points to it (9a92cab); owner (2026-11-27): all AI instructions including the memory file stay and go to `main` with the Kolab release; only the status files are deleted
- [x] terse and truncation rule recorded here (`AGENTS.md`, memory) and merged in `ai-agent-config` (PR #15)
- [x] generic memory lessons (terms `NATURAL_LANGUAGE` rejects) in the shared memory of `ai-agent-config`, only for repositories running Super-Linter defaults: five lessons, PR #18 merged (b84aaa9; 19,001 bytes); checks of the PR head green; the run on `main` not read
- [x] status files split by category under the shared rule (PR #16, 75a8b76), 8b6a5af: index with counts plus nine files in `todo/`; read back whole (ends complete, sizes 0.3 to 6.2 KB), every mark recounted (counts matched), CI of 8b6a5af green (16 checks); `AGENTS.md` and `memory/MEMORY.md` carry the corrected 30 KB limit
- [x] `instructions/all-agents.instructions.md` split in `ai-agent-config` (PR #17, d2147a0): entry file 8.9 KB plus six section files, 35,255 bytes in total = original 32,066 plus added headers and links (checked); checks of the PR head green (Super-Linter, regression tests, CodeQL); the run on `main` not read. A first commit lost the cut-off tail; restored from the full text
