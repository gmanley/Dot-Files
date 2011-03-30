. "$HOME/.bashrc"

if [ -f "$HOME/.personal_profile" ]; then
  . "$HOME/.personal_profile"
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"