#!/bin/bash
theme=$(echo "#prompt { background-color: #323F4E; }" "*{font: \"Roboto Mono 20\";}")

query=$(rofi -dmenu -p " /yt/gh/lmap/manga]" -lines 0 -theme-str "$theme")
q=${query:2}

echo $query
if [[ -z "$query" ]]
then
    exit;
elif [[ "$query" = "y "* ]]
then
  firefox "https://www.youtube.com/results?search_query=${q/ /+}"
elif [[ "$query" = "g "* ]]
then
  firefox "https://github.com/search?q=${q/ /+}"
elif [[ "$query" = "l "* ]]
then
  firefox "https://www.google.com/maps/search/${q/ /+}"
elif [[ "$query" = "m "* ]]
then
  firefox "https://mangadex.org/search?title=${q/ /%20}"
else
  firefox "https://www.google.com/search?q=$query" 
fi
