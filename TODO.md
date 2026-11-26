# TODO

List of things not implemented yet, but planned

* fix Roundcube login
* fix mail sending via Postfix
* if possible, configure `adduser` and so to work on LDAP
* confirm if PostfixAdmin is needed at all
* set up sieves for Cyrus
* set up SSL for Cyrus
* set up DKIM for Cyrus
* set up DMARC for Cyrus
* confirm Kolab- and Cyrus-related backups working
* clean up code (and enable VALIDATE_JSCPD in <.github/workflows/linter.yml>)

## Leftovers from the nickname / user name work

* run the role on a test machine: nothing in the recent commits (`policy_uid`, `primary_mail`, `nickname`, `mailserver_ascii_name`) has been executed yet
* confirm that `python3-unidecode` exists in EPEL for your EL release; otherwise the pip fallback is used
* the module runs with the Python interpreter Ansible picked on the target; the RPM (and pip) install Unidecode for the system `python3`, so set `ansible_python_interpreter` to it if they differ
* the module has not been tried with the real Unidecode package (only with a stub); Chinese, Arabic, Hebrew and so on are therefore unverified
* the built-in Cyrillic and Greek tables are a simple, readable scheme, not an official standard (e.g. ISO 9 or ELOT 743); check the results for your family's names
* decide if an explicit `name` should really win over `nickname` (currently it does, to stay backward compatible)
* the nickname is only stored as `displayName`; check whether the Kolab schema offers a better dedicated attribute
* users created by hand in the Kolab web admin follow `policy_uid`/`primary_mail` and know nothing about nicknames; Kolab's own parser also strips accents differently (it uses iconv transliteration and drops non-Latin letters), so check that both give identical names
* an explicit `name` is not converted to ASCII; it is only validated
* two users whose derived names become identical (e.g. two people called Anna in family mode, or `Kovács` and `Kovacs`) are not detected yet
* audit the remaining tasks (WireGuard, FTP, imapsync, backups, DKIM, DMARC) for assumptions about `user.name`, and read the `main` branch for comparison
* consider setting the OS account comment (GECOS) from the first name, surname and nickname
* add Molecule or ansible-lint test cases for the user name derivation and unit tests for `library/mailserver_ascii_name.py`
