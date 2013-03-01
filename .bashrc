#!/bin/bash
# A nice pretty bash environment.
#
# Gray Manley with help from Ryan Tomayko and the internet.

# the basics
: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}

# complete hostnames from this file
: ${HOSTFILE=~/.ssh/known_hosts}

# readline config
: ${INPUTRC=~/.inputrc}

# ----------------------------------------------------------------------
#  SHELL OPTIONS
# ----------------------------------------------------------------------

# Enables cd to correct minor typos ie. 'mkdir /foo && cd /foe && pwd' => /foo
shopt -s cdspell >/dev/null 2>&1
# Extended pattern matching ie. 'ls -d !(*gif|*jpg)' shows everything except jpg and gif.
shopt -s extglob >/dev/null 2>&1
# Append command history when using multiple shells instead of overwriting it.
shopt -s histappend >/dev/null 2>&1
# Allow tab completion of hosts found in $HOSTFILE which in this case is ~/.ssh/known_hosts
shopt -s hostcomplete >/dev/null 2>&1
# Don't attempt to tab complete without a preceding command.
shopt -s no_empty_cmd_completion >/dev/null 2>&1
shopt -s globstar autocd >/dev/null 2>&1
# Notify of background job completion.
set -o notify
# Set default umask
umask 0022
# Tab complete with sudo as well
complete -cf sudo

function setup () {
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi

  # Homebrew installed bash completion is better
  # /etc/bash_completion automatically sources ~/.bash_completion if it exists.
  local git_prompt_path="$(brew --prefix)/etc/bash_completion.d/git-prompt.sh"
  [[ -f $git_prompt_path ]] && . $git_prompt_path



  # # Homebrew Bash Completion
  local brew_bash_completion_path="$(brew --prefix)/Library/Contributions/brew_bash_completion.sh"
  [[ -f $brew_bash_completion_path ]] && . $brew_bash_completion_path
}

setup && unset setup

# ----------------------------------------------------------------------
# PATH
# ----------------------------------------------------------------------
# we want the various sbins on the path along with /usr/local/bin
export PATH="/usr/local/bin:/usr/local/share/npm/bin:/usr/local/sbin:/usr/sbin:$PATH"
export ACLOCAL_PATH="$(brew --prefix)/share/aclocal"

# Load aliases & functions from seperate file if present
[[ -f "$HOME/.bash_aliases" ]] && . "$HOME/.bash_aliases"

# ----------------------------------------------------------------------
# ENVIRONMENT CONFIGURATION
# ----------------------------------------------------------------------
# detect interactive shell
case "$-" in
  *i*) INTERACTIVE=yes ;;
  *)   unset INTERACTIVE ;;
esac

# detect login shell
case "$0" in
  -*) LOGIN=yes ;;
  *)  unset LOGIN ;;
esac

# enable en_US locale w/ utf-8 encodings if not already configured
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

# always use PASSIVE mode ftp
: ${FTP_PASSIVE:=1}
export FTP_PASSIVE

# Don't list the same command more then once in history
export HISTCONTROL=ignoreboth

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE

# ----------------------------------------------------------------------
# PROMPT
# ----------------------------------------------------------------------
LBLUE="\[\e[0;36m\]"
GREEN="\[\e[0;32m\]"
YELLOW="\[\e[0;33m\]"
VIOLAT="\[\e[0;94m\]"
MAGENTA="\[\e[0;35m\]"
PS_CLEAR="\[\e[0m\]"

prompt_color() {
  PS1="${YELLOW}[${GREEN}\u${LBLUE}@${VIOLAT}\h${YELLOW}][${LBLUE}\w${MAGENTA}\$(__git_ps1)${YELLOW}] ∴${PS_CLEAR} "
  PS2="\[\]continue \[\]> "
}

# ----------------------------------------------------------------------
# LS AND DIRCOLORS
# ----------------------------------------------------------------------

export CLICOLOR=1
export LSCOLORS=gxgxcxdxbxegedabagacad  # cyan directories

# -------------------------------------------------------------------
# USER SHELL ENVIRONMENT
# -------------------------------------------------------------------

# Use the color prompt by default when interactive
[[ -n "$PS1" ]] && prompt_color

# Change terminal title based on path and host.
case "$TERM" in
  xterm*|rxvt*)
  PROMPT_COMMAND='echo -ne "\033]0;${USER}: ${PWD}\007"'
  ;;
  *)
  ;;
esac

# -------------------------------------------------------------------
# MOTD
# -------------------------------------------------------------------

# test -n "$INTERACTIVE" -a -n "$LOGIN" && {
#   uname -prs
#   uptime
# }

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

export EDITOR='subl'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
