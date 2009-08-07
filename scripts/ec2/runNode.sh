#!/bin/bash
#
# runNode.sh
#
# Start a ProActive Runtime on an EC2 Instance,
# register it on a remote Resource Manager
#

PROACTIVE_HOME="/usr/share/ProActive/"
PA_SCHEDULER="/usr/share/ProActive"
JARS="$PROACTIVE_HOME/dist/lib/ProActive.jar"
JAVA_HOME="/root/JDK"

JARS=$JARS:"$PA_SCHEDULER/dist/lib/script-js.jar"
JARS=$JARS:"$PA_SCHEDULER/dist/lib/jruby-engine.jar"
JARS=$JARS:"$PA_SCHEDULER/dist/lib/jython-engine.jar"
JARS=$JARS:"$PA_SCHEDULER/dist/lib/commons-logging-1.0.4.jar"
JARS=$JARS:"$PA_SCHEDULER/dist/lib/ProActive.jar"
JARS=$JARS:"$PA_SCHEDULER/dist/lib/ProActive_SRM-common.jar"
JARS=$JARS:"$PA_SCHEDULER/dist/lib/ProActive_ResourceManager.jar"
JARS=$JARS:"$PA_SCHEDULER/dist/lib/ProActive_Scheduler-core.jar"
JARS=$JARS:"$PA_SCHEDULER/dist/lib/ProActive_Scheduler-client.jar"
JARS=$JARS:"$PA_SCHEDULER/dist/lib/ProActive_Scheduler-worker.jar"

$JAVA_HOME/bin/java -cp $JARS \
    -Dproactive.home=$PROACTIVE_HOME \
    -Dpa.scheduler.home=$PA_SCHEDULER \
    -Dpa.rm.home=$PA_SCHEDULER \
    $(python params.py)