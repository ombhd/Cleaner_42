#!/bin/bash
#Author Omar BOUYKOURNE updated by Anas AAMMARI to support linux
#42login : obouykou, 42login : aaammari


#banner
echo -e	"\n"
echo -e	" 		█▀▀ █▀▀ █░░ █▀▀ ▄▀█ █▄░█ "
echo -e	" 		█▄▄ █▄▄ █▄▄ ██▄ █▀█ █░▀█ "
echo -en "\n    	    	   By: "
echo -e "\033[33mOMBHD\033[0m [𝒐𝒃𝒐𝒖𝒚𝒌𝒐𝒖]\n"

sleep 2

#update
if [ "$1" == "update" ];
then
	tmp_dir=".4yarha"
	if ! git clone --quiet https://github.com/ombhd/Cleaner_42.git "$HOME"/"$tmp_dir" &>/dev/null;
	then
		sleep 0.5
		echo -e "\033[31m\n           -- Couldn't update CCLEAN! :( --\033[0m"
		echo -e "\033[33m\n   -- Maybe you need to change your bad habits XD --\n\033[0m"
		exit 1
	fi
	sleep 1
	if [ "" == "$(diff "$HOME"/Linux_Cleaner_42.sh "$HOME"/"$tmp_dir"/Linux_Cleaner_42.sh)" ];
	then
		echo -e "\033[33m\n -- You already have the latest version of cclean --\n\033[0m"
		/bin/rm -rf "$HOME"/"${tmp_dir:?}"
		exit 0
	fi
	cp -f "$HOME"/"$tmp_dir"/Linux_Cleaner_42.sh "$HOME" &>/dev/null
	/bin/rm -rf "$HOME"/"${tmp_dir:?}" &>/dev/null
	echo -e "\033[33m\n -- cclean has been updated successfully --\n\033[0m"
	exit 0
fi

#calculating the current available storage
Storage=$(df -h "$HOME" | grep -E "$(df "$HOME" | tail -1 | awk '{print $1}')" | awk '{print($4)}')
if [ "$Storage" == "0" ];
then
	Storage="0B"
fi
echo -e "\033[33m\n -- Available Storage Before Cleaning : || $Storage || --\033[0m"

echo -e "\033[31m\n -- Cleaning ...\n\033[0m "

should_log=0
if [[ "$1" == "-p" || "$1" == "--print" ]]; then
	should_log=1
fi

function clean_glob {
	# don't do anything if argument count is zero (unmatched glob).
	if [ -z "$1" ]; then
		return 0
	fi

	if [ $should_log -eq 1 ]; then
		for arg in "$@"; do
			du -sh "$arg" 2>/dev/null
		done
	fi

	/bin/rm -rf "$@" &>/dev/null

	return 0
}

