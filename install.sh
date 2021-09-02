#!/bin/bash

echo 'Linking files in' "$PWD"

HOME_DOTFILES="$(find . -name ".*" -type f)"
while IFS= read -r FILE; do
	if [[ $FILE != "./.gitignore" ]]; then
		ln -sv "$PWD"/"$FILE" "$HOME"/"$FILE"
	fi
done <<<"$HOME_DOTFILES"

link-dir-contents() {
	echo 'Linking files in' "$1"
	ln -sv "$PWD"/"$1"/* -t "$HOME"/"$1"
}

link-dir-contents .config

unset link-dir-contents
