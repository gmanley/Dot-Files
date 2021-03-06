###########
# Aliases #
###########

#|---------|
#| General |
#|---------|
alias lsports='lsof -i -P | grep LISTEN'
alias h='history'
alias hgrep='history | grep -i'
alias rbash=". ~/.bash_profile" # reloads bash profile
alias ping='ping -c 5' # Limit command to ping the specified server only 5 times.
alias grep='grep -i --color=auto' # Color the returned matches
alias mkdir='mkdir -p -v' # Make parent directory if it doesn't exist.
alias trash='rmtrash'
[[ -f $(which hub) ]] && alias git=hub
alias mvim="mvim -p"
alias mate='mate -r'
alias pcurl="curl -b <(sqlite3 -separator $'\t' ~/Library/Application\ Support/Google/Chrome/Default/Cookies \"select host_key, 'TRUE','/', 'FALSE', expires_utc, name, value from cookies\")"
alias be='bundle exec'

#|-----|
#| Git |
#|-----|
alias gcl='git clone'
alias ga='git add'
alias gall='git add .'
alias g='git'
alias get='git'
alias gst='git status'
alias gs='git status'
alias gss='git status -s'
alias gl='git pull'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gpo='git push origin'
alias gdv='git diff -w "$@" | vim -R -'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gci='git commit --interactive'
alias gb='git branch'
alias gba='git branch -a'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gco='git checkout'
alias gexport='git archive --format zip --output'
alias gdel='git branch -D'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gd="git diff | $EDITOR"

#############
# Functions #
#############

function gems_path () {
  local gems_base_dir="$GEM_HOME/gems"
  if [ -n $1 ]; then
    echo "$gems_base_dir/$1*"
  else
    echo "$gems_base_dir"
  fi
}

function subl_gems () {
  subl $(gems_path $1)
}

function digga () {
  dig +nocmd "$1" any +multiline +noall +answer
}

function mkrvmrc () {
  local latest_ruby="$(rvm list strings | tail -n -1)"
  echo "rvm $latest_ruby@$(basename $PWD) --create" > .rvmrc
  . .rvmrc
}

function showdiff () {
  tab=$'\t'
  echo "Offset${tab}File1${tab}File2"
  cmp -l "${1}" "${2}" | while read offset file1val file2val
  do
    echo "$(printf '%x' ${offset})${tab}$( printf '%x' $((8#${file1val})))${tab}$(printf '%x' $((8#${file2val})))"
  done
}

# Opens specified commands man page in preview
# Usage: pman <command>
function pman () {
  man -t $1 | open -f -a /Applications/Preview.app
}

# Extract archives without needing to remember all the different syntax.
# Usage: extract <archive>
function extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)  tar xjf $1  ;;
      *.tar.gz)   tar xzf $1  ;;
      *.bz2)      bunzip2 $1  ;;
      *.rar)      rar x $1    ;;
      *.gz)       gunzip $1   ;;
      *.tar)      tar xf $1   ;;
      *.tbz2)     tar xjf $1  ;;
      *.tgz)      tar xzf $1  ;;
      *.xz)       tar xJf $1  ;;
      *.zip)      unzip $1    ;;
      *.Z)        uncompress $1 ;;
      *)          echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function mdiff () {
  if [[ -f $1 && -f $2 ]]; then
    file_1="/tmp/file_1.txt"
    file_2="/tmp/file_2.txt"
    mediainfo "$1" > "$file_1"
    mediainfo "$2" > "$file_2"
    opendiff "$file_1" "$file_2"
  fi
}

function mtube (){
  mplayer -prefer-ipv4 $(youtube-dl -g "$1")
}

function xcode () {
  open $1/*.xcodeproj
}

function hubpatch () {
  curl -k $1.patch | git am
}

# push SSH public key to another box
function push_ssh_cert () {
    local _host
    test -f ~/.ssh/id_rsa.pub || ssh-keygen -t dsa
    for _host in "$@";
    do
        echo $_host
        ssh $_host 'cat >> ~/.ssh/authorized_keys' < ~/.ssh/id_rsa.pub
    done
}

function fcount () {
  ls -1 | wc -l
}

alias ec2mosh="mosh -ssh='ssh -i ~/.ssh/Gray.pem'"

