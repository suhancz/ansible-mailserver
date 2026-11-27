#!/usr/bin/env bash
# Reads a log on stdin and writes it to stdout with sensitive values masked:
# passwords, secrets, tokens and keys given as `name: value` or `name=value`,
# bearer/basic credentials, credentials inside URLs, GitHub tokens and email addresses.
set -euo pipefail

sed -E -f <(
	cat <<'EOF'
s#(Bearer|Basic)[[:space:]]+[A-Za-z0-9._~+/=-]+#\1 ***#Ig
s#("?([A-Za-z_]*(pass(word|wd|phrase)?|secret|token|api[_-]?key|private[_-]?key|privatekey|psk|authorization|credentials?|bind_pw))"?[[:space:]]*[:=][[:space:]]*)("[^"]*"|'[^']*'|[^[:space:],}]+)#\1"***"#Ig
s#(://)[^/@[:space:]]+@#\1***@#g
s#(gh[pousr]_|github_pat_)[A-Za-z0-9_]+#***#g
s#[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}#***@***#g
EOF
)
