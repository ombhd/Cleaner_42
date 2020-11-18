#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

if [ "$1" == "update" ];
then
	if [ "" = "$(git diff https://github.com/su-omb/Cleaner_42/blob/master/Cleaner_42.sh ~/Cleaner_42.sh)" ];
	then
		echo -e "\033[33m\n -- You have already the latest version of cclean --\n\033[0m"
		exit 0
	fi
	git clone https://github.com/su-omb/Cleaner_42.git
	cp -f ./Cleaner_42/Cleaner_42.sh ~
	rm -rf ./Cleaner_42
	echo -e "\033[33m\n -- cclean has been updated successfully --\n\033[0m"
	exit 0
fi
Storage=$(df -h . | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B')
if [ "$Storage" == "0BB" ];
then
	Storage="0B"
fi
echo -e "\033[33m\n -- Available Storage Before Cleaning : || $Storage || --\033[0m"

echo -e "\033[31m\n -- Cleaning ...\n\033[0m "

rm -rf ~/Library/*.42*
rm -rf ~/*.42*
rm -rf ~/.cocoapods.42_cache_bak*
rm -rf ~/.Trash/*
rm -rf ~/Library/Caches
rm -rf ~/.zcompdump*
rm -rf ~/Library/Application\ Support/Slack/Service\ Worker/CacheStorage/*
rm -rf ~/Library/Application\ Support/Code/User/workspaceStorage/*
rm -rf ~/Library/Application\ Support/discord/Cache/*
rm -rf ~/Library/Application\ Support/discord/Code\ Cache/js*
find ~/Desktop -name .DS_Store -depth -exec rm {} \;

Storage=$(df -h . | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B')
if [ "$Storage" == "0BB" ];
then
	Storage="0B"
fi
echo -e "\033[32m -- Available Storage After Cleaning : || $Storage || --\n\033[0m"

