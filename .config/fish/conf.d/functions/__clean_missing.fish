# Defined in /tmp/fish.kGWeOW/__clean_missing.fish @ line 1
function __clean_missing
    if test (count $argv) = 1
        set -l newvar
        for v in $$argv
            if test -d $v
                set newvar $newvar $v
            end
        end
        set $argv $newvar
    else
        for a in $argv
            varclear $a
        end
    end
end
