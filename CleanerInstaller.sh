#!/bin/bash
#Author Omar BOUYKOURNE
#42login obouykou

#take confirmation
while true; do
    echo  "cclean program cleans: "
    echo  "  - the Trash"
	echo  "  - 42 caches from Library and Home directories."
	echo  "  - Chrome Caches."
	echo  "  - VSCode Caches and its workspaces cache storage."
	echo  "  - Social Media Apps Caches, like Slack and Discord."
	echo  "  - FileSystems which are located in browsers profiles directories, such as Chrome and Chromium."
	echo -en "\n\033[33mDo you really want to install this program ? \033[0m\0"
    read -r yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo -e "\nPlease answer yes or no !";;
    esac
done

#remove the old Cleaner and Cleaner42 if anyone exists, then copy the current one to home dir
/bin/rm -rf ~/Cleaner_42.sh &>/dev/null
/bin/rm -rf ~/Cleaner.sh &>/dev/null
cp -f ./Cleaner_42.sh "$HOME"

#get the shell configuration file name
shell_f=$(echo -n "$SHELL" | awk -F / '{print $3}')
shell_f="${HOME}/.${shell_f}rc"

#test if it is already installed
if [ "alias cclean='bash ~/Cleaner_42.sh'" == "$(grep "alias cclean='bash ~/Cleaner_42.sh'" < "$shell_f")" ]
then
	echo -e "\033[33m\n -- cclean Already installed --\n\033[0m"
	echo -e "\033[36m -- Please, run this command now : [\033[33m source $shell_f\033[0m\033[36m ] Then run [\033[33m cclean \033[0m\033[36m]--\n\033[0m" 
	echo -e "\033[36m -- For updates, run [\033[33m cclean update \033[0m\033[36m] --\n\033[0m" 
	exit 0
fi

echo "alias cclean='bash ~/Cleaner_42.sh'" >> "$shell_f"

if [ "alias cclean='bash ~/Cleaner_42.sh'" == "$(grep "alias cclean='bash ~/Cleaner_42.sh'" < "$shell_f")" ]
then
	echo -e "\n\033[32m -- cclean command has been successfully installed ! Enjoy :) --\n\033[0m"
	echo -e "\033[36m -- Please, run this command now : [\033[33m source $shell_f\033[0m\033[36m ] Then run [\033[33m cclean \033[0m\033[36m]--\n\033[0m" 
	echo -e "\033[36m -- For updates, run [\033[33m cclean update \033[0m\033[36m] --\n\033[0m" 
else
	echo -e "\033[31m\n -- cclean command has NOT been installed ! :( --\n\033[0m"
	exit 1
fi

exit 0
