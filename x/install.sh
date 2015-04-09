#!/bin/bash

IFS=$'\n'

for i in `ls | grep -v install.sh`; do
	ln -s ~/dotfiles/x/$i ~/.$i
done
