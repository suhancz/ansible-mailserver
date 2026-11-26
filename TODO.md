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

* run the role on a test machine: nothing in the recent commits (`policy_uid`, `primary_mail`, `nickname`) has been executed yet
* decide if an explicit `name` should really win over `nickname` (currently it does, to stay backward compatible)
* the nickname is only stored as `displayName`; check whether the Kolab schema offers a better dedicated attribute
* users created by hand in the Kolab web admin follow `policy_uid`/`primary_mail` and know nothing about nicknames
* names with accents are not transliterated automatically; they need an explicit `nickname` or `name`
* audit the remaining tasks (WireGuard, FTP, imapsync, backups, DKIM, DMARC) for assumptions about `user.name`, and read the `main` branch for comparison
* consider setting the OS account comment (GECOS) from the first name, surname and nickname
* add Molecule or ansible-lint test cases for the user name derivation
* two users with the same derived name (e.g. two people called Anna in family mode) are not detected yet
