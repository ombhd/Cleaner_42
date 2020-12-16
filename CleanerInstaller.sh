#!/bin/bash
#Author Omar BOUYKOURNE
#42login obouykou

while true; do
    echo -e "cclean program cleans: \n1 - The Trash. \n2 - 42 cache files from Library directory and from the home directory. \n3 - Some Slack, VSCode, Chrome and Discord Caches.\n4 - Temporary downloaded files by browsers [Chrome, Chromium].\n"
    echo -en "\033[33mDo you really want to install this program ? \033[0m\033[36m"
    read yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo -e "\nPlease answer yes or no !";;
    esac
done

if [ "Cleaner_42.sh" == "$(ls "$HOME" | grep Cleaner_42.sh)" ];
then
	rm -rf ~/Cleaner_42.sh
fi

cp -f ./Cleaner_42.sh "$HOME"

shell_f=$(echo -n "$SHELL" | awk -F / '{print $3}')
shell_f="${HOME}/.${shell_f}rc"

if [ "alias cclean='bash ~/Cleaner_42.sh'" == "$(cat "$shell_f" | grep "alias cclean='bash ~/Cleaner_42.sh'")" ]
then
	echo -e "\033[33m\n -- cclean Already installed --\n\033[0m"
	echo -e "\033[36m -- Please, run this command now : [\033[33m source "$shell_f"\033[0m\033[36m ] Then run [\033[33m cclean \033[0m\033[36m]--\n\033[0m" 
	exit
fi

echo "alias cclean='bash ~/Cleaner_42.sh'" >> "$shell_f"

if [ "alias cclean='bash ~/Cleaner_42.sh'" == "$(cat "$shell_f" | grep "alias cclean='bash ~/Cleaner_42.sh'")" ]
then
	echo -e "\033[32m\n -- cclean command has been successfully installed ! Enjoy :) --\n\033[0m"
	echo -e "\033[36m -- Please, run this command now : [\033[33m source "$shell_f"\033[0m\033[36m ] Then run [\033[33m cclean \033[0m\033[36m]--\n\033[0m" 
	echo -e " -- Run [\033[33m cclean update\033[0m\033[36m] for updates in future --\n\033[0m" 
else
	echo -e "\033[31m\n -- cclean command has NOT been installed ! :( --\n\033[0m"
fi

