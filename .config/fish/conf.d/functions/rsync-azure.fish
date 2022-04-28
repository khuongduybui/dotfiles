# Defined in /tmp/fish.NDdDlw/rsync-azure.fish @ line 1
function rsync-azure
    test -d ~/OneDrive
    and bash ~/setup/backup-and-link.sh ~/OneDrive/Essentials/dotfile.azure ~/.azure

    test -d ~/winhome/OneDrive
    and bash ~/setup/backup-and-link.sh ~/winhome/OneDrive/Essentials/dotfile.azure ~/.azure

    test -f ~/.azure/config && chmod 644 ~/.azure/config
    test -f ~/.azure/credentials && chmod 644 ~/.azure/credentials

    echo Done
end
