###################################################################
# NAME: setCluster_SERVER_NAME.sh
# DESC: Sets custom managed cluster server settings. Created as
#       separate file for better provisioning and de-provisioning
#       control.
#
#       During startup this file is included in the startup sequence
#       (via setUserOverrides.sh) and any overrides defined take effect.
#       This file must be stored in the DOMAIN_HOME/bin directory.
#
# LOG:
# yyyy/mm/dd [name] [version]:[notes]
# 2014/10/01 cgwong v0.1.0: Initial template creation.                      
###################################################################

# Define specific variables
JMX_PORT=7003     ; export JMX_PORT
MS_MEM_SIZE="6G"  ; export MS_MEM_SIZE
