#!/bin/sh
mkdir -p /tmp/flashot

if [ -d /tmp/flashot ]; then
  photoname=$(ls /tmp/flashot | cut -d- -f1 | uniq | dmenu -i -p "name of screenshots? (no hyphens)")
else
  photoname=$(dmenu -i -p "name of screenshots? (no hyphens)")
fi

case "$photoname" in
  *-* )
    printf "ok" | dmenu -p "not a valid name (no hyphens!)"
    exit 1
    ;;
  final )
    printf "ok" | dmenu -p "not a valid name (don't call it \"final\")"
    exit 1
    ;;
esac

photonumber=$(basename -a $(ls /tmp/flashot/"$photoname"* 2>/dev/null) 2>/dev/null | cut -d- -f2 | uniq | tac | dmenu -i -p "number?")

type=$(printf "question\nanswer" | dmenu -i -p "question or answer?")
if [ "$type" = "question" ]; then
  type=q
else
  type=a
fi

partnumber=$(ls /tmp/flashot/"$photoname"-"$photonumber"-"$type"-* 2>/dev/null | tail -n1 | cut -d- -f4 | cut -d. -f1)
if [ -z "$partnumber" ]; then
  partnumber=0
else
  partnumber=$(printf "%s+1\n" "$partnumber" | bc)
fi

scrot -s /tmp/flashot/"$photoname"-"$photonumber"-"$type"-"$partnumber".png
