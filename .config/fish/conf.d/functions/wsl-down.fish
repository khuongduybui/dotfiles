# Defined in /tmp/fish.Tf8Tzh/wsl-down.fish @ line 2
function wsl-down
    if test -z $argv[1]
        if test -z $WSL_DISTRO_NAME
            wsl.exe --shutdown
        else
            wsl.exe --terminate $WSL_DISTRO_NAME
        end
    else
        wsl.exe --terminate $argv[1]
    end
end
