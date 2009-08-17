#!/bin/sh
# ----------------------------------------------------------------------------
#
# This variable should be set to the directory where is installed PA_SCHEDULER
#

CLASSPATH=.



# ----------------------------------------------------------------------------



JAVA_HOME=${JAVA_HOME-NULL};
if [ "$JAVA_HOME" = "NULL" ]
then
echo
echo "The environment variable JAVA_HOME must be set the current jdk distribution"
echo "installed on your computer."
echo "Use "
echo "    export JAVA_HOME=<the directory where is the JDK>"
exit 127
fi

#set Scheduler install directory env var

PA_SCHEDULER=$(cd $workingDir/../.././ || (echo "Broken Scheduler/Resource Manager installation" ; exit 1) && echo $PWD)

print_jars() {
        find "$1" -name "*.jar" | while read jar; do
            printf "%s:" "$jar"
        done
}


# ----
# Set up the classpath using classes dir or jar files
# This is a distribution env; use always the jars
#
CP=`print_jars "$PA_SCHEDULER/dist/lib"`
CLASSPATH=$CLASSPATH:$CP

export CLASSPATH

#log4j file
case "$1" in
"router")
	LOG4J_FILE=file:${PA_SCHEDULER}/config/log4j/router-log4j
	;;
"rm-log4j-server")
	LOG4J_FILE=file:${PA_SCHEDULER}/config/log4j/rm-log4j-server
	;;
"scheduler-log4j-server")
	LOG4J_FILE=file:${PA_SCHEDULER}/config/log4j/scheduler-log4j-server
	;;
*)
# defaults to the old ways
	LOG4J_FILE=file:${PA_SCHEDULER}/config/log4j/$1
	;;
esac

JAVACMD="$JAVA_HOME/bin/java -Djava.security.manager -Dproactive.configuration=\"$PA_SCHEDULER/config/proactive/ProActiveConfiguration.xml\" -Djava.security.policy=\"$PA_SCHEDULER/config/scheduler.java.policy\" -Dlog4j.configuration=\"$LOG4J_FILE\" -Dproactive.home=\"$PA_SCHEDULER\" -Dpa.scheduler.home=\"$PA_SCHEDULER\" -Dpa.rm.home=\"$PA_SCHEDULER\""

#echo $JAVACMD

export PA_SCHEDULER
export JAVACMD

