# Defined in /tmp/fish.Oloxf2/restore-code.fish @ line 2
function restore-code
    rsync --recursive --links ~/winhome/.code/ ~/code/
end
