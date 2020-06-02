FROM amazonlinux:latest
RUN amazon-linux-extras -y install postgresql11 
RUN yum install -y postgresql-server postgresql-devel
RUN /usr/bin/postgresql-setup --initdb
RUN systemctl enable postgresql
RUN systemctl start postgresql
