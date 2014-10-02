# Introduction
WebLogic administration script repository.


## Directories and Files
* **common**  - Contains scripts common to most administrative functions and domain.
* **jms**     - Contains scripts specific to JMS functionality.
* **monitor** - Scripts specific to monitoring and benchmarking.
* **testing** - Scripts specific to testing features and functionalities.


## Script setup
To set the environment for WLST scripts:

```
. $WL_HOME/server/bin/setWLSEnv.sh
```

Run .py scripts using WLST:
```
$JAVA_HOME/bin/java weblogic.WLST <script>.py
```
