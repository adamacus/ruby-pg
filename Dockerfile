FROM amazonlinux:latest

# GIT
RUN yum install -y git

# RUBY
RUN yum install -y gcc make readline-devel openssl-devel tar bzip2 gcc-c++ libxml2-devel libcurl libcurl-devel

RUN git clone git://github.com/rbenv/ruby-build.git /tmp/ruby-build
RUN /tmp/ruby-build/install.sh
RUN ruby-build 2.6.6 ~/ruby-2.6.6
ENV PATH="~/ruby-2.6.6/bin:${PATH}"
RUN ruby --version

# NODE
RUN curl -O https://nodejs.org/download/release/v10.13.0/node-v10.13.0-linux-x64.tar.gz
RUN tar xzf node-v10.13.0-linux-x64.tar.gz -C ~
ENV PATH="~/node-v10.13.0-linux-x64/bin:${PATH}"
RUN ln -s /root/node-v10.13.0-linux-x64/bin/node /usr/local/bin/node
RUN npm install yarn -g

# REDIS
RUN amazon-linux-extras install redis4.0 -y

# CHROME/CHROMEDRIVER
RUN curl -O https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
RUN yum install -y ./google-chrome-stable_current_x86_64.rpm
RUN yum install -y unzip
RUN curl -O https://chromedriver.storage.googleapis.com/`curl -sS https://chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip -d /usr/local/bin

# pdftk
RUN yum -y localinstall https://protext-installers.s3.amazonaws.com/pdftk-2.02-1.el7.x86_64.rpm

# POSTGRES
RUN amazon-linux-extras install postgresql11 vim epel -y
RUN yum install -y postgresql-server postgresql-devel postgresql-contrib

USER postgres
RUN mkdir -p /var/lib/pgsql/data
RUN pg_ctl init -D /var/lib/pgsql/data -o "-E=UTF8"
RUN sed -i  '/^local all all peer/ s/peer/trust/' /var/lib/pgsql/data/pg_hba.conf

USER root
