#!/usr/bin/env bash

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

# party

function print_menu()
{
    for key in "${!LABELS[@]}"
    do
      echo "<span weight='heavy'>${LABELS[$key]}</span>|$key"
    done
}

function start()
{
    print_menu | column -s '|' -t | rofi -dmenu -p "stuff" -markup-rows | tr -d '\n'
}


# Run it
value="$(start)"
choice=$(echo ${value/*span> } | awk '{$1=$1};1')
if test ${COMMANDS["$choice"]+isset}
then
    eval ${COMMANDS[$choice]}
fi
