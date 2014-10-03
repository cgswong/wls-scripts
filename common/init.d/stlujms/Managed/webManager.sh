#!/bin/sh

C=`hostname | cut -c 8`

case "$C" in
          'r')
          DOMAIN=rsr_jms
          ;;
          'g')
          DOMAIN=gbo_jms
          ;;
          'i')
          DOMAIN=ifs_jms
          ;;
esac

DOMAIN_HOME=/www/web/domains/$DOMAIN

case "$1" in

        'stop')
               # STOP MANAGED SERVERS
               for i in `cat /www/web/bin/running_servers.out`               
               do
               $DOMAIN_HOME/bin/$i.sh stop
               done
               ;;

        'start')
               # START NODE MANAGER
               $DOMAIN_HOME/nodemanager/ms_c1_`hostname | cut -c 12-13`/startNodeManager.sh &
               # START MANAGED SERVERS
               for i in `cat /www/web/bin/running_servers.out`
               do
               $DOMAIN_HOME/bin/$i.sh start
               sleep 120
               done
               ;;
esac




