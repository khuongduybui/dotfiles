# Defined in /tmp/fish.Zq2u7y/bit.fish @ line 2
function bit
    set here (pwd)
    if test -d .git
        cd ..
    end

    if test (ls | wc -l) -lt 2
        cd *
        execute_bit $argv
        cd -
    end


    for repo in (ls */.git | grep .git: | sed -e 's|/\.git:||')
        cd $repo
        execute_bit $argv
        cd -
    end

    cd $here
end
