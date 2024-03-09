# TODO

List of things not implemented yet, but planned

* create not-yet-exising-in-OS users in LDAP
* set sudo rules in LDAP
* if possible, confugire `adduser` and so to work on LDAP
* authenticate Apache admin sites via LDAP
* confirm if PostfixAdmin is needed at all
* let DynDNS (PowerAdmin) authenticate via both LDAP and Apache native authentication
* restrict incoming IP addresses of `/kolab-wemadmin` and the Kolab API by modifying **or even better, _overriding_** `/etc/httpd/conf.d/kolab-webadmin.conf`
* set up sieves for Cyrus
* set up SSL for Cyrus
* set up DKIM for Cyrus
* set up DMARC for Cyrus
* confirm Kolab- and Cyrus-related backups working
