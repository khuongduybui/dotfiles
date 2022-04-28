# Defined in /tmp/fish.cOl329/rsync-ssh.fish @ line 2
function rsync-ssh
    mkdir -p ~/.ssh

    test -d ~/OneDrive
    and bash ~/setup/backup-and-link.sh ~/OneDrive/Essentials/dotfile.ssh ~/.ssh

    test -d ~/winhome/OneDrive
    and bash ~/setup/backup-and-link.sh ~/winhome/OneDrive/Essentials/dotfile.ssh ~/.ssh
    
    chmod 600 ~/.ssh/*.private.asc
    chmod 600 ~/.ssh/*.pem
    chmod 600 ~/.ssh/config
    chmod 644 ~/.ssh/*.public.asc
    chmod 644 ~/.ssh/*.pub
    chmod 644 ~/.ssh/known_hosts
    chmod 644 ~/.ssh/authorized_keys

    gpg --import ~/.ssh/*.asc

    echo Done
end
