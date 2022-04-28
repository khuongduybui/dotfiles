# Defined in /tmp/fish.8HJlrw/ssm-get.fish @ line 2
function ssm-get
    if test (count $argv) = 1
        aws secretsmanager get-secret-value --secret-id $argv[1] | jq .SecretString | jq fromjson
    end

    if test (count $argv) = 2
        aws secretsmanager get-secret-value --secret-id $argv[1] | jq .SecretString | jq fromjson | jq .$argv[2]
    end
end
