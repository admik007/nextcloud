FROM debian:buster

RUN echo "#Debian (10) Buster \n\
deb http://ftp.debian.sk/debian/ buster main contrib non-free \n\
deb-src http://ftp.debian.sk/debian/ buster main contrib non-free \n\
\n\
deb http://ftp.debian.sk/debian/ buster-updates main contrib non-free \n\
deb-src http://ftp.debian.sk/debian/ buster-updates main contrib non-free \n\
\n\
deb http://ftp.debian.sk/debian/ buster-proposed-updates main contrib non-free \n\
deb-src http://ftp.debian.sk/debian/ buster-proposed-updates main contrib non-free \n\
\n\
deb http://ftp.debian.sk/debian/ buster-backports main contrib non-free \n\
deb-src http://ftp.debian.sk/debian/ buster-backports main contrib non-free \n\
\n\
deb http://security.debian.org/ buster/updates main contrib \n\
deb-src http://security.debian.org/ buster/updates main contrib" > /etc/apt/sources.list

RUN apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get -y autoremove
RUN apt-get -y install git screen vim wget mc nmap 
RUN apt-get -y install apache2 php php-xml php-zip php-soap php-mbstring php-gd php-curl php-mysql php-pgsql default-mysql-server postgresql-11
RUN wget https://download.nextcloud.com/server/releases/nextcloud-18.0.3.tar.bz2 && mv nextcloud-18.0.3.tar.bz2 /var/www/html/ && cd /var/www/html/ && bunzip2 nextcloud-18.0.3.tar.bz2 && tar -xvf nextcloud-18.0.3.tar && mv nextcloud/* . && rm -fr nextcloud* && chown www-data. /var/www/html/ -R
RUN apt-get clean

ADD setup.sh /root/
RUN chmod 755 /root/setup.sh

VOLUME [ " /var/www/html/data " ]

RUN cp -pr /var/www/html /var/www/html-default && chown www-data. /var/www/html/data

CMD if [ -f /root/setup.sh]; then bash /root/setup.sh; fi && /etc/init.d/postgresql restart && /etc/init.d/mysql restart && /etc/init.d/apache2 restart && while true; do sleep 3600; done
