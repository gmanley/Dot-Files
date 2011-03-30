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

# Notify of background job completion.
set -o notify

# Set default umask
umask 0022

# Tab complete with sudo as well
complete -cf sudo

# /etc/bash_completion automatically sources ~/.bash_completion if it exists.
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

if [ -f `brew --prefix`/Library/Contributions/brew_bash_completion.sh ]; then
  . `brew --prefix`/Library/Contributions/brew_bash_completion.sh
fi

[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

# ----------------------------------------------------------------------
# PATH
# ----------------------------------------------------------------------

# we want the various sbins on the path along with /usr/local/bin
export PATH="/usr/local/Cellar/ccache/3.1.4/libexec:/usr/local/Cellar/python/2.7.1/bin:/usr/local/sbin:/usr/sbin:/usr/local/bin:$PATH"
export NODE_PATH="/usr/local/lib/node"
export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH

# I like to put my various aliases in a seperate file
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Readline config
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home

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

export FTP_PASSIVE

# Don't list the same command more then once in history
HISTCONTROL=ignoreboth

# ----------------------------------------------------------------------
# PROMPT
# ----------------------------------------------------------------------

LBLUE="\[\033[0;36m\]"
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
PS_CLEAR="\[\033[0m\]"

prompt_color() {
  PS1="${YELLOW}[${GREEN}\u${YELLOW}][${LBLUE}\w${YELLOW}] ∴ ${PS_CLEAR}"
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
test -n "$PS1" &&
prompt_color

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

test -n "$INTERACTIVE" -a -n "$LOGIN" && {
  uname -prs
  uptime
}