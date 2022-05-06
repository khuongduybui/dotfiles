function backup-code
    mkdir -p ~/winhome/Pengwin/backups
    cd ~/code
    tar -czf ~/winhome/Pengwin/backups/code.tgz .
    cd -
end
