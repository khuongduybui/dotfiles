function __fish_complete_ips
    if test -e ~/.aws/config
        grep ~/.aws/config -e '\[profile' | sed 's/\[profile //' | sed 's/]//'
    end
end
