function msi-init
    rich -a rounded -S blue -p "[blue]AWS SSO"
    aws-sso-util login --all

    rich -a rounded -S blue -p "[blue]ScaleFt"
    sft login

    rich -a rounded -S blue -p "[blue]MSI BitBucket"
    rich --style italic -p "From [blue]https://confluence.mot-solutions.com/display/REMOT/Bitbucket+Access+Flow[/blue] (last updated [bold]19-Aug-2022[/bold])."
    rich --style italic -p "Saved to [blue]s3://duybui-msi-shellscripts/msi-bitbucket.sh[/blue] in [blue]aws.aec.dev.duy[/blue] account."
    aws --profile=sandbox s3 cp s3://duybui-msi-shellscripts/msi-bitbucket.sh - | bash -

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
