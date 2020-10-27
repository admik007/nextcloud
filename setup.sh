#!/bin/bash
set -e
set -x
set -u

mkdir -p /var/www/html

if [ ! -f /var/www/html/index.php ]; then
  rsync -avHS /var/www/html-default/ /var/www/html/
fi

/etc/init.d/postgresql restart
/etc/init.d/mysql restart
/etc/init.d/apache2 restart
