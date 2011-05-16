#!/bin/bash
#

set -e

# source common stuff:
[[ "$PROJECT_ROOT" = "" ]] && . "$(dirname $0)/common.sh"

branch=$1
if [ "$branch" = "" ]; then
	echo; echo "ERROR: no git branch parameter!"
	echo; echo "USAGE: $0 branch_name"; echo
	exit 1
fi

cd "$PROJECT_ROOT"

TOMCAT_PID_FILE="$PROJECT_ROOT/tomcat/temp/tomcat.pid"
if [ -f "$TOMCAT_PID_FILE" ]; then
	echo; echo "Stopping Tomcat..."
	./tomcat/bin/tomcat_ctl.sh stop
fi

echo; echo "Checking out git branch: $branch..."
git checkout "$branch"

echo; echo "Starting Tomcat..."
./tomcat/bin/tomcat_ctl.sh start

