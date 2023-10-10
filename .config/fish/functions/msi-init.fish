function msi-init
    rich -a rounded -S blue --style blue -p "AWS SSO"
    aws-sso-util login --profile bear
    aws-sso-util login --profile wolf
    aws sso login --sso-session msi
    if hostname -f | grep -qv ds.mot.com
        aws-sso-util login --profile amber
    end

    rich -a rounded -S blue --style blue -p ScaleFt
    sft login

    if hostname -f | grep -q ds.mot.com
        rich -a rounded -S blue --style blue -p "MSI BitBucket"
        if test -e ~/iap.header; and test (jq -R 'split(".") | .[1] | @base64d | fromjson | .exp' <~/iap.header) -gt (now)
            set -l exp (math (jq -R 'split(".") | .[1] | @base64d | fromjson | .exp' <~/iap.header) - (now))
            rich --style green -p "Session expires in $exp seconds."
        else
            rich --style blue -p "Invoking [bold italic]msi-bitbucket.sh[/bold italic]"
            rich --style italic -p "From [blue]https://confluence.mot-solutions.com/display/REMOT/Bitbucket+Access+Flow[/blue] (last updated [bold]03-Nov-2022[/bold])."
            rich --style italic -p "Saved to [blue]s3://duybui-msi-shellscripts/msi-bitbucket.sh[/blue] in [blue]sandbox duy[/blue] account."
            test -f ~/setup/msi-bitbucket.sh; or aws --profile=sandbox s3 cp s3://duybui-msi-shellscripts/msi-bitbucket.sh ~/setup/msi-bitbucket.sh
            test -f ~/setup/msi-bitbucket.sh; and bash ~/setup/msi-bitbucket.sh
        end
    end

    rich -a rounded -S blue --style blue -p "ActiveEye Gateway"
    for pod in op hawk wasp lion orca wolf bear seal wren
        rich --style blue -p "Invoking [bold italic]https://gateway1.$pod.activeeye.com/login[/bold italic]"
        xdg-open "https://gateway1.$pod.activeeye.com/gateway"
    end
end
