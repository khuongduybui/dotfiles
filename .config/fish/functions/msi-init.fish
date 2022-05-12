function msi-init
    set -l verbose off
    if test (echo $argv[1]) = "-v"
        set -x verbose on
    end

    echo "====== AWS SSO login ======"
    aws-sso-util login --all

    echo "==== ActiveEye Gateway ===="
    for pod in hawk wasp lion orca wolf bear
        if test (echo $verbose) = "on"
            echo "https://gateway1.$pod.activeeye.com/gateway"
        end
        xdg-open "https://gateway1.$pod.activeeye.com/gateway"
    end

    echo "========= ScaleFt ========="
    sft login
end
