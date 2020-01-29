#!/usr/bin/env bash

declare -a files=(".vimrc" ".zshrc" ".vim/UltiSnips")

for file in "${files[@]}"
do
	if [[ $(diff {~,.}/$file | wc -l) -ne "0" ]]; then
		echo "changes in $file"
	fi
done
