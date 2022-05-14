function msi-init
    rich -a rounded -S blue -p "[blue]AWS SSO"
    aws-sso-util login --all

    rich -a rounded -S blue -p "[blue]ScaleFt"
    sft login

    rich -a rounded -S blue -p "[blue]ActiveEye Gateway"
    for pod in hawk wasp lion orca wolf bear
        if ssh -o ConnectTimeout=5 -q gateway1.ec2.$pod.activeeye.com exit
            rich -p "[green][bold italic]gateway1.ec2.$pod.activeeye.com[/bold italic] is up"
        else
            rich -p "[blue]Invoking [bold italic]https://gateway1.$pod.activeeye.com/gateway"
            xdg-open "https://gateway1.$pod.activeeye.com/gateway"
        end
    end
end
