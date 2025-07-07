# flashot
make flashcards out of screenshots, without any manual dragging and dropping!
multiple screenshots for one side of a flashcard? no problem!

very useful for turning exam paper questions and answers into flashcards,
effortlessly

## demo
![](demo.mp4)

## usage
### flashot.sh
- will prompt for name of flashcard collection
- then prompts for number and type of card, then allows you to take a
  screenshot
- no environment variables or commandline arguments

### flashot-make.sh
- prompts to combine screenshots and import into anki, or to remove all current
  screenshots
- environment variable `FLASHOT_ANKI_USER` defines which anki user to copy
  screenshots to; default is "Main"

## dependencies
- *nix system with X (wayland support later?)
- [Anki](https://apps.ankiweb.net/)
- bc
- coreutils
- [dmenu](https://tools.suckless.org/dmenu/)
- [ImageMagick](https://www.imagemagick.org/)
- [scrot](https://github.com/resurrecting-open-source-projects/scrot)
