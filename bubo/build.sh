#!/bin/bash

branch () {
	if [[ $1 == *:* ]]; then
	  echo $(echo "$1" | cut -d: -f2)
	else
	  echo master
	fi
}

repo () {
	if [[ $1 == *:* ]]; then
	  echo $(echo "$1" | cut -d: -f1)
	else
	  echo $1
	fi
}

svc () {
	[ "$1" == "" ] || [ "$1" == "$2" ]
}

# parse params
while getopts pt:s: OPTION
do
	case "${OPTION}"
	in
		t) TAG=${OPTARG};;
		p) PUSH=yes;;
		s) SVC=${OPTARG};;
		?) echo "Usage: $(basename $0) [-t <tag>] [-s <service-name>] [-p]" >&2
		   exit 1
		   ;;
	esac
done 

# determine root folder
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
echo ROOT=$ROOT 

# export vars
. "$ROOT/bubo/.env"
export TAG=${TAG:-$SVC_VER}
export PUSH=${PUSH:-no}

echo TAG=$TAG
echo PUSH=$PUSH
echo SVC=$SVC

# set error handing
set -o errexit

# build docker images
if svc "$SVC" foo-service; then "$ROOT/bubo/build-single.sh" foo-service "$ROOT/src/SowaLabs.FooService" Dockerfile; fi
if svc "$SVC" bar-service; then "$ROOT/bubo/build-single.sh" bar-service "$ROOT/src/SowaLabs.BarService" Dockerfile; fi