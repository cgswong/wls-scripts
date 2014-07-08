Move JMS messages from one queue (old) to another (new) queue. Queues can be remote.

Requirements
domain.properties - File containing domain and server details.

Usage
. ./setWLSEnv.sh
java weblogic.WLST move_messages.py
