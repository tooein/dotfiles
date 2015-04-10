#!/bin/bash

charge=$(acpi -ib | grep -v design | cut -d " " -f4 | tr -d "%" | tr -d "," | awk '{s += $1} END {s = s/2; print int(s)}')
ac_status=`/usr/bin/acpi -ia | cut -d" " -f3`

if [ "$charge" -lt 10	 ];
then
	charge="<fc=red>"${charge}"% </fc>";
elif [ "$charge" -lt 80 ];
then
	charge="<fc=yellow>"${charge}"% </fc>";
else
	charge="<fc=green>"${charge}"% </fc>";
fi;


if [ $ac_status == "on-line" ];
then
	time=""
	ac="<fc=green>+ </fc>";
else
	time="<fc=green>"`/usr/bin/acpi | cut -d " " -f5`" </fc>"
	ac="<fc=red>- </fc>";
fi


echo "$charge $ac $time"

