#!/usr/bin/env bash

compile() {
	result=$(pdflatex -file-line-error -interaction=nonstopmode -halt-on-error $1 | grep -E '.tex:[0-9]+:')
}

try_compile() {
	# run compile command
	compile $1
	# report any compilation errors
	if [ -z "$result" ]; then
		ret=0
	else
		printf "Error occurred:\n$result\n"
		ret=1
	fi
}

watch_tex() {
	file=$1
	texhash=$(sha256sum $file)
	while true; do
		# compute a new hash
		newhash=$(sha256sum $file)
		# if file has been updated
		if [ "$texhash" != "$newhash" ]; then
			# attempt to compile the file
			try_compile $file
			if [ $ret -eq 0 ]; then
				printf "$file recompiled.\n"
			fi
			# set init_hash to new_hash
			texhash=$newhash
		fi
		sleep 4
	done
}

main() {
	file=$1
	tex='tex'
	ext=$(printf $file | cut -d '.' -f2)
	# run compilation command on .tex files
	if [ $tex = $ext ]; then
		try_compile $file
		printf "$file compiled!\nWatching $file for changes...\nUse ^C to quit.\n"
		watch_tex $file
	else
		printf "Please provide a .tex file.\n"
		exit 1
	fi
}

# run latexw
main $1
