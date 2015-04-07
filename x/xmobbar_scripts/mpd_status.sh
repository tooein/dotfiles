#!/bin/bash -
me=`basename "$0"`
mydir=`dirname "$0"`

IFS=$'\n' result=( `mpc --format='%artist% - %title%'` )
if [ $? -ne 0 ]; then
	echo "NO MPD"
	exit
fi

compact_mode() {
	repeat_char="-"
	random_char="-"
	single_char="-"
	consume_char="-"

	if [[ "$1" =~ "repeat: on" ]]; then
		repeat_char="r"
	fi
	if [[ "$1" =~ "random: on" ]]; then
		random_char="z"
	fi
	if [[ "$1" =~ "single: on" ]]; then
		single_char="s"
	fi
	if [[ "$1" =~ "consume: on" ]]; then
		consume_char="c"
	fi

	echo "[$repeat_char$random_char$single_char$consume_char]"
}

song_line=${result[0]}
position_line=${result[1]}
mode_line=${result[2]}

if [ -z "$position_line" ]; then
	# stopped

	status_char="#"
	mode_line="$song_line"
	song_line=""
else
	if [[ "$position_line" =~ "[playing]" ]]; then
		status_char='>'
	else
		status_char='|'
	fi
fi

echo " $song_line $status_char $(compact_mode "$mode_line")"
