# Defined in /tmp/fish.uTlQbQ/myip.fish @ line 2
function myip
    info External IP
    type -q curl
    and curl -s https://checkip.amazonaws.com

    info Internal IP
    if type -q ip
        # ip address | grep inet | grep -oE "[ :]([0-9a-f]*[.:])+[%a-z0-9/]*[ \$]"
        ip address | grep "inet " | cut -d' ' -f6 | cut -d'/' -f1
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
