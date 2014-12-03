#!/bin/sh

case "$1" in
        'stop')
                cd /www/web/bin
                # stop all Apaches 

                /www/apache2.2.21/bin/apachectl -f /www/apache2.2.21/conf/httpd-Commercial.conf -k stop
                /www/apache2.2.21/bin/apachectl -f /www/apache2.2.21/conf/httpd-pipelinemetrics.conf -k stop
                /www/apache2.2.21/bin/apachectl -f /www/apache2.2.21/conf/httpd-SOA.conf -k stop
                /www/apache2.2.21/bin/apachectl -f /www/apache2.2.21/conf/httpd-TPS.conf -k stop
                /www/apache2.2.21/bin/apachectl -f /www/apache2.2.21/conf/httpd-WL.conf -k stop
                ;;

        'start')
                cd /www/web/bin
                # start all Apaches

                /www/apache2.2.21/bin/apachectl -f /www/apache2.2.21/conf/httpd-Commercial.conf -k start
                /www/apache2.2.21/bin/apachectl -f /www/apache2.2.21/conf/httpd-pipelinemetrics.conf -k start
                /www/apache2.2.21/bin/apachectl -f /www/apache2.2.21/conf/httpd-SOA.conf -k start
                /www/apache2.2.21/bin/apachectl -f /www/apache2.2.21/conf/httpd-TPS.conf -k start
                /www/apache2.2.21/bin/apachectl -f /www/apache2.2.21/conf/httpd-WL.conf -k start
                ;;

esac


