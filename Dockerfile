FROM amazonlinux:latest

# POSTGRES
RUN amazon-linux-extras install postgresql11 -y
RUN yum install -y postgresql-server postgresql-devel
RUN /usr/bin/postgresql-setup --initdb
RUN systemctl enable postgresql
RUN systemctl start postgresql

# RUBY
RUN amazon-linux-extras install ruby2.6 -y
