FROM amazonlinux:latest

# GIT
RUN yum install -y git

# RUBY
RUN yum install -y git gcc make readline-devel openssl-devel tar bzip2 gcc-c++ libxml2-devel libcurl_devel

RUN git clone git://github.com/rbenv/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN source ~/.bashrc
RUN git clone git://github.com/rbenv/ruby-build.git /tmp/ruby-build
RUN /tmp/ruby-build/install.sh
RUN ruby-build 2.6.6 ~/ruby-2.6.6
ENV PATH="~/ruby-2.6.6/bin:${PATH}"
RUN ruby --version

# POSTGRES
RUN amazon-linux-extras install postgresql11 vim epel -y
RUN yum install -y postgresql-server postgresql-devel

USER postgres
RUN mkdir -p /var/lib/pgsql/data
RUN pg_ctl init -D /var/lib/pgsql/data
RUN /usr/bin/pg_ctl -D /var/lib/pgsql/data start

