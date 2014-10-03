#!/bin/sh

DOMAIN=rsr_jms
DOMAIN_HOME=/www/web/domains/$DOMAIN

case "$1" in

        'stop')
               $DOMAIN_HOME/bin/stopWebLogic.sh &
               ;;

        'start')
               $DOMAIN_HOME/nodemanager/AdminServer/startNodeManager.sh &
               $DOMAIN_HOME/bin/startWebLogic.sh &
               ;;
esac




