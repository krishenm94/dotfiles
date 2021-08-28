#!/bin/bash

ln -sv $PWD/.bashrc $HOME
ln -sv $PWD/.aliasrc $HOME
ln -sv $PWD/.functionrc $HOME
ln -sv $PWD/.envrc $HOME
ln -sv $PWD/.inputrc $HOME

link-dir-contents(){
	echo 'Linking files in' $1
	ln -sv $PWD/$1/* -t $HOME/$1
}

link-dir-contents .config

unset link-dir-contents
