#!/bin/bash

set -euxo pipefail

AWL_REF=r0.62
DAVICAL_REF=r1.1.10

# CentOS image comes cleaned of locales, reinstall them
yum -y reinstall glibc-common
yum -y install epel-release
# postgresql package is installed because of psql client
# (it doesn't # install the server)
yum -y install gettext git httpd perl-YAML perl-YAML-LibYAML perl-DBD-Pg perl-DBI php php-curl php-imap php-ldap php-pgsql php-xml php-pear-Net-Curl postgresql
yum clean all

pushd /var/www/html
git clone --branch $AWL_REF https://gitlab.com/davical-project/awl.git
git clone --branch $DAVICAL_REF https://gitlab.com/davical-project/davical.git
popd
