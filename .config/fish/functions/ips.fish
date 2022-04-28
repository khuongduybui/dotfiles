# Defined in /tmp/fish.guwUXW/ips.fish @ line 2
function ips
    set -lx query $argv[1]
    test -z $query; and set -lx query ""
    set -lx AWS_PROFILE (cat ~/.aws/config | grep '\[profile' | sed -e 's/\[profile //' -e 's/\]//' | fzf -1 -q $query)
    test -z $AWS_PROFILE; and return
    if __is_mac
        /usr/local/bin/fish
    else
        /usr/bin/fish
    end
end
