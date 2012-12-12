CONF_ROOT=`dirname $0`
read -p "This will overwrite your previous dotfiles, make sure you have backed them up if you wish to preserve them. Continue? (y/n) "
cd $CONF_ROOT
cat gitconfig-extras >> "$HOME/.gitconfig"
find $(git ls-files) -name ".*" \( ! -name .gitignore ! -name .git \) -exec ln -sf "$(pwd)/{}" "$HOME/" \;
if [[ ${rvm_version+defined} ]]; then
  ln -sf $CONF_ROOT/*.gems $rvm_path/gemsets/
fi
cd -
