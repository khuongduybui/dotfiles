#! /usr/bin/env sh

pip install -U pipx
asdf reshim
mkdir -p /home/duybui/.virtualenvs
pipx install virtualfish
pipx ensurepath
fish -c "vf install"
fish -c "vf addplugins auto_activation"
pipx upgrade-all

cargo install difftastic

asdf reshim

test -e ~/.iterm2_shell_integration.fish || curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash
sed -e 's|test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish|test -e {$HOME}/.iterm2_shell_integration.fish ; and string match -q "$TERM_PROGRAM" WezTerm ; and source {$HOME}/.iterm2_shell_integration.fish|' -i ~/.config/fish/config.fish

gh extension install mislav/gh-branch
gh extension install redraw/gh-install
