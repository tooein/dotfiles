#!/bin/bash

status=`wicd-cli --wireless -d`
wicdstatus=$?

essid=`wicd-cli --wireless -d | grep Essid | cut -d" " -f2`
strength=`wicd-cli --wireless -d | grep Quality | cut -d" " -f2`
ip=`wicd-cli --wireless -d | grep IP | cut -d" " -f2`

essid="<fc=purple>"$essid"</fc>"


if [[ $strength -lt 20 ]];
then
	strength="<fc=red>"$strength"% </fc>";
elif [[ $strength -lt 60 ]];
then
	strength="<fc=yellow>"$strength"% </fc>";
else
	strength="<fc=green>"$strength"% </fc>";
fi;

if [[ $ip == "None" ]];
then
	ip="<fc=red>"$ip" </fc>";
else
	ip="<fc=pink>"$ip" </fc>";
fi;

if [ $wicdstatus == 0 ] && [ $essid != "" ];
then
	echo "$essid $strength $ip";
else
	if ifconfig enp2s0 | grep --quiet "inet ";
	then
		ip=`ifconfig enp2s0 | grep "inet " | cut -d " " -f 10`;
		echo "<fc=pink>ethernet: $ip</fc>";
	fi;
fi
