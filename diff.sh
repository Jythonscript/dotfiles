#!/usr/bin/env bash

declare -a files=(".vimrc" ".zshrc" ".vim/UltiSnips" ".vim/templates")

for file in "${files[@]}"
do
	if [[ $(diff -r {~,.}/$file | wc -l) -ne "0" ]]; then
		echo "changes in $file"
	fi
done
