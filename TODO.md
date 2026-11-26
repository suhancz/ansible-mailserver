# TODO

List of things not implemented yet, but planned

- fix Roundcube login
- fix mail sending via Postfix
- if possible, configure `adduser` and so to work on LDAP
- confirm if PostfixAdmin is needed at all
- set up sieves for Cyrus
- set up SSL for Cyrus
- set up DKIM for Cyrus
- set up DMARC for Cyrus
- confirm Kolab- and Cyrus-related backups working
- clean up code (and enable VALIDATE_JSCPD in <.github/workflows/linter.yml>)

## Leftovers from the username work

- the GitHub Actions workflow (`.github/workflows/test-users.yml`) has never passed yet: read the masked log on the `ci-results` branch (`test-users.log`) and fix the workflow or the code if it fails (likely candidates: the `python3-unidecode` package name in EPEL 8, the Python interpreter used for the script, `include_role` with a `tasks_from` path, the `almalinux:8-minimal` image lacking something)
- delete the unused `library/mailserver_ascii_name.py` (replaced by `files/misc/ascii_name.py`)
- check that Super-Linter is green after the latest fixes; the `ansible-lint` and Prettier results were fixed without being able to run them
- the workflow only tests the username derivation, not the whole role; extend it step by step (for example a systemd-enabled AlmaLinux 8 container for the OS and LDAP parts)
- run the whole role on a test machine: nothing in the recent commits (`policy_uid`, `primary_mail`, usernames) has been executed against Kolab yet
- the built-in Cyrillic and Greek tables are a simple, readable scheme, not an official standard (for example ISO 9 or ELOT 743); check the results for your family's names
- users created by hand in the Kolab web admin follow `policy_uid`/`primary_mail`, and Kolab's own parser strips accents differently (it uses iconv transliteration and drops non-Latin letters), so check that both give identical names
- an explicit `name` is not converted to ASCII; it is only validated
- two users whose derived names become identical (for example two people called Anna in family mode, or `Kovács` and `Kovacs`) are not detected yet
- audit the remaining tasks (WireGuard, FTP, imapsync, backups, DKIM, DMARC) for assumptions about `user.name`, and read the `main` branch for comparison
- consider setting the OS account comment (GECOS) from the first name and surname
- add ansible-lint / Molecule scenarios and unit tests for `files/misc/ascii_name.py`
