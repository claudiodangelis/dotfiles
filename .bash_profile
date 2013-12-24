export PATH="$PATH:~/dart/dart-sdk/bin:/opt/local/bin:/opt/local/sbin:~/bin:~/.gem/ruby/2.0.0/bin"
export DART_SDK=~/dart/dart-sdk

# Aliases
alias ..='cd ..'
alias ls='ls -Ah --color'
alias l='ls -lAh --color'
alias ll='l | less'
alias subl='/opt/sublime_text_3/sublime_text'

# Functions
function dart_clean()
{
    find . -name "packages" -exec rm -rf {} \;
    find . -name "pubspec.lock" -exec rm {} \;
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
  local port="${1:-8000}"
  xdg-open "http://localhost:${port}/" &
  python -m http.server "$port"
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

# Misc
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1="\[\033[35m\]\t \[\033[36m\]\h:\w \[\033[1;31m\]\$(parse_git_branch) \n\[\033[35m\]$ \[\033[0m\]"

set show-all-if-ambiguous on
set completion-ignore-case on

#	Random stuff
export HISTSIZE=9999

