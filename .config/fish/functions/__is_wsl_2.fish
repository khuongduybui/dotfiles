# Defined in /tmp/fish.QdvZT1/__is_wsl_2.fish @ line 2
function __is_wsl_2
    __is_win
    and test (grep -e 'nameserver' /etc/resolv.conf | wc -l) = 1
end
