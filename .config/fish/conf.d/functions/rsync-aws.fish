# Defined in /tmp/fish.0TsA3z/rsync-aws.fish @ line 2
function rsync-aws
    test -d ~/OneDrive
    and bash ~/setup/backup-and-link.sh ~/OneDrive/Essentials/dotfile.aws ~/.aws

    test -d ~/winhome/OneDrive
    and bash ~/setup/backup-and-link.sh ~/winhome/OneDrive/Essentials/dotfile.aws ~/.aws

    test -f ~/.aws/config && chmod 644 ~/.aws/config
    test -f ~/.aws/credentials && chmod 644 ~/.aws/credentials

    echo Done
end
