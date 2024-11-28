#!/bin/bash

# Cleaning Configuration
export MIN_FILE_AGE=7          # Days
export MIN_FREE_SPACE=1024     # MB
export MAX_CACHE_SIZE=5120     # MB
export BACKUP_BEFORE_CLEAN=1   # 1=yes, 0=no

# Logging Configuration
export LOG_FILE="$HOME/.cleaner42.log"
export LOG_LEVEL="INFO"        # DEBUG, INFO, WARN, ERROR

# Safety Configuration
export SAFE_MODE=1             # 1=ask before deleting, 0=delete without asking
export MAX_DELETE_SIZE=1024    # MB - Maximum size to delete without confirmation

# Excluded Directories (Don't clean these)
declare -a EXCLUDED_PATHS=(
    "$HOME/Desktop"
    "$HOME/Documents"
    "$HOME/Pictures"
    "$HOME/Movies"
    "$HOME/Music"
    "$HOME/.ssh"
    "$HOME/.gnupg"
)

# File Age Thresholds (in days)
declare -A FILE_AGE_THRESHOLDS=(
    ["downloads"]=7
    ["cache"]=30
    ["logs"]=14
    ["temp"]=3
)