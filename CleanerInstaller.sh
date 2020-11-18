#!/bin/bash
#Author Omar BOUYKOURNE
#42login obouykou

while true; do
    echo -e "cclean program cleans: \n1 - The Trash. \n2 - 42 cache files from Library directory and from the home directory. \n3 - Some Slack, VSCode and Discord Caches.\n"
    read -p "[\033[33mDo you really want to install this program ? \033[0m\033[36m" yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

shell_f=$(echo -n $(ls -a ~ | grep ".zshrc"))

if [ "$shell_f" != ".zshrc" ];
then
	shell_f=".bashrc"
fi

if [ "alias cclean='bash ~/Cleaner_42.sh'" == "$(echo -n $(cat ~/"$shell_f" | tail -n 1))" ]
then
	echo -e "\033[33m\n -- cclean Already installed --\n\033[0m"
	echo -e "\033[36m -- Please, run this command now : [\033[33m source ~/"$shell_f"\033[0m\033[36m ] Then run [\033[33m cclean \033[0m\033[36m]--\n\033[0m" 
	exit
fi

cp -f ./Cleaner_42.sh "$HOME"

echo "alias cclean='bash ~/Cleaner_42.sh'" >> ~/"$shell_f"

if [ "alias cclean='bash ~/Cleaner_42.sh'" == "$(echo -n $(cat ~/"$shell_f" | tail -n 1))" ]
then
	echo -e "\033[32m\n -- cclean command has been successfully installed ! Enjoy :) --\n\033[0m"
	echo -e "\033[36m -- Please, run this command now : [\033[33m source ~/"$shell_f"\033[0m\033[36m ] Then run [\033[33m cclean \033[0m\033[36m]--\n\033[0m" 
else
	echo -e "\033[31m\n -- cclean command has NOT been installed ! :( --\n\033[0m"
fi

