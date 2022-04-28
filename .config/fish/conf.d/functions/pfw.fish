# Defined in /tmp/fish.iWjHxs/pfw.fish @ line 2
function pfw
    if not type -q socat
        echo "Installing socat..."
        type -q yum
        and sudo yum install -y socat
        type -q apt
        and sudo apt install -y socat
        type -q zypper
        and sudo zypper install -y socat
    end
    set destination 3000
    if test (count $argv) = 2
        set destination $argv[2]
    end
    echo "Redirecting incoming traffic targetting port $destination to $argv[1]"
    if test $destination -le 101
        sudo socat -x "tcp-listen:$destination,reuseaddr,fork" "tcp:localhost:$argv[1]"
    else
        socat -x "tcp-listen:$destination,reuseaddr,fork" "tcp:localhost:$argv[1]"
    end
end
