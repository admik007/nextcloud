#Next Cloud based on Debian10


echo "CREATE DATABASE nextcloud;"  | mysql -u root

echo "use mysql;"  | mysql -u root

echo "GRANT ALL ON nextcloud.* to admin@localhost IDENTIFIED BY 'admin';"  | mysql -u root

echo "FLUSH PRIVILEGES;"  | mysql -u root

sudo -u www-data php /var/www/html/occ files:scan --all
