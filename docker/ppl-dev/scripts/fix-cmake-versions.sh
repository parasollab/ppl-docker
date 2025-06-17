#!/bin/bash
# this file written by chatgpt and edited by AY. 
# moves up all cmake_minimum_required and cmake_policy to 3.5 (because that's the minimum...)

# Folder to search (default: current directory)
SEARCH_DIR="${1:-.}"

echo "Scanning for outdated cmake_minimum_required(VERSION ...) and cmake_policy(VERSION ...) in '$SEARCH_DIR'..."

# Use find to locate all relevant files
find "$SEARCH_DIR" -type f \( -name 'CMakeLists.txt' -o -name '*.cmake' \) | while read -r file; do
    while IFS= read -r line || [[ -n "$line" ]]; do
        if [[ "$line" =~ cmake_minimum_required[[:space:]]*\([[:space:]]*VERSION[[:space:]]*([0-9]+)\.([0-9]+) ]]; then
            major="${BASH_REMATCH[1]}"
            minor="${BASH_REMATCH[2]}"
            version_float=$(echo "$major.$minor" | awk '{ printf "%.2f", $0 }')
            if (( $(echo "$version_float < 3.5" | bc -l) )); then
                echo " → Updating $file (was VERSION $version_float)"
                # Replace in-place using sed (back up with .bak)
                sed -i.bak -E "s/(cmake_minimum_required[[:space:]]*\([[:space:]]*VERSION)[[:space:]]*[0-9]+\.[0-9]+/\1 3.5/" "$file"
            fi
        fi



        if [[ "$line" =~ cmake_policy[[:space:]]*\([[:space:]]*VERSION[[:space:]]*([0-9]+)\.([0-9]+) ]]; then
            major="${BASH_REMATCH[1]}"
            minor="${BASH_REMATCH[2]}"
            version_float=$(echo "$major.$minor" | awk '{ printf "%.2f", $0 }')
            if (( $(echo "$version_float < 3.5" | bc -l) )); then
                echo " → Updating $file (was VERSION $version_float)"
                # Replace in-place using sed (back up with .bak)
                sed -i.bak -E "s/(cmake_policy[[:space:]]*\([[:space:]]*VERSION)[[:space:]]*[0-9]+\.[0-9]+/\1 3.5/" "$file"
            fi
        fi
    done < "$file"
done

echo "Done."
