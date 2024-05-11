#!/bin/bash

set -euxo pipefail

AWL_REF=r0.64
DAVICAL_REF=r1.1.12

dnf -y install 'dnf-command(config-manager)'
dnf config-manager --set-enabled powertools

# CentOS image comes cleaned of locales, reinstall them
dnf -y reinstall glibc-common
dnf -y install epel-release
# postgresql package is installed because of psql client
# (it doesn't install the server)
dnf -y install gettext git httpd perl-YAML perl-YAML-LibYAML perl-DBD-Pg perl-DBI php php-curl php-ldap php-pgsql php-xml postgresql
dnf clean all

# Use prefork for php instead of the default event MPM
cat > /etc/httpd/conf.modules.d/00-mpm.conf <<EOF
LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
EOF

pushd /var/www/html
git clone --branch $AWL_REF https://gitlab.com/davical-project/awl.git
git clone --branch $DAVICAL_REF https://gitlab.com/davical-project/davical.git
popd
