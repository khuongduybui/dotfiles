function msi-init
    rich --panel rounded -c -p "[bold italic]AWS SSO"
    aws-sso-util login --all

    rich --panel rounded -c -p "[bold italic]ScaleFt"
    sft login

    rich --panel rounded -c -p "[bold italic]ActiveEye Gateway"
    for pod in hawk wasp lion orca wolf bear
        if ssh -o ConnectTimeout=5 -q gateway1.ec2.$pod.activeeye.com exit
            rich -p "[green][bold italic]gateway1.ec2.$pod.activeeye.com[/bold italic] is up"
        else
            rich -p "[blue]Invoking [bold italic]https://gateway1.$pod.activeeye.com/gateway"
            xdg-open "https://gateway1.$pod.activeeye.com/gateway"
        end
    end
end
