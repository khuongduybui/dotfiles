# Defined in /tmp/fish.SXtqg0/backup-code.fish @ line 2
function backup-code
    cd ~/code
    ls -1 ./*.code-workspace >.auto-backup
    find -name .env >>.auto-backup
    find -name .envrc >>.auto-backup
    find -name .tool-versions >>.auto-backup
    find -name 'local-tests*' >>.auto-backup
    mkdir -p ~/winhome/code/
    rsync --files-from=.auto-backup ./ ~/winhome/.code/
    if test -f .manual-backup
        rsync --files-from=.manual-backup ./ ~/winhome/.code/
    end
    cd -
end
