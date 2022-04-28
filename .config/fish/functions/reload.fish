function reload
    set -e INIT
    if test -f ~/.config/fish/conf.d/$USER.fish
        source ~/.config/fish/conf.d/$USER.fish
    else if test -f ~/.config/fish/config.fish
        source ~/.config/fish/config.fish
    else
        set_color $fish_color_error
        echo -n "ERROR: config.fish not found under ~/.config/fish/"
    end
end
