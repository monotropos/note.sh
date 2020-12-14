#!/usr/bin/env bash

set -euo pipefail

if [ -z ${NOTE_DIR+x} ]; then
  echo "Error: Please configure and export NOTE_DIR environment variable."
  exit 1
fi

function usage() {
  echo "Usage: note.sh [action]"
  echo
  echo "  actions:"
  echo "    add [new note in quotes to add at end of today-file]"
  echo "    grep [pattern]"
}

mkdir -p "$NOTE_DIR"
TODAYFILE="$NOTE_DIR/$(date +'%Y-%m-%d').md"


if [ $# -eq 0 ]; then
    $EDITOR "$TODAYFILE"
else
  case $1 in
    grep)
      grep -i -r --color "$2" "$NOTE_DIR"
      ;;
	add)
	  echo "$2" >> "$TODAYFILE"
	  ;;
    *)
      usage
      ;;
  esac
fi
