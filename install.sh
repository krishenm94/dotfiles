#!/bin/bash

ln -sv $PWD/.bashrc $HOME
ln -sv $PWD/.aliasrc $HOME
ln -sv $PWD/.functionrc $HOME
ln -sv $PWD/.envrc $HOME
ln -sv $PWD/.inputrc $HOME

link-dir-contents(){
	echo "Linking files in $@"
	for FILE in $(ls $PWD/$@/); do
		ln -sv $PWD/$@/$FILE $HOME/$@/$FILE
	done
}

link-dir-contents ".config"

unset link-dir-contents
