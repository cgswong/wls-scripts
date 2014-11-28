#!/bin/sh
#
# weblogic Oracle Weblogic start
#
# chkconfig: 345 85 15
# description: Oracle Weblogic service

### BEGIN INIT INFO
# Provides: 
# Required-Start: $nodemanager
# Required-Stop:
# Should-Start:
# Should-Stop:
# Default-Start: 3 4 5
# Default-Stop: 0 1 2 6
# Short-Description: Oracle Weblogic service.
# Description: Starts and stops Oracle Weblogic.
### END INIT INFO

 . /etc/rc.d/init.d/functions

# Your WLS home directory (where wlserver is)
export MW_HOME="/u01/app/oracle/middleware/Oracle_Home"
export BOOT_HOME="/u01/app/oracle/bootscripts"
export JAVA_HOME="/usr/java/latest"
DAEMON_USER="oracle"

source $MW_HOME/wlserver/server/bin/setWLSEnv.sh &gt; /dev/null
PROGRAM_START="$BOOT_HOME/startall.sh"
PROGRAM_STOP="$BOOT_HOME/stopall.sh"
SERVICE_NAME=`/bin/basename $0`
LOCKFILE="/var/lock/subsys/$SERVICE_NAME"
RETVAL=0

start() {
 echo -n $"Starting $SERVICE_NAME: "
 /bin/su $DAEMON_USER -c "$PROGRAM_START &amp;" RETVAL=$?
 echo [ $RETVAL -eq 0 ] &amp;&amp; touch $LOCKFILE
}

 stop() {
 echo -n $"Stopping $SERVICE_NAME: "
 /bin/su $DAEMON_USER -c "$PROGRAM_STOP &amp;" RETVAL=$?
 [ $RETVAL -eq 0 ] &amp;&amp; rm -f $LOCKFILE
 }

 restart() {
 stop
 sleep 10
 start
}

case "$1" in
 start)
        start
        ;;
 stop)
        stop
        ;;
 restart|force-reload|reload)
        restart
        ;;
 *)
        echo $"Usage: $0 {start|stop|restart}"
esac

exit 1
