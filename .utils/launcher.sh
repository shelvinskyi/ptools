#!/usr/bin/env bash

PAPERS_DIR=$HOME"/papers"

declare -A LABELS
declare -A COMMANDS

# websites
declare -A URLS=(
    ["github"]="firefox https://github.com/shelvinskyi?tab=repositories"
    ["kaggle"]="firefox https://www.kaggle.com/competitions"
    ["twitter"]="firefox https://twitter.com/home"
    ["reddit"]="firefox https://www.reddit.com/"
    ["pocket"]="firefox https://app.getpocket.com"
    ["linkedin"]="firefox https://www.linkedin.com/"
    ["gmail"]="firefox https://mail.google.com/mail/u/0/"
    ["protonmail"]="firefox https://mail.protonmail.com/"
    ["leetcode"]="firefox https://leetcode.com/"
    ["emojipedia"]="firefox https://emojipedia.org/"
    ["flaticon"]="firefox https://www.flaticon.com/home"
    ["outloud gcloud console"]="firefox https://console.cloud.google.com/home/dashboard?project=outlo    ud-website&_ga=2.48919535.85313893.1587049583-736879928.1585176025&_gac=1.50455259.1587056673.CjwKCAjwhOD    0BRAQEiwAK7JHmGQA-tzZ_KutMc9kGrRHYxX8eYts0PtO1_rCFDNd_fwJ3BC1htsiZRoCdRsQAvD_BwE"
    ["outloud gcloud meet"]="firefox https://meet.google.com/?authuser=1"
    ["outloud gcloud billing"]="firefox https://console.cloud.google.com/billing/0102AC-EA65B2-8EBFBB"
    ["outloud trello"]="firefox https://trello.com/b/1bR2cThf/project-launch"
    ["outloud gmail"]="firefox https://mail.google.com/mail/u/1/#inbox"
    ["outloud gdrive"]="firefox https://drive.google.com/drive/u/1/my-drive"
    ["repo Abstract reasoning corpus ARC"]="firefox https://github.com/fchollet/ARC"
    ["repo wav2letter++"]="firefox https://github.com/facebookresearch/wav2letter"
    ["repo transofrmers"]="firefox https://github.com/huggingface/transformers"
    ["gcalendar"]="firefox https://calendar.google.com/calendar/r/month"
    ["mangadex"]="firefox https://mangadex.org/follows/manga/0"
    ["youtube"]="firefox https://www.youtube.com/"
    ["netflix"]="firefox netflix"
    ["crunchyroll"]="firefox https://crunchyroll.com/en-gb/videos/anime"
    ["outloud gsuite calendar"]="firefox https://calendar.google.com/calendar/b/1/r?tab=oc"
    ["covid19 Ukraine"]="firefox https://app.powerbi.com/view?r=eyJrIjoiN2M1MTY1MDktZTY5Mi00OTE0LWFiM    DAtMjM4NTY0YWU2MmI3IiwidCI6IjI4OGJmYmNmLTVhYjItNDk2MS04YTM5LTg2MDYxYWFhY2Q4NiIsImMiOjl9"
    ["covid19 UK"]="firefox https://coronavirus.data.gov.uk/"
    ["covid19 FT"]="firefox https://www.ft.com/coronavirus-latest"
    ["covid9 BBC"]="firefox https://www.bbc.co.uk/news/coronavirus"
)

for key in "${!URLS[@]}"
do
  COMMANDS["$key"]="${URLS[$key]}"
  LABELS["$key"]="url"
done

# commands
declare -A SHELLS=(
    ["ipython calc"]="urxvt -e ipython"
    ["notes"]="urxvt -e vim ~/notes/notes.org"
    ["alsamixer"]="urxvt -e alsamixer"
    ["htop"]="urxvt -e htop"
)
for key in "${!SHELLS[@]}"
do
  COMMANDS["$key"]="${SHELLS[$key]}"
  LABELS["$key"]="shell"
done

# letters ы|э|ъ|Ы|Э|Ъ
declare -a SYMB=("ы" "э" "ъ" "Ы" "Э" "Ъ")
for l in "${SYMB[@]}"
do
    COMMANDS["літера $l"]="echo -n '$l' | xclip -selection c"
    LABELS["літера $l"]="symb"
done

# papers
for filename in $PAPERS_DIR/*.pdf
do
    name=$(basename "$filename")
    COMMANDS["$name"]="mupdf \"${filename}\""
    LABELS["$name"]="paper"
done

# files
declare -A FILES=(
    ["launcher.sh"]="urxvt -e vim ~/.utils/launcher.sh"
    [".bashrc"]="urxvt -e vim ~/.bashrc"
    [".vimrc"]="urxvt -e vim ~/.vimrc"
    ["rc.lua"]="urxvt -e vim ~/.config/awesome/rc.lua"
)
for key in "${!FILES[@]}"
do
  COMMANDS["$key"]="${FILES[$key]}"
  LABELS["$key"]="edit"
done

# envs
declare -A ENVS=(
    ["outloud-website"]="code ~/dev/outloud-website"
)
for key in "${!ENVS[@]}"
do
  COMMANDS["$key"]="${ENVS[$key]}"
  LABELS["$key"]="env"
done



# === party! ===

function print_menu()
{
    for key in "${!LABELS[@]}"
    do
      echo "${LABELS[$key]}@|@$key"
    done
}

if [[ -z "$@" ]]
then
  print_menu | column -s '@' -t
  exit 0
else
  value="$(echo "$1" | tr -d '\n')"
  choice="$(echo ${value/*| } | awk '{$1=$1};1')"
  if [[ "${COMMANDS[$choice]+isset}" ]]
  then
    coproc ( eval "${COMMANDS[$choice]}" )
    exit 0
  fi
fi
