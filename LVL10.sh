#!/bin/bash

#**Mission**: Write a script that:
#1. Creates a directory called Arena_Boss.
#2. Creates 5 text files inside the directory, named file1.txt to file5.txt.
#3. Generates a random number of lines (between 10 and 20) in each file.
#4. Sorts these files by their size and displays the list.
#5. Checks if any of the files contain the word 'Victory', and if found, moves the file to a directory called Victory_Archive.'

set -euo pipefail

mkdir -p "$HOME/projects/Arena_Boss" "$HOME/projects/Victory_Archive"
Arena="$HOME/projects/Arena_Boss"
Archive="$HOME/projects/Victory_Archive"
touch "$Arena"/file{1..5}.txt

for f in "$Arena"/file{1..5}.txt; do
	N=$(( RANDOM % 11 + 10 ))
	seq "$N" > "$f"
done

for f in "$Arena"/file{1..5}.txt; do
  (( RANDOM % 2 )) && echo "Victory" >> "$f"
done

ls -l "$Arena"/*.txt | sort -k 5 -n | awk '{print $5 $9}'

if grep -q 'Victory' "$Arena"/*.txt 2>/dev/null; then
  grep -l 'Victory' "$Arena"/*.txt 2>/dev/null | while IFS= read -r f; do
    mv -- "$f" "$Archive"/
    echo "Moved: $f"
  done
fi

