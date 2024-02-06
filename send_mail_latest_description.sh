#!/bin/bash 

function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }

mailAddress=$1

if [ ! -n "$1" ]; then
echo "Введите email для отправки:"
read mailAddress
fi

description_of_version=$(docker exec postgres_test_cont /bin/sh -c "psql -At -U version_user version_db -c 'SELECT minor, major, build FROM versions;'")
string=$(echo $description_of_version | sed 's/|/./g')

IFS=', ' read -r -a arrayOfVersions <<< "$string"

maxver=${arrayOfVersions[0]}

for i in ${arrayOfVersions[@]}
	do
		if [[ $(version $i) -ge $(version $maxver) ]]; then
		   maxver=$i
		fi
	done

IFS='. ' read -r -a arrayOneVersion <<< "$maxver"
description_of_version=$(docker exec postgres_test_cont /bin/sh -c "psql -At -U version_user version_db -c 'SELECT DS.descrption FROM versions as VS JOIN versions_description as DS ON VS.id=DS.version_id WHERE VS.minor="${arrayOneVersion[0]}" and VS.major="${arrayOneVersion[1]}" and VS.build="${arrayOneVersion[2]}";'")
docker exec mailutil_cont /bin/sh -c "echo $description_of_version | mail -s 'New description' $mailAddress"
