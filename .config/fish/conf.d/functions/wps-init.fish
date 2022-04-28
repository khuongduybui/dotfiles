function wps-init
    set apps et wpp wps
    for app in $apps
        if type -q $app
            if not ps aux | grep -v grep | grep -q "$app -quickstart"
                eval "$app -quickstart"
            end
        end
    end
end
