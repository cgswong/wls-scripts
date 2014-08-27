# Introduction
Move WebLogic JMS messages from one queue (old) to another (new) queue which can be local or remote. To move multiple queues you can use a wrapper script or feel free to modify the code for improved functionality.

## Version
Current version: 1.0.0

# Requirements
domain.properties - File containing domain and server details.

# Usage
Set the environment:

```
. ./setWLSEnv.sh
```

Run the script using WLST:
```
java weblogic.WLST move_messages.py
```