function clean {
	# to avoid printing empty lines
	# or unnecessarily calling /bin/rm
	# we resolve unmatched globs as empty strings.
	shopt -s nullglob

	echo -ne "\033[38;5;208m"

	#42 Caches
	clean_glob "$HOME"/.42*
	clean_glob "$HOME"/.zcompdump*

	#Trash
	clean_glob "$HOME"/.local/share/Trash/files/*
	clean_glob "$HOME"/.local/share/Trash/info/*

	#General Cache files
	clean_glob "$HOME"/.cache/*

	#Package manager caches
	clean_glob "$HOME"/.cache/pip/*
	clean_glob "$HOME"/.npm/_cacache/*
	clean_glob "$HOME"/.yarn/cache/*
	clean_glob "$HOME"/.cargo/registry/cache/*
	clean_glob "$HOME"/.gem/ruby/*/cache/*

	#Browser Caches - Firefox
	clean_glob "$HOME"/.var/app/org.mozilla.firefox/cache/*
	clean_glob "$HOME"/.var/app/org.mozilla.firefox/.mozilla/firefox/Crash Reports/*
	clean_glob "$HOME"/.var/app/org.mozilla.firefox/.mozilla/firefox/*.default*/cache2/*
	clean_glob "$HOME"/.var/app/org.mozilla.firefox/.mozilla/firefox/*.default*/startupCache/*
	clean_glob "$HOME"/.var/app/org.mozilla.firefox/.mozilla/firefox/*.default*/OfflineCache/*



	#Browser Caches - Chrome/Chromium
	clean_glob "$HOME"/.cache/google-chrome/Default/Cache/*
	clean_glob "$HOME"/.var/app/com.google.Chrome/cache/*
	clean_glob "$HOME"/.var/app/com.google.Chrome/config/google-chrome/Default/Service\ Worker/CacheStorage/*
	clean_glob "$HOME"/.var/app/com.google.Chrome/config/google-chrome/Default/Application\ Cache/*
	clean_glob "$HOME"/.var/app/com.google.Chrome/config/google-chrome/Default/File\ System
	clean_glob "$HOME"/.var/app/com.google.Chrome/config/google-chrome/Profile\ [0-9]/Service\ Worker/CacheStorage/*
	clean_glob "$HOME"/.var/app/com.google.Chrome/config/google-chrome/Profile\ [0-9]/Application\ Cache/*
	clean_glob "$HOME"/.var/app/com.google.Chrome/config/google-chrome/Profile\ [0-9]/File\ System

	#Browser Caches - Brave
	clean_glob "$HOME"/.var/app/com.brave.Browser/cache/*
	clean_glob "$HOME"/.var/app/com.brave.Browser/config/BraveSoftware/Brave-Browser/Default/Service\ Worker/CacheStorage/*
	clean_glob "$HOME"/.var/app/com.brave.Browser/config/BraveSoftware/Brave-Browser/Default/Application\ Cache/*
	clean_glob "$HOME"/.var/app/com.brave.Browser/config/BraveSoftware/Brave-Browser/Default/File\ System
	clean_glob "$HOME"/.var/app/com.brave.Browser/config/BraveSoftware/Brave-Browser/Profile\ [0-9]/Service\ Worker/CacheStorage/*
	clean_glob "$HOME"/.var/app/com.brave.Browser/config/BraveSoftware/Brave-Browser/Profile\ [0-9]/Application\ Cache/*
	clean_glob "$HOME"/.var/app/com.brave.Browser/config/BraveSoftware/Brave-Browser/Profile\ [0-9]/File\ System
	clean_glob "$HOME"/.cache/brave/Default/Cache/*


	#Application Caches
	clean_glob "$HOME"/.var/app/com.visualstudio.code/cache/*
	clean_glob "$HOME"/.var/app/com.visualstudio.code/config/Code/Cache/*
	clean_glob "$HOME"/.var/app/com.visualstudio.code/config/Code/CachedData/*
	clean_glob "$HOME"/.var/app/com.visualstudio.code/config/Code/User/workspaceStorage/*
	clean_glob "$HOME"/.var/app/com.visualstudio.code/config/Code/Crashpad/completed/*
	clean_glob "$HOME"/.vscode/extensions/*/node_modules/*
	clean_glob "$HOME"/.var/app/com.discordapp.Discord/cache/*
	clean_glob "$HOME"/.var/app/com.discordapp.Discord/config/discord/Cache/*
 	clean_glob "$HOME"/.var/app/com.discordapp.Discord/config/discord/Code\ Cache/js*
 	clean_glob "$HOME"/.var/app/com.discordapp.Discord/config/discord/Crashpad/completed/*


	clean_glob "$HOME"/.var/app/com.slack.Slack/cache/*
	clean_glob "$HOME"/.var/app/com.slack.Slack/config/Slack/Cache/*
	clean_glob "$HOME"/.var/app/com.slack.Slack/config/Slack/Service\ Worker/CacheStorage/*
	clean_glob "$HOME"/.var/app/com.slack.Slack/config/Slack/Crashpad/completed/*
    clean_glob "$HOME"/.var/app/com.spotify.Client/cache/*
    clean_glob "$HOME"/.var/app/com.spotify.Client/config/spotify/PersistentCache/*

	#.DS_Store files
	clean_glob "$HOME"/Desktop/**/*/.DS_Store

	#Thumbnails
	clean_glob "$HOME"/.cache/thumbnails/*
	clean_glob "$HOME"/.thumbnails/*

	#Temporary files
 	clean_glob $(find /tmp -type f -user "$USER" 2>/dev/null)


	#Things related to pool (piscine)
	clean_glob "$HOME"/Desktop/Piscine\ Rules\ *.mp4
	clean_glob "$HOME"/Desktop/PLAY_ME.webloc

    # Docker user caches
    clean_glob "$HOME"/.docker/*/cache/*

	echo -ne "\033[0m"
}

clean

if [ $should_log -eq 1 ]; then
	echo
fi

#calculating the new available storage after cleaning
Storage=$(df -h "$HOME" | grep -E "$(df "$HOME" | tail -1 | awk '{print $1}')" | awk '{print($4)}')
if [ "$Storage" == "0" ];
then
	Storage="0B"
fi
sleep 1
echo -e "\033[32m -- Available Storage After Cleaning : || $Storage || --\n\033[0m"

echo -e	"\n	       report any issues to me in:"
echo -e	"		   GitHub   ~> \033[4;1;34mombhd\033[0m"
echo -e	"	   	   42 Slack ~> \033[4;1;34mobouykou\033[0m\n"
