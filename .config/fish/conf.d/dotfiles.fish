## Global
### PATH
__clean_missing PATH
__ensure_path ~/bin
__ensure_path ~/.local/bin
__ensure_path ~/.cargo/bin
if test -d ~/Android/Sdk
    set -xU ANDROID_HOME "$HOME/Android/Sdk"
    __ensure_path ~/Android/Sdk/platform-tools
    __ensure_path ~/Android/Sdk/cmdline-tools/latest/bin
else
    set -e ANDROID_HOME
end
test -f ~/.asdf/asdf.fish; and source ~/.asdf/asdf.fish
varclear PATH
set -xU PATH $PATH

if status --is-interactive
    ## Plugins
    # source ~/setup/verify-fisher.fish
    # source ~/setup/fallback.fish
    # source ~/setup/fish_preexec.fish
    test -d /home/linuxbrew/.linuxbrew/share/fish/vendor_completions.d
    and cat /home/linuxbrew/.linuxbrew/share/fish/vendor_completions.d/*.fish | source

    ## Completions
    complete -c c2c -x -a '(__fish_complete_c2c)'
    complete -c ips -x -a '(__fish_complete_ips)'
    complete -c ssm-env -x -a '(__fish_complete_ssm-env)'

    ## Abbreviations
    source ~/setup/abbreviations.fish

    __is_day; and set -xU BAT_THEME "Monokai Extended Light"; or set -xU BAT_THEME "Monokai Extended"
end

if test -z $INIT
    if status --is-interactive
        ### Editors
        if not test -e ~/.editor
            info 'Searching for Editors'
            if test -e ~/.asdf/shims/edit
                set -x EDITOR ~/.asdf/shims/edit
            else if type -q code
                and not test -e ~/.disable-vscode
                set -x EDITOR ~/setup/vscode.sh
            else
                set -x EDITOR (which io.elementary.code 2>/dev/null; or which micro 2>/dev/null; or which nvim 2>/dev/null; or which vim 2>/dev/null; or which vi 2>/dev/null; or which nano 2>/dev/null)
            end
            set -xU MICRO_TRUECOLOR 1
            set -xU EDITOR $EDITOR
            echo $EDITOR >~/.editor
        end

        browser-init

        ### Languages
        if not grep -q -e "LANG=en_US.UTF-8" /etc/locale.conf
            info 'Setting locale'
            grep -q -e "^LC_ALL=en_US.UTF-8\$" /etc/environment; or echo "LC_ALL=en_US.UTF-8" | sudo tee -a /etc/environment
            grep -q -e "^en_US.UTF-8 UTF-8\$" /etc/locale.gen; or echo "en_US.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
            echo "LANG=en_US.UTF-8" | sudo tee /etc/locale.conf
            type -q locale-gen; and sudo locale-gen en_US.UTF-8
        end
    end

    ## Preload WPS
    wps-init

    ## Load byobu
    if status --is-login
        if test -z $BYOBU_WINDOW_NAME
            and not test -e ~/.byobu/disable-autolaunch
            and type -q byobu-launcher
            info 'Launching Byobu'
            exec byobu-launcher
        end
    end

    ## Done INIT
    set -x INIT true
end

### Shell
type -q starship; and source (starship init fish --print-full-init | psub)

type -q direnv; and direnv hook fish | source

type -q zoxide; and zoxide init fish | sed "s/complete -e z/complete -c z -e/" | source; and abbr cd z

type -q jt; and test -e ~/.config/jira; and jt completion fish | source

type -q atuin; and atuin init fish | source
