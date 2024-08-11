#!/usr/bin/env bash

filename="$1"

if [ -z "$filename" ]; then
	echo "Usage: $0 <filename>"
	exit 1
fi

extension="${filename##*.}"

case "$extension" in
	py)
		# Python script
		python3 -m autopep8 --in-place "$filename"
		;;
	sh | "")
		# Bash script or file without extension
		shellcheck "$filename" || shellcheck "${filename}.sh"
		;;
	c)
		# C source file
		betty "$filename"
		;;
	js)
		# JavaScript file
		semistandard --fix ./"$filename"
		;;

esac