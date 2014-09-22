######################################################################
# NAME: heap_monitor.py                                              
# DESC: Monitors the HJVMHeapSize for all running servers in a       
#       WebLogic domain. It checks the heap size every 3 minutes and 
#       prints a warning if the heap size is greater than a specified
#       threshold.                                                   
#                                                                    
# LOG:                                                               
# yyyy/mm/dd [name] [version]: [notes]                               
# 2014/08/18 cgwong v0.1.0: Initial creation from notes.             
######################################################################

# Some initial variables
waitTime  = 180000
THRESHOLD = 90
java_home = os.getenv('JAVA_HOME');

# Test command line arguments
if len(sys.argv) != 4:
  print 'Usage:  wlst.sh heap_monitor.py <wls_username> <wls_password> <wls_url>';
  exit();

# Set username, password and URL via command line arguments
# Note: alternatively we could have used security files created by storeconfig
uname = sys.argv[1];
pwd = sys.argv[2];
url = sys.argv[1];

def monitorJVMHeapSize():
  connect(uname, pwd, url)
  while 1:
    serverNames = getRunningServerNames()
    domainRuntime()
    for name in serverNames:
      print 'Checking: '+name.getName()
      try:
        cd("/ServerRuntimes/"+name.getName()+"/JVMRuntime/"+name.getName())
        heapSize = cmo.getHeapSizeCurrent()
        heapFree = cmo.getHeapFreeCurrent()
        heapUsed = (heapSize - heapFree)
        heapFreePct = cmo.getHeapFreePercent()

        if heapFreePct >= THRESHOLD:
          # do whatever is neccessary, send alerts, send email, run OS process, etc
          print 'WARNING: The HEAPSIZE is Greater than the Threshold'
          cmd_output = os.popen('pgrep -f Dweblogic.Name=' + name);
          jpid = cmd_output.readline();
          cmd_output.close()
          system ('java_home/bin/jcmd ' + jpid.rstrip() + ' GC.run');
        else:
          print heapSize
        except WLSTException,e:
          # This typically means the server is not active, just ignore
          # pass
          print "Ignoring exception " + e.getMessage()
          java.lang.Thread.sleep(waitTime)
 
def getRunningServerNames():
  # only returns the currently running servers in the domain
  return domainRuntimeService.getServerRuntimes()
 
if __name__== "main":
  monitorJVMHeapSize()   
    
disconnect();
exit();
