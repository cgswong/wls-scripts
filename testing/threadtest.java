// ############################################################################
// NAME: threadtest.java
// DESC: Find out the maximum number of threads which can be spawned on a 
//       platform across any JVM version.
//
// LOG:
// yyyy/mm/dd [name]: [version][notes]
// 2014/09/17 cgwong: v0.1.0 Initial creation from (https://blogs.oracle.com/gverma/entry/redhat_linux_kernels_and_proce_1)
// ############################################################################

public class ThreadTest {

public static void main(String[] pArgs) throws Exception {

try { 
// keep spawning new threads forever 
      while (true) { 
      new TestThread().start(); 
      } 
   } 
// when out of memory error is reached, print out the number of 
// successful threads spawned and exit 
   catch ( OutOfMemoryError e ) { 
     System.out.println(TestThread.CREATE_COUNT); 
     System.exit(-1); 
   } 
  } 
  static class TestThread extends Thread { 
    private static int CREATE_COUNT = 0; 
    public TestThread() { 
     CREATE_COUNT++; 
    } 
// make the thread wait for eternity after being spawned 
    public void run() { 
      try { 
        sleep(Integer.MAX_VALUE); 
      } 
// even if there is an interruption, dont do anything 
      catch (InterruptedException e) { 
      } 
    } 
  } 
}