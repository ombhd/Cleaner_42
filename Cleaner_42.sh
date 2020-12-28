#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

if [ "$1" == "update" ];
then
	git clone --quiet https://github.com/su-omb/Cleaner_42.git
	if [ "" == "$(diff ~/Cleaner_42.sh ./Cleaner_42/Cleaner_42.sh)" ];
	then
		echo -e "\033[33m\n -- You already have the latest version of cclean --\n\033[0m"
		/bin/rm -rf ./Cleaner_42
		exit 0
	fi
	cp -f ./Cleaner_42/Cleaner_42.sh ~ &>/dev/null
	/bin/rm -rf ./Cleaner_42 &>/dev/null
	echo -e "\033[33m\n -- cclean has been updated successfully --\n\033[0m"
	exit 0
fi
Storage=$(df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B')
if [ "$Storage" == "0BB" ];
then
	Storage="0B"
fi
echo -e "\033[33m\n -- Available Storage Before Cleaning : || $Storage || --\033[0m"

echo -e "\033[31m\n -- Cleaning ...\n\033[0m "

#42 Caches
/bin/rm -rf ~/Library/*.42* &>/dev/null
/bin/rm -rf ~/*.42* &>/dev/null
/bin/rm -rf ~/.zcompdump* &>/dev/null
/bin/rm -rf ~/.cocoapods.42_cache_bak* &>/dev/null

#Trash
/bin/rm -rf ~/.Trash/* &>/dev/null

#General Cache files
/bin/rm -rf ~/Library/Caches/* &>/dev/null

#Slack, VSCode, Discord and Chrome Caches
/bin/rm -rf ~/Library/Application\ Support/Slack/Service\ Worker/CacheStorage/* &>/dev/null
/bin/rm -rf ~/Library/Application\ Support/Code/User/workspaceStorage/* &>/dev/null
/bin/rm -rf ~/Library/Application\ Support/discord/Cache/* &>/dev/null
/bin/rm -rf ~/Library/Application\ Support/discord/Code\ Cache/js* &>/dev/null
/bin/rm -rf ~/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Service\ Worker/CacheStorage/* &>/dev/null
/bin/rm -rf ~/Library/Application\ Support/Google/Chrome/Default/Service\ Worker/CacheStorage/* &>/dev/null
/bin/rm -rf ~/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Application\ Cache/* &>/dev/null
/bin/rm -rf ~/Library/Application\ Support/Google/Chrome/Default/Application\ Cache/* &>/dev/null

#.DS_Store files
find ~/Desktop -name .DS_Store -depth -exec /bin/rm {} \; &>/dev/null

#tmp downloaded files with browsers
/bin/rm -rf ~/Library/Application\ Support/Chromium/Default/File\ System &>/dev/null
/bin/rm -rf ~/Library/Application\ Support/Chromium/Profile\ [0-9]/File\ System &>/dev/null
/bin/rm -rf ~/Library/Application\ Support/Google/Chrome/Default/File\ System &>/dev/null
/bin/rm -rf ~/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/File\ System &>/dev/null

Storage=$(df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B')
if [ "$Storage" == "0BB" ];
then
	Storage="0B"
fi
echo -e "\033[32m -- Available Storage After Cleaning : || $Storage || --\n\033[0m"

