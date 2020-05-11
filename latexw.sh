#!/bin/bash

# compute the initial hash of the file
init_hash=$(sha256sum $1)

check_diff() {
	init_hash=$1
	file=$2
	while true; do
		echo "Init hash: $init_hash"
		new_hash=$(sha256sum $2)
		echo "New hash: $new_hash"
		# if file has been updated
		if [ "$init_hash" != "$new_hash" ]; then
			# compile the file and send stdout to /dev/null
			pdflatex $2
			# set init_hash to new_hash
			init_hash=$new_hash
		fi
		sleep 4
	done
}

check_diff $init_hash $1
