FROM amazonlinux:latest

# RUBY
RUN amazon-linux-extras install ruby2.6 -y
RUN gem install bundler --version '1.17.2'

# POSTGRES
RUN amazon-linux-extras install postgresql11 vim epel -y
RUN yum install -y postgresql-server postgresql-devel
RUN /usr/bin/postgresql-setup --initdb
RUN systemctl enable postgresql
RUN systemctl start postgresql
