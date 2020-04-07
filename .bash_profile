. "$HOME/.bashrc"

if [ -f "$HOME/.personal_profile" ]; then
  . "$HOME/.personal_profile"
fi

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
