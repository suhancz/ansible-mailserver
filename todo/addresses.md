# Addresses: address scheme and username leftovers

[Index](../TODO.md)

## Email address scheme

Goal: users get `givenname.surname@domain`; family domains `givenname@surname-domain`; optional preferred username (for example `sha@suhan.cz`); administrator can add any alias; optional display name. Display name per address: if the local part contains a word of the first name or surname (plain Latin comparison), the official full name in Unicode (`Akos Balla` for `akos@...`), else the nickname (`suhanc` for `sha@...`). Nickname: optional `display_name`, else explicit `name` as written, else official name. User-level `display_name` is the primary address's.

- [x] `mail_domains` (domain, style, optional family surname) and generation of `primary_address`, `generated_aliases`, `all_addresses`, `address_display_names`, `display_name` in `tasks/misc/generate_addresses.yml`; CI-tested with the owner's example; in `README.md`
- [ ] write to LDAP: `mail` = primary, `alias` = all (`tasks/kolab/add_kolab_user.yml`, `tasks/ldap/convert_user_to_ldif.yml`); `displayName` already from `display_name`
- [ ] Roundcube: one identity per address with its display name from `address_display_names` (LDAP holds one display name); check how Kolab Roundcube plugins build identities from the LDAP `alias` attribute
- [ ] Postfix: map every alias to the primary address (`tasks/mail/user_mail_alias.yml`); stop the wildcard `@custom-domain` mapping to the main domain when `mail_domains` is set
- [ ] Kolab recipient policy `primary_mail` per domain style (users created in the web admin) instead of global `family_mode`
- [ ] allow sending from every own address (sender login maps)
- [ ] DNS records, certificates, DKIM, DMARC for all `mail_domains` (`custom_domains` is derived from them)
- [ ] detect addresses belonging to two users (for example the same `givenname@family-domain`)
- [ ] administrator aliases that do not look like names (for example `info@`) get the nickname as display name; decide if wanted

## Leftovers from the username work

- [x] username and address tests passed in CI (5172692, `ansible-core` 2.21.6, Python 3.12)
- [ ] run the whole role on a test machine or in a container: nothing recent (`policy_uid`, `primary_mail`, usernames, addresses) ran against Kolab (the full deployment, request 2, last)
- [ ] built-in Cyrillic and Greek tables are a simple scheme, not ISO 9 or ELOT 743; check your family's names
- [ ] users created in the Kolab web admin follow `policy_uid` and `primary_mail`; Kolab's parser strips accents differently (iconv transliteration, drops non-Latin letters); check both give identical names
- [ ] derived names that become identical (two Annas in family mode, `Kovacs` with and without the accent) are not detected
- [ ] audit WireGuard, FTP, imapsync, backups, DKIM, DMARC for assumptions about `user.name`; compare with `main`
- [ ] consider setting the OS account comment (GECOS) from first name and surname
