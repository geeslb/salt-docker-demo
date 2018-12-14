FROM centos/systemd

EXPOSE 8000
EXPOSE 10000


RUN curl -o /bootstrap -Ls https://bootstrap.saltstack.com
RUN bash /bootstrap -MPX -p salt-api -p pyOpenSSL -c /tmp

ADD master /etc/salt/master
ADD master-minion /etc/salt/minion
ADD master_minion.pem /etc/salt/pki/master.pem
ADD master_minion.pub /etc/salt/pki/master.pub
ADD master_minion.pem /etc/salt/pki/minion/minion.pem
ADD master_minion.pub /etc/salt/pki/minion/minion.pub
ADD master_minion.pub /etc/salt/pki/minion/minion_master.pub
ADD minion1.pub /etc/salt/pki/master/minions/minion1
ADD minion2.pub /etc/salt/pki/master/minions/minion2
ADD master_minion.pub /etc/salt/pki/master/minions/minion_master
#ADD webmin-1.900-1.noarch.rpm /root

RUN ln -sf /usr/lib/systemd/system/salt-api.service /etc/systemd/system/multi-user.target.wants/salt-api.service
RUN ln -sf /usr/lib/systemd/system/salt-master.service /etc/systemd/system/multi-user.target.wants/salt-master.service
RUN salt-run salt.cmd tls.create_self_signed_cert

RUN useradd -m saltdev
RUN echo saltdev | passwd --stdin saltdev

RUN echo 'tmpfs /run tmpfs rw,nosuid,nodev,mode=755 0 0' >> /etc/fstab
RUN chmod +x /etc/rc.d/rc.local
RUN yum -y install rsyslog wget anacron git python-pygit2 GitPython
RUN yum -y install perl perl-Net-SSLeay openssl perl-IO-Tty perl-Encode-Detect
#WORKDIR /srv/salt/formulas
#RUN git clone https://github.com/saltstack-formulas/molten-formula.git
WORKDIR /root
#RUN wget https://cfhcable.dl.sourceforge.net/project/webadmin/webmin/1.900/webmin-1.900-1.noarch.rpm
#RUN yum -y localinstall webmin-1.900-1.noarch.rpm
RUN echo 'SHELL=/bin/bash' > /etc/anacrontab
RUN echo 'PATH=/sbin:/bin:/usr/sbin:/usr/bin' >> /etc/anacrontab
RUN echo 'MAILTO=root' >> /etc/anacrontab
RUN echo '# anacron stuff' >> /etc/anacrontab
RUN echo '1 1 cnron.salt.j1 salt-key --accept-all -y' >> /etc/anacrontab
RUN echo '1 1 cnron.salt.j2 salt minion_master state.apply' >> /etc/anacrontab
#RUN echo '1 1 cnron.salt.j2 salt-call state.sls molten.full' >> /etc/anacrontab
RUN echo '1 4 cnron.salt.j2 salt "*" state.apply' >> /etc/anacrontab
RUN echo '/usr/sbin/anacron -s'>>/etc/rc.d/rc.local
RUN chmod +x /etc/rc.d/rc.local
