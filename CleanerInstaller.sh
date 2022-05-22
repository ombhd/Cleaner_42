#!/bin/bash
#Author Omar BOUYKOURNE
#42login obouykou

echo -en "\n    	    	      By: "
echo -e "\033[33m𝒐𝒃𝒐𝒖𝒚𝒌𝒐𝒖\033[0m"
echo -e "\n	       report any issues to me in:"
echo -e "		   GitHub   ~> \033[4;1;34mombhd\033[0m"
echo -e "	   	   42 Slack ~> \033[4;1;34mobouykou\033[0m\n"
sleep 2

#update
git pull &>/dev/null

#get the shell configuration file name
shell_f=$(echo -n "$SHELL" | awk -F / '{print $3}')
shell_f="${HOME}/.${shell_f}rc"

#test if it is already installed
if grep "alias cclean='bash ~/Cleaner_42.sh'" <"$shell_f" &>/dev/null && ls "$HOME"/Cleaner_42.sh &>/dev/null; then
	sleep 0.5
	echo -e "\033[33m\n -- cclean Already installed --\n\033[0m"
	sleep 0.5
	echo -e "\033[36m -- Please, run this command now : [\033[33m source $shell_f\033[0m\033[36m ] Then run [\033[33m cclean \033[0m\033[36m]--\n\033[0m"
	sleep 0.5
	echo -e "\033[36m -- For updates, run [\033[33m cclean update \033[0m\033[36m] --\n\033[0m"
	exit 0
fi

#take confirmation
while true; do

	echo "cclean program/command removes: "
	sleep 0.2
	echo "  - the Trash contents."
	sleep 0.2
	echo "  - 42 caches from Library and Home directories."
	sleep 0.2
	echo "  - Chrome Caches."
	sleep 0.2
	echo "  - VSCode Caches and its workspaces cache storage."
	sleep 0.2
	echo "  - Social Media Apps Caches, like Slack and Discord."
	sleep 0.2
	echo "  - FileSystems which are located in browsers profiles directories, such as Chrome and Chromium."
	sleep 0.2
	echo -en "\n\033[33mDo you really want to install this program ? \033[0m\0"
	read -r yn
	case $yn in
	[Yy]*) break ;;
	[Nn]*) exit ;;
	*) echo -e "\n\033[31mPlease answer yes or no !\033[0m\0\n" ;;
	esac
done

#remove the old Cleaner and Cleaner42 if there are any, then copy the current one to Home dir
/bin/rm -rf ~/Cleaner_42.sh &>/dev/null
/bin/rm -rf ~/Cleaner.sh &>/dev/null
cp -f ./Cleaner_42.sh "$HOME"

if ! grep "alias cclean='bash ~/Cleaner_42.sh'" <"$shell_f" &>/dev/null; then
	echo -e "\nalias cclean='bash ~/Cleaner_42.sh'" >>"$shell_f"
fi

if grep "alias cclean='bash ~/Cleaner_42.sh'" <"$shell_f" &>/dev/null && ls "$HOME"/Cleaner_42.sh &>/dev/null; then
	sleep 0.5
	echo -e "\n\033[32m -- cclean command has been successfully installed ! Enjoy :) --\n\033[0m"
	sleep 0.5
	echo -e "\033[36m -- Please, run this command now : [\033[33m source $shell_f\033[0m\033[36m ] Then run [\033[33m cclean \033[0m\033[36m]--\n\033[0m"
	sleep 0.5
	echo -e "\033[36m -- For updates, run [\033[33m cclean update \033[0m\033[36m] --\n\033[0m"
else
	sleep 0.5
	echo -e "\033[31m\n -- cclean command has NOT been installed ! :( --\n\033[0m"
	exit 1
fi

exit 0
