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
- the Apache templates for PostfixAdmin and PowerAdmin have two directives on one line (`AuthLDAPGroupAttributeIsDN On  AuthLDAPURL ...`), which Apache probably rejects

## Email address scheme (in progress)

Goal: normal users get `givenname.surname@domain`, family domains give `givenname@surname-domain`, a user can have a preferred username (for example `sha@suhan.cz`), the administrator can add any alias, and every user can have an optional display name.

Done: `mail_domains` (domain, style, optional family surname) and the generation of `primary_address`, `generated_aliases`, `all_addresses`, `address_display_names` and `display_name` per user in `tasks/misc/generate_addresses.yml`, tested in CI with the example of the owner.
The display name is chosen per address: if the local part contains a word of the first name or surname (compared as plain Latin) it is the official full name in Unicode (`Akos Balla` for `akos@...`), otherwise the nickname (`suhanc` for `sha@...`).
The nickname is the optional `display_name`, else the explicit `name` as written, else the official name.
The user-level `display_name` is the one of the primary address.

Still to do:

- write the new addresses to LDAP: `mail` = primary address, `alias` = all addresses (`tasks/kolab/add_kolab_user.yml`, `tasks/ldap/convert_user_to_ldif.yml`); `displayName` already comes from `display_name`
- Roundcube: create one identity per address with its display name from `address_display_names` (LDAP has only one display name per user); check how the Kolab Roundcube plugins create identities from the LDAP `alias` attribute
- Postfix: map every alias to the primary address (`tasks/mail/user_mail_alias.yml`), and stop the wildcard `@custom-domain` mapping to the main domain when `mail_domains` is set
- Kolab recipient policy `primary_mail` per domain style (for users created in the Kolab web admin), instead of the global `family_mode`
- allow a user to send from every own address (sender login maps)
- make sure all `mail_domains` get their DNS records, certificates, DKIM and DMARC (they use `custom_domains`, which is now derived from `mail_domains`)
- detect addresses that would belong to two users (for example the same `givenname@family-domain`)
- administrator aliases whose local part does not look like a name (for example `info@`) get the nickname as display name; decide if that is wanted
- document `mail_domains`, `primary_address`, `display_name`, `name_input` and `aliases` in `README.md`

## Leftovers from the username work

- the username and address tests pass in CI on the latest commits; check `ci-results/test-users.log` after every push
- delete the unused `library/mailserver_ascii_name.py` (replaced by `files/misc/ascii_name.py`)
- check that Super-Linter is green after the latest fixes; the `ansible-lint` and Prettier results were fixed without being able to run them
- `README.md` still has to say that an explicit `name` is now converted to ASCII too (and kept as `name_input`), and describe the display name rules above
- the workflow only tests the username and address derivation, not the whole role; extend it step by step (for example a systemd-enabled AlmaLinux 8 container for the OS and LDAP parts)
- run the whole role on a test machine: nothing in the recent commits (`policy_uid`, `primary_mail`, usernames, addresses) has been executed against Kolab yet
- the built-in Cyrillic and Greek tables are a simple, readable scheme, not an official standard (for example ISO 9 or ELOT 743); check the results for your family's names
- users created by hand in the Kolab web admin follow `policy_uid`/`primary_mail`, and Kolab's own parser strips accents differently (it uses iconv transliteration and drops non-Latin letters), so check that both give identical names
- two users whose derived names become identical (for example two people called Anna in family mode, or `Kovács` and `Kovacs`) are not detected yet
- audit the remaining tasks (WireGuard, FTP, imapsync, backups, DKIM, DMARC) for assumptions about `user.name`, and read the `main` branch for comparison
- consider setting the OS account comment (GECOS) from the first name and surname
- add ansible-lint / Molecule scenarios and unit tests for `files/misc/ascii_name.py`
