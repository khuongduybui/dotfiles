# Defined in /tmp/fish.P2kIMZ/__is_win_path.fish @ line 2
function __is_win_path
    if not __is_win
        return (__is_win)
    end
    string match -q "*:*" (wslpath -w $argv[1])
end
