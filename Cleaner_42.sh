#!/bin/bash

# Simple logging function that doesn't conflict with system log command
log_message() {
    local level="$1"
    local message="$2"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $message"
}

# Function to format sizes in human-readable format
format_size() {
    local size=$1
    if [[ $size -gt 1073741824 ]]; then
        echo "$(( size / 1073741824 ))G"
    elif [[ $size -gt 1048576 ]]; then
        echo "$(( size / 1048576 ))M"
    elif [[ $size -gt 1024 ]]; then
        echo "$(( size / 1024 ))K"
    else
        echo "${size}B"
    fi
}

# Function to analyze space usage
analyze_space() {
    local dir="$1"
    echo -e "\n📊 Space Analysis for $dir"
    echo "----------------------------------------"
    du -sh "$dir"/* 2>/dev/null | sort -hr | head -n 10 | while read -r size path; do
        echo "📁 $size    ${path##*/}"
    done
    echo "----------------------------------------"
}

# Main cleaning function
main_clean() {
    # Show initial space
    echo -e "\n🔍 Initial Disk Usage:"
    df -h "$HOME" | awk 'NR==1{print} NR==2{print}' | column -t

    # Analyze space before cleaning
    analyze_space "$HOME"

    # Clean garbage files (example paths)
    echo -e "\n🧹 Cleaning unnecessary files..."
    
    # Array of paths to clean
    local paths_to_clean=(
        "$HOME/Library/Caches/*"
        "$HOME/Library/Logs/*"
        "$HOME/Downloads/*.o"
        "$HOME/Downloads/*.out"
        "$HOME/**/*.dSYM"
    )

    # Clean each path
    for path in "${paths_to_clean[@]}"; do
        if ls $path >/dev/null 2>&1; then
            rm -rf $path 2>/dev/null
            echo "✨ Cleaned: $path"
        fi
    done

    # Show final space
    echo -e "\n📈 Final Disk Usage:"
    df -h "$HOME" | awk 'NR==1{print} NR==2{print}' | column -t

    # Calculate and show space saved
    local initial_used=$(df -k "$HOME" | awk 'NR==2{print $3}')
    local final_used=$(df -k "$HOME" | awk 'NR==2{print $3}')
    local saved=$((initial_used - final_used))
    
    echo -e "\n🎉 Cleanup Complete!"
    echo "💾 Space saved: $(format_size $saved)"
}

# Run the script
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo -e "\n🚀 Starting Cleaner_42..."
    main_clean
fi