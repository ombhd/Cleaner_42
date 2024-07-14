#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

#update
if [ "$1" == "update" ];
then
    current_file="$HOME/.ccc"
	tmp_file="/tmp/.update.tmp"
	if ! curl -s https://raw.githubusercontent.com/ombhd/Cleaner_42/main/Cleaner_42.sh -o $tmp_file; then
		echo -e "\033[31m\n -- Failed to update cclean --\n\033[0m"
        echo -e "\033[31m\n -- Troubleshoot the issue or you can still use the current version --\n\033[0m"
        exit 1
	fi

    if diff -g $current_file /tmp/$tmp_file >/dev/null; then
        echo -e "\033[33m\n -- cclean is already up to date --\n\033[0m"
        exit 0
    fi

	cp -f $tmp_file $current_file
	/bin/rm -f $tmp_file
	echo -e "\033[33m\n -- cclean has been updated successfully --\n\033[0m"
	exit 0
fi
#calculating used storage
befor=$(df -h $HOME | tail -n 1 | awk '{print($5)}')
# Storage=$(df -h "$HOME" | tail -n 1 | awk '{print($5)}')÷

# set the default value of should_log to 0
should_log=0
if [[ "$1" == "-p" || "$1" == "--print" ]]; then
	should_log=1
fi

# function to clean the matched globs
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

# clean
function clean {
	# to avoid printing empty lines
	# or unnecessarily calling /bin/rm
	# we resolve unmatched globs as empty strings.
	shopt -s nullglob

	echo -ne "\033[38;5;208m"

	#42 Caches
	clean_glob "$HOME"/Library/*.42*
	clean_glob "$HOME"/*.42*
	clean_glob "$HOME"/.zcompdump*
	clean_glob "$HOME"/.cocoapods.42_cache_bak*

	#Trash
	clean_glob "$HOME"/.Trash/*

	#General Caches files
	clean_glob "$HOME"/Library/Caches/*
	clean_glob "$HOME"/Library/Application\ Support/Caches/*
    clean_glob "$HOME"/Library/Application\ Support/Google/*
    clean_glob "$HOME"/Library/Application\ Support/Mozilla/*
    clean_glob "$HOME"/Library/Application\ Support/Firefox/*
    clean_glob "$HOME"/Library/Application\ Support/CrashReporter/*
    clean_glob "$HOME"/Library/Caches/Google/*
    clean_glob "$HOME"/Library/Caches/Firefox/*
    clean_glob "$HOME"/Library/Caches/Mozilla/*
    clean_glob "$HOME"/Library/Caches/com.apple.Music/*
    clean_glob "$HOME"/Library/Caches/com.apple.appstore/*
    clean_glob "$HOME"/Library/Caches/com.apple.appstoreagent/*
    clean_glob "$HOME"/Library/Caches/com.apple.commerce/*
    clean_glob "$HOME"/Library/Caches/com.apple.iTunes/*

	#, VSCode Caches
	clean_glob "$HOME"/Library/Application\ Support/Code/Cache/*
	clean_glob "$HOME"/Library/Application\ Support/Code/CachedData/*
	clean_glob "$HOME"/Library/Application\ Support/Code/Crashpad/completed/*
	clean_glob "$HOME"/Library/Application\ Support/Code/User/workspaceStorage/*

	#.DS_Store files
	clean_glob "$HOME"/Desktop/**/*/.DS_Store

	#tmp downloaded files with browsers
	clean_glob "$HOME"/Library/Application\ Support/Chromium/Default/File\ System
	clean_glob "$HOME"/Library/Application\ Support/Chromium/Profile\ [0-9]/File\ System
	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Default/File\ System
	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/File\ System

	echo -ne "\033[0m"
}
clean

if [ $should_log -eq 1 ]; then
	echo
fi

after=$(df -h $HOME | tail -n 1 | awk '{print($5)}')

Author="OMBHD [𝒐𝒃𝒐𝒖𝒚𝒌𝒐𝒖]"
Prettier="\033[38;5;45;4;5;10m"
Redheart="\033[38;5;196m❤️\033[0m"
Unpretteir="\033[0m"

echo -e $Prettier"Used: ($befor) -> ($after), $(( ${befor%?} - ${after%?} ))% cleaned!"$Unpretteir
for i in {1..10} ; do
	echo -ne "▪"
	sleep 0.1
done
echo -e " Made with $Redheart by $Author"$Unpretteir
