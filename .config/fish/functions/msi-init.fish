function msi-init
    echo "====== AWS SSO login ======"
    aws-sso-util login --all

    echo "========= ScaleFt ========="
    sft login

    echo "==== ActiveEye Gateway ===="
    for pod in hawk wasp lion orca wolf bear
        if ssh -q gateway1.ec2.$pod.activeeye.com exit
            echo "gateway1.ec2.$pod.activeeye.com is up"
        else
            echo "https://gateway1.$pod.activeeye.com/gateway"
            xdg-open "https://gateway1.$pod.activeeye.com/gateway"
        end
    end
end
