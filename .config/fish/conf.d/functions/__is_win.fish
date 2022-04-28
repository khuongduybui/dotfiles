function __is_win
    grep -q -i "Microsoft" /proc/version
    and type -q wslpath
end
