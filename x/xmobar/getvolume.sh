#!/bin/bash
str=`amixer sget Master,0`
str1=${str#Simple*\[}
v1=${str1%%]*]}
v=$v1"  "
state=`echo $str1 | cut -d " "  -f 2  | tr -d "[" | tr -d "]"`
if [ $v1 == "0%" ] || [ $state == "off" ]; then v="<fc=red>$v</fc>"; fi
echo $v
