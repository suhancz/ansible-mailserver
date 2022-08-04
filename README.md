ansible-mailserver
==================

Mailserver suite on RPM-based distros

Role Variables
--------------

    mailserver_hostname # hostname for the mail server
    mailserver_domain # primary domain name
    mailserver_admin_user # user to administer the mail server
    users:
      - name
        password
        aliases:
          - alias@domain.com
          - otheralias@otherdomain.org
        old_imap_mail: # Dovecot imapc configuration values
          host
          ssl
          ssl_verify
          port
          user
          password
          sync: yes # this boolean is not a default Dovecot thing. indicates if mailbox should be daily synced after the initial copy
    custom_domains: # list of domains to also configure the mailserver for
      - domain.com
      - otherdomain.org
    undeliverable_exceptions: # list of domains from where mail always should be delivered
      - domain.com
      - otherdomain.org
    production: yes # boolean if we use production Let's Encrypt certificates
    public_dns: yes # boolean if the server also should act as a public DNS serving all the relevant records
    reset: no # boolean if mail data found on the server should be overwritten
    forgotten_mariadb_root_password: yes # boolean if MariaDB root password should be reset
    mariadb_backup_path # path to the MariaDB backups
    ldap_backup_path # path to the tarball containing LDAP backups
    opendkim_backup_path # path to the tarball containing OpenDKIM backups
    opendmarc_backup_path # path to the tarball containing OpenDMARC backups
    vsftpd_backup_path # path to the tarball containing backups of user home FTP directory contents
    ssl_backup_path # path to the tarball containing SSL-related backups
    horde_backup_path # path to the tarball containing Horde backups
    dovecot_backup_path # path to the tarball containing Dovecot backups
    postfix_backup_path # path to the tarball containing Postfix backups
    pdns_backup_path # path to the tarball containing DNSMASQ backups
    wireguard: # wireguard configuration for admin access
      config_dir: # directory on the server to deploy WireGuard configuration to
      server:
        mtu # server-side MTU
        cidr # VPN range in CIDR notation
        address # server listen address
        lport # listening port
        dns_ip # DNS to provide for the clients
      clients: # config for the clients
        client1:
          cidr # client address on the VPN in CIDR notation
          keepalive # connection keepalive in seconds
          lport # listening port
          mtu # client-side MTU
    httpd_pam_deny_users: # list of users who shouldn't authenticate against HTTPD using PAM

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
        - ansible-mailserver

License
-------

GPL

Author Information
------------------

Akos Balla
