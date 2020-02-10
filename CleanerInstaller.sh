#!/bin/bash
#Author OMB

shell_f=$(echo -n $(ls -a ~ | grep ".zshrc"))

if [ "$shell_f" != ".zshrc" ];
then
	shell_f=".bashrc"
fi

if [ "alias cclean='~/Cleaner.sh'" == "$(echo -n $(cat ~/"$shell_f" | tail -n 1))" ]
then
	echo -e "\033[33m\n -- cclean Already installed --\n\033[0m"
	exit
fi

path=$(echo -n $(find ~ -name "Cleaner.sh" 2>&1 | sed '/Permission denied/d;'))

echo "$(echo -n $(ls -a ~ | grep "Cleaner.sh"))" 

if [ "$(echo -n $(ls -a ~ | grep "Cleaner.sh"))" != "\n" ];
then
	mv "$path" "$HOME"
fi

echo "alias cclean='bash ~/Cleaner.sh'" >> ~/"$shell_f"

if [ "alias cclean='~/Cleaner.sh'" == "$(echo -n $(cat ~/"$shell_f" | tail -n 1))" ]
then
	echo -e "\033[32m\n -- cclean command has been successfully installed ! Enjoy :) --\n\033[0m"
	echo -e "\033[36m -- Please, run this command now : [\033[33m source ~/"$shell_f"\033[0m\033[36m ] Then run [\033[33m cclean \033[0m\033[36m]--\n\033[0m" 
else
	echo -e "\033[31m\n -- cclean command has NOT been installed ! :( --\n\033[0m"
fi

