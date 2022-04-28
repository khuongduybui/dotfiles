# Defined in /tmp/fish.uTlQbQ/myip.fish @ line 2
function myip
    info External IP
    type -q curl
    and echo -n " "
    and curl -s https://checkip.amazonaws.com | grep .

    info Internal IP
    if type -q ip
        ip address | grep inet | grep -oE "[ :]([0-9a-f]*[.:])+[%a-z0-9/]*[ \$]"
    else
        if __is_mac
            ifconfig | fgrep inet | grep -oE " ([0-9a-f]*[\.:]?)+[%a-z0-9]* "
        else
            ifconfig | fgrep inet | grep -oE "[ :]([0-9a-f]*[.:])+[%a-z0-9/]*[ \$]"
        end
    end

    if __is_win; and type -q powershell.exe
        info WSL Host IP
        echo "Get-NetIPAddress | Select-Object IPAddress" | powershell.exe -NoLogo -NoProfile -Command -
    end
end
