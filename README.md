ansible-mailserver
==================

Postifx and Dovecot on RPM-based distros


Role Variables
--------------

    mailserver_hostname
    mailserver_domain
    mailserver_admin_email
    mailserver_admin_user
    users:
      - name
        password
    postfixadmin_password
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
