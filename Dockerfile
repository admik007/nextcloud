FROM debian:bullseye

RUN echo "# Debian 11.0 (bullseye) \n\
deb http://security.debian.org/debian-security bullseye-security main contrib non-free \n\
deb-src http://security.debian.org/debian-security bullseye-security main contrib non-free\n\
deb http://ftp.debian.sk/debian bullseye main contrib non-free\n\
deb-src http://ftp.debian.sk/debian bullseye main contrib non-free\n\
deb http://ftp.debian.sk/debian bullseye-updates main contrib non-free\n\
deb-src http://ftp.debian.sk/debian bullseye-updates main contrib non-free\n\
deb http://ftp.debian.sk/debian bullseye-proposed-updates main contrib non-free\n\
deb-src http://ftp.debian.sk/debian bullseye-proposed-updates main contrib non-free\n\
deb http://ftp.debian.sk/debian bullseye-backports main contrib non-free\n\
deb-src http://ftp.debian.sk/debian bullseye-backports main contrib non-free" > /etc/apt/sources.list

RUN apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get -y autoremove
RUN apt-get -y install git screen wget vim mc nmap iptraf apache2 php php-zip php-xml php-gd php-curl php-mysql php-mbstring default-mysql-server unzip
RUN wget https://download.nextcloud.com/server/releases/nextcloud-25.0.3.zip /var/www/html/ && cd /var/www/html/ && unzip nextcloud-25.0.3.zip && mv nextcloud/* . && rm -fr nextcloud* && chown www-data. /var/www/html/ -R

ADD setup.sh /root/
RUN chmod 755 /root/setup.sh

VOLUME [ " /var/www/html/data " ]

ADD mysql_setup.txt /root/mysql_setup.txt
ADD entrypoint.sh /root/entrypoint.sh
RUN chmod 755 /root/entrypoint.sh

CMD /root/entrypoint.sh
