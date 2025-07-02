#!/bin/sh
action=$(echo "make flashcards\nreset" | dmenu -i -p "action?")
if [ "$action" = "make flashcards" ]; then
  confirm=$(echo "no\nyes" | dmenu -i -p "are you sure? screenshot names can overwrite others in media folder")
  if [ "$confirm" = "yes" ]; then
    cd /tmp/question_shots
    combine.sh
    cd final
    cards.sh
    cp *.png ~/.local/share/Anki2/Main/collection.media/
    thunar /tmp/question_shots/final &
    echo "yay" | dmenu -p "done! import cards.txt into Anki. remember to reset if done"
  fi
elif [ "$action" = "reset" ]; then
  confirm=$(echo "no\nyes" | dmenu -i -p "are you sure? this action cannot be undone")
  if [ "$confirm" = "yes" ]; then
    rm -rf /tmp/question_shots/
  fi
fi
