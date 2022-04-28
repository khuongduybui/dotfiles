# Defined in /tmp/fish.KmiH8t/docker-init.fish @ line 2
function docker-init
    if type -q docker
        set -gx DOCKER_BUILDKIT 1
        mkdir -p ~/.docker
        find ~/.docker -empty -name config.json >/dev/null 2>&1; and echo '{}' >~/.docker/config.json
        if test -x $WROOT/wsl/docker-desktop/docker-desktop-proxy; and not pgrep docker-desktop >/dev/null 2>&1
            info 'Launching Docker Desktop Proxy'
            nohup sudo $WROOT/wsl/docker-desktop/docker-desktop-proxy --distro-name $WSL_DISTRO_NAME --docker-desktop-root $WROOT/wsl/docker-desktop >(mktemp) 2>&1 &
            nohup docker serve --address unix://$HOME/.docker/run/docker-cli-api.sock >(mktemp) 2>&1 &
        end
    end
end
