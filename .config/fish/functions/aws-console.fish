function aws-console
    set service ""
    if not test (count $argv) = 0
        set service $argv[1]
    end
    if set -q AWS_PROFILE
        assume --console "$AWS_PROFILE" --service "$service"
    else
        assume --console default --service "$service"
    end
end
