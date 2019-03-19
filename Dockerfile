FROM ubuntu:16.04
LABEL maitainer="Pascal Véron veron@univ-tln.fr"

ENV DEBIAN_FRONTEND noninteractive
ENV MOODLE_DB="moodle"
ENV MYSQL_PASSWORD=';mysql;'
ENV MOODLE_PASSWORD=';M00dle;'
ENV SSH_PASSWORD=';g0ssh;'

RUN apt-get -y update && \\
apt-get -y upgrade && \\
apt-get -y install mysql-server mysql-client pwgen python-setuptools curl git unzip && \\
apt-get -y install apache2 php php-gd libapache2-mod-php postfix wget php-pgsql vim curl libcurl3 libcurl3-dev php-curl php-xmlrpc php-intl php-mysql && \\
apt-get -y install openssh-server && \\
apt-get -y install php-xml && \\
apt-get -y install php-zip && \\
apt-get -y install php-mbstring && \\
apt-get -y install php-soap && \\
mkdir -p /var/run/sshd && \\
sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf 

ADD ./start.sh /start.sh
ADD ./stop.sh /stop.sh
ADD ./foreground.sh /etc/apache2/foreground.sh
ADD https://download.moodle.org/download.php/direct/stable35/moodle-latest-35.tgz /var/www/moodle-latest.tgz
RUN cd /var/www && tar zxvf moodle-latest.tgz && mv /var/www/moodle /var/www/html && \\
cd /var/www/html/moodle && \\
git clone git://github.com/trampgeek/moodle-qtype_coderunner.git question/type/coderunner && \\
git clone git://github.com/trampgeek/moodle-qbehaviour_adaptive_adapted_for_coderunner.git question/behaviour/adaptive_adapted_for_coderunner && \\
chown -R www-data:www-data /var/www/html/moodle && \\
mkdir /var/moodledata && \\
chown -R www-data:www-data /var/moodledata && chmod 777 /var/moodledata && \\
chmod 755 /start.sh /stop.sh /etc/apache2/foreground.sh && \\
mkdir -p /var/run/mysqld && \\
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \\
rm -rf /var/lib/mysql/* && \\
echo root:$SSH_PASSWORD | chpasswd && \\
sed -i 's/PermitRootLogin .*$/PermitRootLogin Yes/' /etc/ssh/sshd_config &&\\
usermod -d /var/lib/mysql mysql

EXPOSE 22 80
ENTRYPOINT ["/bin/bash"]
