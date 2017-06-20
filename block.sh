#!/bin/bash
# Code below uses GPLV3 license. 
# See license file for more details



#List of addresses to download blocklists (ip block format: xx.xx.xx.xx/yy, one block per line, ipv4 only.)
WGETS=(
	"https://www.spamhaus.org/drop/drop.txt" 
	"https://www.spamhaus.org/drop/edrop.txt" 
	)
#target file - can be passed as first argument too
TARGET=~/deny-list.conf

if [[ ! -z $1 ]]; then
	TARGET=$1;
fi

#---------
#no-touchy.
#---------

function fetchData {
	DATA=""
	for URL in $(printf "${WGETS[*]}"); do 
		DATA+=$(curl -sS "$URL");
	done
}


function parseIPS {
	DATA=$(echo -e "$DATA" | grep -E -o "([0-9]{1,3}\.){3}[0-9]{1,3}\/[0-9]{1,2}");
}

#replace with apache for apache rules?
function addDeny {
	RES="";
	for BLOCK in $(printf "$DATA"); do
		RES+="deny $BLOCK;\n";
	done
	DATA=$(printf "$RES");
}


function writeToTarget {
	#sort & unique only
	printf "$(printf "$DATA" | sort | uniq -u)" > $TARGET;
}



fetchData && parseIPS && addDeny && writeToTarget && exit 0 || exit 1;
