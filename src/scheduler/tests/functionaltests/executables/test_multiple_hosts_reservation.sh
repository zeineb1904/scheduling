#!/bin/sh
# $1 number of booked cores

function check_node_file {
HOSTNAME=`hostname`
for i in `cat $PAS_NODEFILE`
do
	if [ "$i" != "$HOSTNAME" ]
	then
		echo "Error booked host name is invalid : $i"
		return 1
	fi
done
return 0
}

TEST_RES=0

if [ -z "$PAS_CORE_NB" ]
then
	echo "Error 'PAS_CORE_NB' env variable is not defined"
	TEST_RES=1
fi

if [ "$PAS_CORE_NB" != "$1" ]
then
	echo "Error : number of booked host is not $1"
	TEST_RES=1
fi

if [ -z "$PAS_NODEFILE" ]
then
	echo "Error 'PAS_NODEFILE' env variable is not defined"
	TEST_RES=1
fi

if [ ! -r $PAS_NODEFILE ]
then
	echo "Error cannot read 'PAS_NODEFILE'"
	TEST_RES=1
else
	NBS_LINES=`wc -l $PAS_NODEFILE | cut -f1 -d ' '`
	if [ "$NBS_LINES" != "$1" ]
	then
		echo "Error 'PAS_NODEFILE' must have $1 lines, it has $NBS_LINES"
		cat $PAS_NODEFILE
		TEST_RES=1
	else
		check_node_file
		TEST_RES=$?
	fi
fi

exit $TEST_RES