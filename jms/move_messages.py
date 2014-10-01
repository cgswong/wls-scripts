# ############################################################################
# NAME : move_messages.py 
#
# DESC.: Move JMS messages from one queue (old) to another (new) queue.
#        Queues can be remote.
#
# REQ. : domain.properties - File containing domain and server details.
#
# USAGE:
#       . $WL_HOME/server/bin./setWLSEnv.sh
#       java weblogic.WLST move_messages.py
#
# LOG  :
# yyyy/mm/dd [user]: [version] [comments]
# 2014/07/01 cgwong: v1.0.0 Initial creation
# ############################################################################

from java.io import FileInputStream
import java.lang
import os
import string

propInputStream = FileInputStream("move_messages.properties")
configProps = Properties()
configProps.load(propInputStream)

serverUrl = configProps.get("server.url")
Username = configProps.get("username")
Password = configProps.get("password")

systemModuleName = configProps.get("system.module.name")

newserverUrl = configProps.get("new.server.url")
newsystemModuleName = configProps.get("new.system.module.name")
newTargetServerName = configProps.get("new.target.server.name")
newJmsServerName = configProps.get("new.jms.server.name")
newQueueName = configProps.get("new.queue.name")

oldserverUrl = configProps.get("old.server.url")
oldsystemModuleName = configProps.get("old.system.module.name")
oldTargetServerName = configProps.get("old.target.server.name")
oldJmsServerName = configProps.get("old.jms.server.name")
oldQueueName = configProps.get("old.queue.name")

Username = configProps.get("username")
Password = configProps.get("password")

# Connecting to the Destination
connect(Username,Password,newserverUrl)
serverRuntime()

print 'Getting the target...'
cd('/JMSRuntime/'+newTargetServerName+'.jms/JMSServers/'+newJmsServerName+'/Destinations/'+newsystemModuleName +'!'+ newQueueName)
target = cmo.getDestinationInfo()
print 'Got the target...'

disconnect()
print ''

# Connecting to the Source
connect(Username,Password,oldserverUrl)
serverRuntime()
cd('/JMSRuntime/'+oldTargetServerName+'.jms/JMSServers/'+oldJmsServerName+'/Destinations/'+oldsystemModuleName +'!'+ oldQueueName)

print 'Moving the messages to the new traget...'
cmo.moveMessages('',target)
print 'Messages have been moved to the traget successfully !!!'

print '===================================================================================='
print 'Messages from queue: "'+oldQueueName+'" have been moved to the new queue: "'+newQueueName+'" successfully !!!'
print '====================================================================================
