export PATH="$PATH:/home/dawson/dart/dart-sdk/bin:/opt/local/bin:/opt/local/sbin:~/bin:~/.gem/ruby/2.0.0/bin:/opt/android-sdk:/opt/android-sdk/tools:/opt/android-sdk/platform-tools"
export DART_SDK=/home/dawson/dart/dart-sdk

. ~/.z.sh

# Aliases
alias ..='cd ..'
alias ls='ls -Ah --color'
alias l='ls -lAh --color'
alias ll='l | less'
alias subl='/opt/sublime_text_3/sublime_text'

# Functions
screencast() {
    recordmydesktop --workdir=~/tmp --width 1680 --height 1050
    echo "Splitting audio and video"
    avconv -i out.ogv -vcodec libx264 -an tmpvid.mov
    echo "Extracting audio (for noise reduction processing)"
    avconv -i out.ogv tmpaud.wav
    echo "Sampling noise"
    avconv -i out.ogv -vn -ss 00:00:00 -t 00:00:01 noiseaud.wav
    echo "Profiling noise"
    sox noiseaud.wav -n noiseprof noise.prof
    echo "Applying actual noise reduction"
    sox tmpaud.wav tmpaud-clean.wav noisered noise.prof 0.185
    echo "Merging audio and video again"
    avconv -i tmpvid.mov -i tmpaud-clean.wav -strict experimental final.mov
    echo "Cleaning temp files"
    rm tmpvid.mov tmpaud.wav noiseaud.wav noise.prof
    echo "Backup original .ogv"
    mv out.ogv out_original.ogv
}

function dart_clean()
{
    # Removes all pubspec.lock
    echo "Deleting all pubspec.lock files..."
    find . -name "pubspec.lock" -exec rm {} \;
    # Finds all symlinks named packages
    echo "Deleting all packages symlinks..."
    find .  -type l -name "packages" -exec rm {} \;
    # Finds all empty directories named "packages" and removes them
    find .  -type d -name "packages" -empty -print | while read PACKAGES_DIR
    do
        echo "Deleting $PACKAGES_DIR..."
        rmdir $PACKAGES_DIR
    done
}

function ffind(){
  for ARG in "$@"
  do
    findArgs+="$ARG*"
  done
  find . -iname "*$findArgs"
  unset findArgs
}
 
function ff(){
  for ARG in "$@"
  do
    findArg+="$ARG*"
  done
  find . -maxdepth 1 -iname "*$findArg" | sed -e 's/.\///g'
  unset findArg
}

function server(){
    if [ $1 -eq $1 ] 2>/dev/null && ! [ -z "$1" ]; then
        PORT="--port $1"
    else
        PORT=""
    fi
    
    pub global run simple_http_server $PORT
}

function engeene(){
  markdown_py $1 | sed -e 's/<pre><code>/<pre class=\"prettyprint\">/g' | sed -e 's/<\/code><\/pre>/<\/pre>/g' | sed -e "s/file:\/\/\/Users\/dawson\/Pictures\/screenshots/http:\/\/www.engeene.it\/wp-content\/uploads\/`date +%Y`\/`date +%m`/g" | xclip
  echo "Testo copiato negli appunti."
}

function new_post(){

  POST_DATE=`date +%Y-%m-%d`
  echo "Insert post's layout (ENTER to default):"
  read POST_LAYOUT

  [ -z "$POST_LAYOUT" ] && POST_LAYOUT="default"

  echo "Insert post's title:"
  read raw_title
  POST_FILENAME=`echo "$POST_DATE-$raw_title" | tr A-Z a-z | sed -e 's/ /-/g' \
      | sed -e 's/[^a-zA-Z0-9\-]//g'`

  POST_FILENAME="$POST_FILENAME.md"
  POST_TITLE=`echo "$raw_title" \
      | perl -MHTML::Entities -ne 'print encode_entities($_)' | sed 's/:/\&#58;/g'`

  echo "Insert post's language: (lang variable):"
  read POST_LANG
  echo "Insert category: (category variable):"
  read POST_CATEGORY

  # building the conf file
  POST_CONF="---
layout: $POST_LAYOUT
title: $POST_TITLE
lang: $POST_LANG
category: $POST_CATEGORY
---
"

  # checking if you're in src or _posts or wherever
  if [[ -d `pwd`/_posts ]]; then
      echo "$POST_CONF">"_posts"/$POST_FILENAME
      echo "New post created in `pwd`/_posts"
  else
      echo "$POST_CONF">$POST_FILENAME
      echo "New post created in `pwd`"
  fi

}

=() {
    calc="${@//p/+}"
    calc="${calc//x/*}"
    bc -l <<<"scale=10;$calc"
}

# Misc
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1="\[\033[35m\]\t \[\033[36m\]\h:\w \[\033[1;31m\]\$(parse_git_branch) \n\[\033[35m\]$ \[\033[0m\]"

set show-all-if-ambiguous on
set completion-ignore-case on

#	Random stuff
export HISTSIZE=9999

source /home/dawson/me/dev/github/claudiodangelis/dart_cli_utils/dart_cli_utils

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM
