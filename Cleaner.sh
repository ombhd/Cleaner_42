#!/bin/bash
#Author OMB 

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
rm -rf ~/.zcompdump*
find ~/Desktop -name .DS_Store -depth -exec rm {} \;

Storage=$(df -h . | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B')
if [ "$Storage" == "0BB" ];
then
	Storage="0B"
fi
echo -e "\033[32m -- Available Storage After Cleaning : || $Storage || --\n\033[0m"

