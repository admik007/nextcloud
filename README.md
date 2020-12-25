# Next Cloud based on Debian10

### Create new database and user with random 16 char password
echo "CREATE DATABASE nextcloud;"  | mysql -u root
echo "use mysql;"  | mysql -u root
PWS=\`pwgen 16\`; echo ${PWS}; echo "GRANT ALL ON nextcloud.* to admin@localhost IDENTIFIED BY '${PWS}';"  | mysql -u root
echo "FLUSH PRIVILEGES;"  | mysql -u root

### In case of some error
echo "delete from db where User='admin';" | mysql -u root
echo "delete from user where User='admin';" | mysql -u root

### Rescan files for all users
sudo -u www-data php /var/www/html/occ files:scan --all

### In case of rescan error
-DELETE FROM oc_file_locks WHERE 1;
config/config.php:
'filelocking.enabled' => false,
