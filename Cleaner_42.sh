#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

#banner
echo -e	"\n"
echo -e	" 		█▀▀ █▀▀ █░░ █▀▀ ▄▀█ █▄░█ "
echo -e	" 		    NEWSCHOOL CEANER"
echo -en "\n    	    	   By: "
echo -e "\033[33msel-hano\033[0m [Saif Eddine]\n"

sleep 2

#update
if [ "$1" == "update" ];
then
	tmp_dir=".tempdirectory"
	if ! git clone --quiet https://github.com/saifeddineelhanoune/Cleaner_42.git "$HOME"/"$tmp_dir" &>/dev/null;
	then
		sleep 0.5
		echo -e "\033[31m\n           -- Couldn't update CLEANER! :( --\033[0m"
		exit 1
	fi
	sleep 1
	if [ "" == "$(diff "$HOME"/Cleaner_42.sh "$HOME"/"$tmp_dir"/Cleaner_42.sh)" ]; then
		echo -e "\033[33m\n -- already up to date --\n\033[0m"
		rm -rf "$HOME"/"${tmp_dir:?}"
		exit 0
	fi
	cp -f "$HOME"/"$tmp_dir"/Cleaner_42.sh "$HOME" &>/dev/null
	rm -rf "$HOME"/"${tmp_dir:?}" &>/dev/null
	echo -e "\033[33m\n -- cleaner has been updated successfully --\n\033[0m"
	exit 0
fi

#calculating the current available storage
Storage=$(df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B')
if [ "$Storage" == "0BB" ]; then
	Storage="0B"
fi
echo -e "\033[33m\n -- Available Storage Before Cleaning : || $Storage || --\033[0m"

echo -e "\033[31m\n -- Cleaning ...\n\033[0m "


should_log=0
if [[ "$1" == "-p" || "$1" == "--print" ]]; then
	should_log=1
fi

function clean_glob {
    # Exit if no arguments provided
    if [ $# -eq 0 ]; then
        return 0
    fi

    local exit_code=0
    
    for path in "$@"; do
        # Check if path exists
        if [ ! -e "$path" ]; then
            continue
        fi

        # Check if we have permission to remove
        if [ ! -w "$path" ]; then
            echo "Warning: No permission to remove $path" >&2
            exit_code=1
            continue
		fi

        # Check available disk space before operation
        local df_output
        df_output=$(df -P "$(dirname "$path")" | awk 'NR==2 {print $4}')
        if [ "$df_output" -lt 1024 ]; then
            echo "Error: Not enough disk space to perform cleanup" >&2
            return 1
        fi

        if [ $should_log -eq 1 ]; then
            du -sh "$path" 2>/dev/null
        fi

        # Use timeout to prevent hanging
        timeout 30 /bin/rm -rf "$path" 2>/dev/null || {
            echo "Error: Failed to remove $path (timeout)" >&2
            exit_code=1
        }
    done

    return $exit_code
}

function clean {
	# to avoid printing empty lines
	# or unnecessarily calling /bin/rm
	# we resolve unmatched globs as empty strings.
	shopt -s nullglob

	echo -ne "\033[38;5;208m"

	#removing all library others than Caches
	clean_glob "$HOME"/Library/*
	clean_glob "$HOME"/*.42*
	clean_glob "$HOME"/.zcompdump*
	clean_glob "$HOME"/.cocoapods.42_cache_bak*
	clean_glob "$HOME"/.cocoapods.42_cache_bak*
	clean_glob "$HOME"/.Trash/*


	#General Caches files
	#giving access rights on Homebrew caches, so the script can delete them
	/bin/chmod -R 777 "$HOME"/Library/Caches/Homebrew &>/dev/null
	clean_glob "$HOME"/Library/Caches/*
	clean_glob "$HOME"/Library/Application\ Support/Caches/*

	#Slack, VSCode, Discord and Chrome Caches
	clean_glob "$HOME"/Library/Application\ Support/Slack/Service\ Worker/CacheStorage/*
	clean_glob "$HOME"/Library/Application\ Support/Slack/Cache/*
	clean_glob "$HOME"/Library/Application\ Support/discord/Cache/*
	clean_glob "$HOME"/Library/Application\ Support/discord/Code\ Cache/js*
	clean_glob "$HOME"/Library/Application\ Support/discord/Crashpad/completed/*
	clean_glob "$HOME"/Library/Application\ Support/Code/Cache/*
	clean_glob "$HOME"/Library/Application\ Support/Code/CachedData/*
	clean_glob "$HOME"/Library/Application\ Support/Code/Crashpad/completed/*
	clean_glob "$HOME"/Library/Application\ Support/Code/User/workspaceStorage/*
	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Service\ Worker/CacheStorage/*
	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Default/Service\ Worker/CacheStorage/*
	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Application\ Cache/*
	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Default/Application\ Cache/*
	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Crashpad/completed/*

	#.DS_Store files
	clean_glob "$HOME"/Desktop/**/*/.DS_Store

	#tmp downloaded files with browsers
	clean_glob "$HOME"/Library/Application\ Support/Chromium/Default/File\ System
	clean_glob "$HOME"/Library/Application\ Support/Chromium/Profile\ [0-9]/File\ System
	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Default/File\ System
	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/File\ System

	#things related to pool (piscine)
	clean_glob "$HOME"/Desktop/Piscine\ Rules\ *.mp4
	clean_glob "$HOME"/Desktop/PLAY_ME.webloc

	echo -ne "\033[0m"
}
clean

if [ $should_log -eq 1 ]; then
	echo
fi

#calculating the new available storage after cleaning
Storage=$(df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B')
if [ "$Storage" == "0BB" ];
then
	Storage="0B"
fi
sleep 1
echo -e "\033[32m -- Available Storage After Cleaning : || $Storage || --\n\033[0m"

echo -e	"\n	       report any issues to me in:"
echo -e	"		   GitHub   ~> \033[4;1;34mombhd\033[0m"
echo -e	"	   	   42 Slack ~> \033[4;1;34mobouykou\033[0m\n"

#installer
