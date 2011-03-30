###########
# Aliases #
###########

#|---------|
#| General |
#|---------|
alias lsa='ls -lah' # l for list style, a for all including hidden, h for human readable file sizes
alias h='history'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias rbash=". ~/.bash_profile" # reloads bash profile
alias ebash='mate ~/.bashrc ~/.bash_aliases ~/.inputrc ~/.bash_profile ~/.personal_profile' # Open our bash config files in textmate.
alias ping='ping -c 5' # Limit command to ping the specified server only 5 times.
alias grep='grep --color=auto' # Color the returned matches
# Want to be prompted so we don't do anything stupid.
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p -v' # Make parent directory if it doesn't exist.
alias trash='rmtrash'

#|------|
#| Ruby |
#|------|
alias irb='irb --readline -r irb/completion -rubygems' # use readline, completion and require rubygems in irb

#|-------|
#| Rails |
#|-------|
alias ss="script/server"
alias sc="script/console"
alias sg="script/generate"
alias rdbm="rake db:migrate"
alias rdbc="rake db:create"

#############
# Functions #
#############

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

function hubpatch () {
  curl -k $1.patch | git am
}

# push SSH public key to another box
function push_ssh_cert () {
    local _host
    test -f ~/.ssh/id_dsa.pub || ssh-keygen -t dsa
    for _host in "$@";
    do
        echo $_host
        ssh $_host 'cat >> ~/.ssh/authorized_keys' < ~/.ssh/id_dsa.pub
    done
}