# Defined in /tmp/fish.n7YcaK/cat.fish @ line 1
function cat
    if type -q bat
        bat $argv
    else
        command cat $argv
    end
end
