FROM quay.io/almalinuxorg/8-init
ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in ; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done);

RUN rm -rf /lib/systemd/system/multi-user.target.wants/ \
&& rm -rf /etc/systemd/system/.wants/ \
&& rm -rf /lib/systemd/system/local-fs.target.wants/ \
&& rm -f /lib/systemd/system/sockets.target.wants/udev \
&& rm -f /lib/systemd/system/sockets.target.wants/initctl \
&& rm -rf /lib/systemd/system/basic.target.wants/ \
&& rm -f /lib/systemd/system/anaconda.target.wants/*

RUN dnf -y install dnf-plugin-config-manager epel-release \
&& dnf config-manager --set-enabled powertools \
&& rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8 \
&& dnf module enable -y 389-ds:1.4/default \
&& dnf module enable -y mariadb:10.3 \
&& rpm --import https://mirror.apheleia-it.ch/repos/Kolab:/16/key.asc \
&& rpm -Uvh https://mirror.apheleia-it.ch/repos/Kolab:/16/kolab-16-for-el8.rpm \
&& dnf update --allowerasing -y \
&& dnf -y install kolab
VOLUME [ “/sys/fs/cgroup” ]
CMD ["/usr/sbin/init"]
