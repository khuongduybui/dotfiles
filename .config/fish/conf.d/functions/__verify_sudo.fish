function __verify_sudo
    if test (id -un) != 'root'
        echo "Not running as root, try again."
        sudo fish (status -f)
        exit
    end
end
