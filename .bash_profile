. "$HOME/.bashrc"

if [ -f "$HOME/.personal_profile" ]; then
  . "$HOME/.personal_profile"
fi

[[ -s "$HOME/.tmuxinator/scripts/tmuxinator" ]] && . "$HOME/.tmuxinator/scripts/tmuxinator"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion # RVM Shell Completion
