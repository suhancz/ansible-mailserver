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
        old_imap_mail: # connection info to the old IMAP address to sync
          host # hostname or IP address of the remote mail server
          user # login user to the remote mail server
          password # password to log in to the remote mail server
          sync: yes # indicates if mailbox should be daily synced after the initial copy
        imap_dedup # boolean if e-mails should be deduplicated daily
        vpn: # WireGuard setup - if a user doesn't have VPN info defined, a client with their name will be generated by default
          - name: client1 # name metadata to identify the VPN client - this should be unique among all users
            privatekey: # WireGuard private key for the client
            publickey: # WireGuard public key for the client
            psk: # WireGuard pre-shared key for the client
          - name: client2 # WireGuard clients with only `name` values will have their keys generated at install time
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
    pdns_backup_path # path to the tarball containing PowerDNS backups
    wg_vpn_backup_path # path to the tarball containing WireGuard backups
    wireguard: # wireguard configuration for admin access
      config_dir: # directory on the server to deploy WireGuard configuration to
      ipv4_pool: # CIDR of the IPv4 pool of the clients
      ipv6_pool: # CIDR of the IPv6 pool of the clients
      nameservers: # list of DNS servers to use for the VPN
      listen_port: # Wireguard server listen address
      allowed_ips: # list of IP addresses to reach via VPN
      keepalive: # VPN keepalive in seconds
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

External sources
----------------

Inspiration for the AIDE steps taken from [Andrew J. Huffman's Ansible role](https://github.com/ahuffman/ansible-aide)
