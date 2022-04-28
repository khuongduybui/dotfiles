# Defined in /tmp/fish.K3mCY9/l.fish @ line 2
function l
    if type -q exa
        exa -lagh --time-style=long-iso --color-scale --group-directories-first $argv
    else if type -q lsd
        lsd -lA $argv
    else
        if __is_mac
            ls -laGhF $argv
        else
            ls -lahF --color $argv
        end
    end
end
