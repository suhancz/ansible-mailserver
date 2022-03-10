ansible-mailserver
==================

Mailserver suite on RPM-based distros

Role Variables
--------------

    mailserver_hostname # FQDN for the mail server
    mailserver_domain # primary domain name
    mailserver_admin_user # user to administer the mail server
    users:
      - name
        password
        aliases:
          - alias@domain.com
          - otheralias@otherdomain.org
    production: yes # boolean if we use production Let's Encrypt certificates
    mariadb_backup_path # path to the MariaDB backups
    ldap_backup_path # path to the tarball containing LDAP backups
    opendkim_backup_path # path to the tarball containing OpenDKIM backups
    opendmarc_backup_path # path to the tarball containing OpenDMARC backups
    vsftpd_backup_path # path to the tarball containing backups of user home FTP directory contents
    ssl_backup_path # path to the tarball containing SSL-related backups

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
