#!/bin/bash
#
# Fonctions d'affichage


BOOTUP=color
RES_COL=60
MOVE_TO_COL="echo -en \\033[300C\\033[$[${COLUMNS}-${RES_COL}]D"
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_BLEU="echo -en \\033[1;34m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_WARNING="echo -en \\033[1;33m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
LOGLEVEL=1

SETCOLOR_WARNING="echo -en \\033[1;33m"
SETCOLOR_RED="echo -en \\033[1;31m"
SETCOLOR_VERT="echo -en \\033[1;32m"
SETCOLOR_CYAN="echo -en \\033[1;36m"
SETCOLOR_MAGENTA="echo -en \\033[1;35m"

echo_success() {
  [ "$BOOTUP" = "color" ] && $MOVE_TO_COL
  echo -n "[  "
  [ "$BOOTUP" = "color" ] && $SETCOLOR_SUCCESS
  echo -n "OK"
  [ "$BOOTUP" = "color" ] && $SETCOLOR_NORMAL
  echo -n "  ]"
  return 0
}

echo_red () {
  $SETCOLOR_RED
  echo -ne "$1"
  $SETCOLOR_NORMAL
  echo ""
  return 0	
}

echo_bleu () {
  	$SETCOLOR_BLEU
  	echo -ne "$1"
  	$SETCOLOR_NORMAL
  	echo ""
  	return 0	
}

echo_vert () {
 	$SETCOLOR_VERT
  	echo -ne "$1"
  	$SETCOLOR_NORMAL
  	echo ""
  	return 0	
}

echo_cyan () {
 	$SETCOLOR_CYAN
  	echo -ne "$1"
  	$SETCOLOR_NORMAL
  	echo ""
  	return 0	
}

echo_magenta () {
	$SETCOLOR_MAGENTA
	echo -ne "$1"
	$SETCOLOR_NORMAL
	echo ""
	return 0
}

