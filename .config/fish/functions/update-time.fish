# Defined in /tmp/fish.ULTcxp/update-time.fish @ line 2
function update-time
    if __is_win
        sudo hwclock -s
    else
        type -q ntpdate; or sudo apt install ntpdate
        sudo ntpdate time.windows.com
    end
end
