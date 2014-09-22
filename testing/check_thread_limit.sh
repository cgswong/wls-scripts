#!/bin/ksh
######################################################################
# NAME: check_thread_limit.sh                                            
# DESC: Checks thread limit for JDK.                                                   
#                                                                    
# LOG:                                                               
# yyyy/mm/dd [name] [version]: [notes]                               
# 2014/08/18 cgwong v0.1.0: Initial creation from notes.             
######################################################################

# -- VARIABLES -- #
SCRIPT=`basename $0`                                # Script name without path
SCRIPT_PATH=$(dirname $SCRIPT)                      # Script path
SCRIPT_NM=`echo $SCRIPT | awk -F"." '{print $1}'`   # Script name without any extension

EXIT_SUCC=0     # Exit success code
EXIT_ERR=1      # Exit error code

# Default stack size to use
stack_size=490
stack_switch='-XX+UseDefaultStackSize'

# Default heap sizes to use
heap_sizes=${heap_sizes:-'1500 2000 2400'}

# -- FUNCTIONS -- #
show_usage()
{ # Show script usage
echo "
 ${SCRIPT} - Shell script to check Java thread limit. The JDK
             used is determined by the JAVA_HOME environment
             variable. To test multiple JDKs simple change the
             environment variable value.

 USAGE
 ${SCRIPT} [OPTIONS]
 
 OPTIONS
 -s [default | Java native stack size in KB]
    Uses provided Java stack size or the system default. If this
    argument is not specified the default (${stack_size}) is used.
    
 -m <h1,h2,...,hn>
    Heap sizes to test in MB. Each should be separated by comma.
    If nothing is specified default values will be used 
    (i.e. ${heap_sizes})
    
 -h
    Display this help screen.
"
}

# -- MAIN -- #
while getopts ":s:m:h" optval "$@"; do
  case $optval in
    "s") # Stack size
      if [ "$OPTARG" != "default" ]; then
        stack_size=${OPTARG}
        stack_switch="-Xss${OPTARG}k"
      fi
    ;;
    "m") # Heap sizes
      heap_sizes=`echo ${OPTARG} | sed 's/,/ /g'`
    ;;
    "h") # Print help and exit
      show_usage
      exit ${EXIT_SUCC}
    ;;
    "?") # Print help and exit
      echo "Invalid option -${OPTARG}"
      show_usage
      exit ${EXIT_ERR}
    ;;
    :)
      echo "Option -${OPTARG} requires an argument"
      show_usage
      exit ${EXIT_ERR}
    ;;
    *)
      echo "Invalid option with parameter -${OPTARG}"
      show_usage
      exit ${ERR}
    ;;
  esac
done


JAVA=${JAVA_HOME}/bin/java
JAVA_VERSION=`${JAVA} | grep -i "java version" | awk '{print $3}'`

# For different values of native stack size
echo "----------------------------------------"
echo "uname -a: `uname -a | awk '{print $1" "$3}'`"
echo "----------------------------------------"
for stacksize in unlimited 10240 6144 2048; do
  # Change the soft stack size
  ulimit -Ss ${stacksize}
  echo "\n ulimit -s: `ulimit -s`"
  echo "------------------------------------------------------------"
  echo "Max Heap Size | Max Thread Count | Avg. Total Virtual Memory"
  printf '%13s %-18s %26s\n' " (MB) " "| JDK {$JAVA_VERSION}" "|                    (MB)"
  printf '%13s %-18s %26s\n' " " "| ${stack_switch} " " "
  echo "------------------------------------------------------------"
  for heapsize in ${heap_sizes}; do
    jdk_max_threads=`${JAVA} -Xmx${heapsize}M -Xms${heapsize}M ${stack_switch} -classpath . ThreadTest`
    if [ -z `echo ${jdk_max_threads} | tr -d [:alpha:]` ]; then
      jdk_total_memory_accessed=UNDEFINED
    else
      jdk_total_memory_accessed=`echo "${heapsize} + (${jdk_max_threads} * ${stack_size})/1024" | bc`
    fi
    if [ "$jdk_total_memory_accessed" != "UNDEFINED" ]; then
      avg_total_memory_accessed=`echo "(${jdk_total_memory_accessed} + ${jdk_total_memory_accessed}) / 2" | bc`
    else
      avg_total_memory_accessed=UNDEFINED
    fi
    printf '%13s %-18s %26s\n' " "${heapsize} MB "| ${jdk_max_threads} " "| ${avg_total_memory_accessed} "
  done
done
      
# -- END -- #