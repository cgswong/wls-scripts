# #############################################################################
# NAME: jms_monitor.py
# DESC: WLST to monitor JMS message queues.
#
# USAGE: Certain environment variables must be set before running the script:
#        WL_URL --> URL for the Administration Server
#        WL_ADM --> Administrator name
#        WL_PWD --> Administrator password
#
# LOG:
# yyyy/mm/dd [user] [version]: [notes]
# 2014/09/25 cgwong [v0.1.0]: Initial creation
# #############################################################################

#Import necessary classes/interfaces
from weblogic.jms.extensions import JMSMessageInfo
from javax.jms import TextMessage
from javax.jms import ObjectMessage

# Read values from OS environment (better security)
url = os.getenv('WL_URL');
username = os.getenv('WL_ADM');
password = os.getenv('WL_PWD');

#Define constants
jmsservername='test-jms-server'
jmsmodulename='sc1_jms-module'
jmsdestname='test-queue'

#Connect
connect(username,password,url)
servers = domainRuntimeService.getServerRuntimes();
if (len(servers) > 0):
    for server in servers:
		jmsRuntime = server.getJMSRuntime();
		jmsServers = jmsRuntime.getJMSServers();
		for jmsServer in jmsServers:
			destinations = jmsServer.getDestinations();
			for destination in destinations:
				print '  BytesCurrentCount           ' ,  destination.getBytesCurrentCount()
				print '  BytesHighCount              ' ,  destination.getBytesHighCount()
				print '  BytesPendingCount           ' ,  destination.getBytesPendingCount()
				print '  BytesReceivedCount          ' ,  destination.getBytesReceivedCount()
				print '  ConsumersCurrentCount       ' ,  destination.getConsumersCurrentCount()
				print '  ConsumersHighCount          ' ,  destination.getConsumersHighCount()
				print '  ConsumersTotalCount         ' ,  destination.getConsumersTotalCount()
				print '  ConsumptionPausedState      ' ,  destination.getConsumptionPausedState()
				print '  '
				print '  DestinationInfo             ' ,  destination.getDestinationInfo()
				print '  '
				print '  DestinationType             ' ,  destination.getDestinationType()
				print '  MessagesCurrentCount        ' ,  destination.getMessagesCurrentCount()
				print '  MessagesDeletedCurrentCount ' ,  destination.getMessagesDeletedCurrentCount()
				print '  MessagesHighCount           ' ,  destination.getMessagesHighCount()
				print '  MessagesMovedCurrentCount   ' ,  destination.getMessagesMovedCurrentCount()
				print '  MessagesPendingCount        ' ,  destination.getMessagesPendingCount()
				print '  MessagesReceivedCount       ' ,  destination.getMessagesReceivedCount()
				print '  MessagesThresholdTime       ' ,  destination.getMessagesThresholdTime()
				print '  Parent                      ' ,  destination.getParent()
				print '  Paused                      ' ,  destination.isPaused()
				print '  ProductionPaused            ' ,  destination.isProductionPaused()
				print '  ProductionPausedState       ' ,  destination.getProductionPausedState()
				print '  State                       ' ,  destination.getState()
				print '  Type                        ' ,  destination.getType()

#Disconnect & Exit
disconnect()
exit()
