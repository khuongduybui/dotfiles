function ssm-copy-id
    set -l login 'ec2-user'
    set -l idf "$HOME/.ssh/ec2.pem"
    set -l instance ''

    getopts $argv | while read -l key value
        switch $key
            case _
                set instance $value
            case l
                set login $value
            case i
                set idf $value
        end
    end

    set -l ssh_pubkey (cat $idf.pub)
    set -l ssm_cmd "u=\$(getent passwd $login) && x=\$(echo \$u |cut -d: -f6) || exit 1; \
    install -d -m700 -o$login \${x}/.ssh; grep '$ssh_pubkey' \${x}/.ssh/authorized_keys && exit 0; \
    printf '$ssh_pubkey'|tee -a \${x}/.ssh/authorized_keys"
    aws ssm send-command \
        --instance-ids "$instance" \
        --document-name "AWS-RunShellScript" \
        --parameters commands="\"$ssm_cmd\"" \
        --comment "ssm ssh access" | jq
end
