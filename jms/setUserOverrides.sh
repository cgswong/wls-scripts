###################################################################
# NAME: setUserOverrides.sh                                       #
# DESC: Sets custom server startup parameters that apply to all   #
#       servers in a domain. For example, custom libraries to     #
#       CLASSPATH, additional java command line options for       #
#       running servers, or additional environment variables.     #
#       All customizations are preserved during domain upgrade    #
#       and can be carried over to remove servers via pack and    #
#       unpack commands. During startup this file is included in  #
#       the startup sequence (via setDomainEnv.sh) and any        #
#       overrides defined take effect. This file must be stored in#
#       the DOMAIN_HOME/bin directory.                            #
#                                                                 #
# LOG:                                                            #
# yyyy/mm/dd [name] [version]:[notes]                             #
# 2014/09/04 cgwong v0.1.0: Initial creation                      #
# 2014/09/18 cgwong v0.1.1: Added "-XX:-UseGCOverheadLimit" flag  #
#            to fix JVM OOM error.                                #
# 2014/09/18 cgwong v0.2.0: Switched to Garbage-First or G1       #
#            collector. Added additional GC flags for diagnostics #
#            and logging.                                         #
###################################################################

# Custom variables
DIAG_BASE=/www/web/weblogs/${DOMAIN_HOME}
SERVER_NAME=<server_name>

# Enabled monitoring, unlocking commercial features
MONITOR_ARGS="-XX:+UnlockCommercialFeatures -XX:+FlightRecorder"

# Admin and managed server memory settings
AS_MEM_SIZE="4G"
MS_MEM_SIZE="8G"
AS_MEM_ARGS="-Xms${AS_MEM_SIZE} -Xmx${AS_MEM_SIZE}"
MS_MEM_ARGS="-Xms${MS_MEM_SIZE} -Xmx${MS_MEM_SIZE}"
STD_MEM_ARGS="-Xss1024k"
MEM_PERM_SIZE="-XX:PermSize=128m"
MEM_MAX_PERM_SIZE="-XX:MaxPermSize=256m"
MEM_DEV_ARGS="-XX:CompileThreshold=8000 ${MEM_PERM_SIZE} ${MEM_MAX_PERM_SIZE}"

# Garbage Collection related settings
##GC_ARGS="-verbose:gc -XX:-UseGCOverheadLimit-XX:+HeapDumpOnOutOfMemoryError -XX:+PrintGCDetails -XX:+PrintGCTimeStamps"
GC_ARGS="-verbose:gc -XX:+UseG1GC -XX:+PrintHeapAtGC -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=${DIAG_BASE}/${SERVER_NAME} -Xloggc:${DIAG_BASE}/${SERVER_NAME}/gc-$$.log -XX:+UseGCLogFileRotation -XX:NumberOfGClogFiles=5 -XX:GCLogFileSize=10240K"

# Custom arguments
CUST_ARGS="-XX:+UseTLAB"

##JAVA_OPTIONS="${STD_MEM_ARGS} ${AS_MEM_ARGS} ${MEM_DEV_ARGS} ${MONITOR_ARGS} ${GC_ARGS} ${CUST_ARGS} ${JAVA_OPTIONS}"

if [ "${ADMIN_URL}" = "" ] ; then     # Admin Server
	USER_MEM_ARGS="${STD_MEM_ARGS} ${AS_MEM_ARGS} ${MEM_DEV_ARGS} ${MONITOR_ARGS} ${GC_ARGS} ${CUST_ARGS}"
else                                  # Managed Servers
	USER_MEM_ARGS="${STD_MEM_ARGS} ${MS_MEM_ARGS} ${MEM_DEV_ARGS} ${MONITOR_ARGS} ${GC_ARGS} ${CUST_ARGS}"
fi
export USER_MEM_ARGS

# Set DERBY_FLAG
DERBY_FLAG="false" ; export DERBY_FLAG

# Java VM to server
JAVA_VM="-server" ; export JAVA_VM

# -- END -- #