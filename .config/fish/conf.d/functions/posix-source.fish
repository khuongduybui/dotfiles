# Defined in /tmp/fish.zv5ciY/posix-source.fish @ line 2
function posix-source
    for i in (cat $argv | grep -v -E '^#' | grep -v -E '^ *$')
        set arr (echo $i | sed 's/^export //' | tr = \n)
        set -gx $arr[1] $arr[2]
    end
    echo (cat $argv | grep -v -E '^#' | grep -v -E '^ *$' | wc -l) variables exported from $argv.
end
