# Migration: Horde to Kolab in place, redirects

[Index](../TODO.md)

Option such as `migrate_from_horde: true`: fetch mail, calendars, contacts, tasks and the rest from Horde, remove Horde (and Dovecot), deploy Kolab, upload the data to the matching user. No remote machine (the owner's `imapsync` start needs a second IMAP server).

- [ ] full `mysqldump` of the `horde` database before removal
- [ ] mail: read Dovecot Maildirs `/var/vmail/<domain>/<user>/Maildir` in place (never deleted), upload by IMAP `APPEND` into the user's Cyrus mailbox (flags from filenames, original dates, folders mapped to the Cyrus separator and special folders such as `Spam`); keep `imapsync` tasks for a remote server
- [ ] calendars, tasks, contacts: export from Horde by CalDAV and CardDAV with each user's password into `/var/backups/horde-migration/<user>/`, `PUT` into the user's Kolab CalDAV and CardDAV (iRony)
- [ ] notes, wiki pages, Ingo filters (sieve): copied to the backup directory, not imported; decide later
- [ ] every step repeatable and safe (skip imported items, never delete the backup, stop before removing Horde if an export failed)
- [ ] unit-test the Maildir and DAV code in CI; the full migration needs a real Horde, so untested until run on a copy of the real server
- [ ] redirect old web URLs: after the switch, old Horde URLs (web interface and sub-applications, old hostnames and paths) redirect to the matching Kolab page (Roundcube, web admin), unknown old paths land on the Kolab login; collect real URLs from the Apache config of the Horde setup (`templates/httpd`, Horde virtual host on `main`) and the access log first
- [ ] redirect old client URLs: CalDAV, CardDAV, push (ActiveSync and similar) and other stored protocol URLs keep working, redirected or served by Kolab equivalents (iRony, Kolab ActiveSync); many DAV clients ignore redirects on `PROPFIND`, so serve in place or add `/.well-known/caldav` and `/.well-known/carddav` redirects; collect exact old paths first
- [ ] CI test for both redirect items: test the generated web config and, after the full deployment, `curl` a list of old Horde URLs (web, CalDAV, CardDAV, push) checking status and `Location` against the expected Kolab URL; the list is test data
