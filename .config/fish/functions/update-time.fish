# Defined in /tmp/fish.ULTcxp/update-time.fish @ line 2
function update-time
    if not test (count $argv) = 0
        if test $argv[1] = "-f"
            type -q ntpdate; or sudo apt install ntpdate
            sudo ntpdate time.windows.com
        end
    else
        if __is_win
            sudo hwclock -s
        else
            type -q ntpdate; or sudo apt install ntpdate
            sudo ntpdate time.windows.com
        end
    end
end
