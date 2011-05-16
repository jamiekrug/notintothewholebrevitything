#!/bin/bash
#
# This script determines common variables, to be sourced and reused by other scripts in same directory.
#

# current script and directory-; resolve links - $0 may be a softlink
PRG="$0"
while [ -h "$PRG" ]; do
	ls=`ls -ld "$PRG"`
	link=`expr "$ls" : '.*-> \(.*\)$'`
	if expr "$link" : '/.*' > /dev/null; then
		PRG="$link"
	else
		PRG=`dirname "$PRG"`/"$link"
	fi
done

SCRIPTS_DIR=$(cd "$(dirname "$PRG")"; pwd)
TEMP_DIR=$(cd "$(dirname "$SCRIPTS_DIR")"; pwd)
PROJECT_ROOT=$(cd "$(dirname "$TEMP_DIR")"; pwd)

