#!/bin/sh

ps -ef | grep weblogic.Server | grep -v grep | awk -F.-Dweblogic.Name= '{print $2}' | cut -f 1 -d " " > running_servers.out
