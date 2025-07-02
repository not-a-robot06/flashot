#!/bin/sh
mkdir -p /tmp/question_shots
photoname=$(ls /tmp/question_shots | cut -d_ -f1 | uniq | dmenu -i -p "name of screenshots? (no underscores or hyphens)")
echo "$photoname"
photonumber=$(basename -a $(ls /tmp/question_shots/"$photoname"*) | cut -d_ -f2 | cut -d- -f1 | uniq | tac | dmenu -i -p "number?")

type=$(echo "question\nanswer" | dmenu -i -p "question or answer?")
if [ "$type" = "question" ]; then
  type=q
else
  type=a
fi

partnumber=$(ls /tmp/question_shots/"$photoname"_"$photonumber"-"$type"-* | tail -n1 | cut -d- -f3 | cut -d. -f1)
if [ -z "$partnumber" ]; then
  partnumber=0
else
  partnumber=$(echo "$partnumber"+1 | bc)
fi

scrot -s /tmp/question_shots/"$photoname"_"$photonumber"-"$type"-"$partnumber".png
