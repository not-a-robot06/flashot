#!/bin/bash
# file prefixes cant have underscores or dashes in their names
if [ $(ls cards.txt) ]; then
  rm cards.txt
fi

for name in $(ls *.png | cut -d- -f1 | uniq); do
  old_card=-1
  for file in "$name"*; do
    echo "file = $file"
    card=$(echo "$file" | cut -d_ -f2 | cut -d- -f1)
    echo "card = $card"
    if [[ "$card" = "$old_card" ]]
    then
      echo "$file\"/>;Card_$card" >> cards.txt
    else
      # TODO: use printf as echo -n is not portable
      /bin/echo -n "<img src=\"$file\"/>;<img src=\"" >> cards.txt
    fi
    old_card=$card
  done
done
