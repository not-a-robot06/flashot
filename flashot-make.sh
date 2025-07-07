#!/bin/sh
combine() {
  for name in $(ls | cut -d- -f1-2 | uniq | sed 's/final//'); do
    magick "$name"-q* -append final/"$name"-0.png
    magick "$name"-a* -append final/"$name"-1.png
  done
}

cards_txt() {
  for name in $(ls *.png | cut -d- -f1 | uniq); do
    old_card=-1
    for file in "$name"*; do
      card=$(printf "$file" | cut -d- -f2 | cut -d. -f1)
      if [[ "$card" = "$old_card" ]]
      then
        echo "$file\"/>;Card_$card" >> cards.txt
      else
        printf "<img src=\"%s\"/>;<img src=\"" "$file" >> cards.txt
      fi
      old_card=$card
    done
  done
}

if [ -z "$FLASHOT_ANKI_USER" ]; then FLASHOT_ANKI_USER=Main; fi


# main
action=$(printf "make flashcards\nreset" | dmenu -i -p "action?")
if [ "$action" = "make flashcards" ]; then
  confirm=$(printf "no\nyes" | dmenu -i -p "are you sure? screenshot names can overwrite others in media folder")
  if [ "$confirm" = "yes" ]; then
    if [ -d /tmp/flashot/final ]; then rm -rf /tmp/flashot/final; fi
    cd /tmp/flashot
    mkdir -p final
    combine
    cd final
    cards_txt
    cp *.png ~/.local/share/Anki2/"$FLASHOT_ANKI_USER"/collection.media/
    anki /tmp/flashot/final/cards.txt &
  fi
elif [ "$action" = "reset" ]; then
  confirm=$(printf "no\nyes" | dmenu -i -p "are you sure? this action cannot be undone")
  if [ "$confirm" = "yes" ]; then
    rm -rf /tmp/flashot/
  fi
fi
