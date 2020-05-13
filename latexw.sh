#!/usr/bin/env bash

timestamp() {
	time=$(date | grep -oe '[0-9][0-9]:[0-9][0-9]:[0-9][0-9][[:blank:]][AP]M')
	printf "$time"
}

compile() {
	# try to compile and save any errors
	result=$(pdflatex -file-line-error -interaction=nonstopmode -halt-on-error $1 | grep -E '.tex:[0-9]+:')
}

compile_tex() {
	# run compile command
	compile $1
	if [ -z "$result" ]; then
		ret=0
	else
		# report any compilation errors
		printf "\nError occurred:\n$result\n"
		ret=1
	fi
}

watch_tex() {
	file=$1
	# save initial file hash
	texhash=$(sha256sum $file)
	# watch .tex file until ctrl+c
	while true; do
		# compute a new hash
		newhash=$(sha256sum $file)
		# check for hash change
		if [ "$texhash" != "$newhash" ]; then
			# attempt to compile the file
			compile_tex $file
			if [ $ret -eq 0 ]; then
				printf "\n$file recompiled at $(timestamp).\n"
			fi
			# update the file hash
			texhash=$newhash
		fi
		sleep 2
	done
}

main() {
	file=$1
	tex='tex'
	# extract input file extension
	ext=$(printf $file | cut -d '.' -f2)
	# run compilation command on .tex file
	if [ $tex = $ext ]; then
		compile_tex $file
		if [ $ret -eq 0 ]; then
			printf "$file compiled at $(timestamp).\nWatching $file for changes...\nUse ^C to quit.\n"
		fi
			# watch for changes in the .tex file
			watch_tex $file
	else
		printf "Please provide a .tex file.\n"
		exit 1
	fi
}

# run latexw
main $1
