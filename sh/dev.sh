#! /usr/bin/env sh

mkdir -p /home/duybui/.virtualenvs
uv tool install --force virtualfish
uv tool install --force cfn-lint
uv tool install --force cfn-flip
uv tool install --force imgcat
uv tool install --force frogmouth
uv tool install --force toolong
fish -c "vf install"
fish -c "vf addplugins auto_activation"

cargo install difftastic cargo-update

npm install -g dotenv-vault
pnpm setup

asdf reshim

test -e ~/.iterm2_shell_integration.fish || curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash
# trunk-ignore(shellcheck/SC2016)
sed -e 's|test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish|test -e {$HOME}/.iterm2_shell_integration.fish ; and string match -q "$TERM_PROGRAM" WezTerm ; and source {$HOME}/.iterm2_shell_integration.fish|' -i ~/.config/fish/config.fish

gh extension list | grep -q mislav/gh-branch || gh extension install mislav/gh-branch
gh extension list | grep -q redraw/gh-install || gh extension install redraw/gh-install
gh extension list | grep -q gennaro-tedesco/gh-f || gh extension install gennaro-tedesco/gh-f
