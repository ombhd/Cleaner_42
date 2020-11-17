#!/bin/bash
#Author OMB 

if [ "$1" == "update" ];
then
	rm -rf ~/Cleaner.sh
	git clone https://github.com/su-omb/Cleaner_42.git
	cp ./Cleaner_42/Cleaner.sh ~
	rm -rf ./Cleaner_42
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

