#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

if [ "$1" == "update" ];
then
	git clone --quiet https://github.com/su-omb/Cleaner_42.git
	if [ "" == "$(diff ~/Cleaner_42.sh ./Cleaner_42/Cleaner_42.sh)" ];
	then
		echo -e "\033[33m\n -- You already have the latest version of cclean --\n\033[0m"
		rm -rf ./Cleaner_42
		exit 0
	fi
	cp -f ./Cleaner_42/Cleaner_42.sh ~ &>/dev/null
	rm -rf ./Cleaner_42 &>/dev/null
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
rm -rf ~/Library/*.42* &>/dev/null
rm -rf ~/*.42* &>/dev/null
rm -rf ~/.zcompdump* &>/dev/null
rm -rf ~/.cocoapods.42_cache_bak* &>/dev/null

#Trash
rm -rf ~/.Trash/* &>/dev/null

#General Cache files
rm -rf ~/Library/Caches &>/dev/null

#Slack, VSCode, Discord Caches
rm -rf ~/Library/Application\ Support/Slack/Service\ Worker/CacheStorage/* &>/dev/null
rm -rf ~/Library/Application\ Support/Code/User/workspaceStorage/* &>/dev/null
rm -rf ~/Library/Application\ Support/discord/Cache/* &>/dev/null
rm -rf ~/Library/Application\ Support/discord/Code\ Cache/js* &>/dev/null

#.DS_Store files
find ~/Desktop -name .DS_Store -depth -exec rm {} \; &>/dev/null

#tmp downloaded files with browsers
rm -rf ~/Library/Application\ Support/Chromium/Default/File\ System &>/dev/null
rm -rf ~/Library/Application\ Support/Google/Chrome/Default/File\ System &>/dev/null

Storage=$(df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B')
if [ "$Storage" == "0BB" ];
then
	Storage="0B"
fi
echo -e "\033[32m -- Available Storage After Cleaning : || $Storage || --\n\033[0m"

