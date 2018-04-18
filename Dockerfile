FROM centos:centos7

MAINTAINER zhoupx

RUN yum -y install wget && \
    wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && \
    yum clean all && \
    yum -y install openssh-server openssh-clients bzip2
RUN mkdir -p /root/.ssh && \
    sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd && \
    ssh-keygen -t dsa  -f  /etc/ssh/ssh_host_dsa_key  && \
    ssh-keygen -t rsa  -f  /etc/ssh/ssh_host_rsa_key

ADD authorized_keys /root/.ssh/authorized_keys
ADD run.sh /run.sh
RUN chmod 755 /run.sh && \
    echo 'root:123123' |chpasswd

EXPOSE 22

CMD ["/run.sh"]