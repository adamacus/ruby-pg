FROM amazonlinux:latest

# RUBY
RUN amazon-linux-extras install ruby2.6 -y
RUN gem install bundler --version '1.17.2'

# POSTGRES
RUN amazon-linux-extras install postgresql11 vim epel -y
RUN yum install -y postgresql-server postgresql-devel

USER postgres
RUN mkdir -p /var/lib/pgsql/data
RUN pg_ctl init -D /var/lib/pgsql/data
RUN /usr/bin/pg_ctl -D /var/lib/pgsql/data start
