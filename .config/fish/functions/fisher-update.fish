# Defined in /tmp/fish.CWgSKY/fisher-update.fish @ line 1
function fisher-update
    # mv ~/.config/fish/functions ~/.config/fish/functions.lnk
    curl -sL git.io/fisher | source && fisher install jorgebucaran/fisher
    fisher update
    # mv ~/.config/fish/functions/* ~/.config/fish/functions.lnk/
    # rmdir ~/.config/fish/functions
    # mv ~/.config/fish/functions.lnk ~/.config/fish/functions
end
