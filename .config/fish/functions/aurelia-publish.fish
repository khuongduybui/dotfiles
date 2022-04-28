# Defined in /tmp/fish.Cu2l2h/aurelia-publish.fish @ line 1
function aurelia-publish
    if not test -d aurelia_project
        echo "Not in an aurelia project root directory"
    else
        if test (count $argv) = 0
            echo "Usage: aurelia-publish s3_bucket_name [s3_bucket_prefix]"
        else
            set -l bucket $argv[1]
            set -l prefix ""
            if test (count $argv) = 2
                set -x prefix "/$argv[2]"
            end
            echo "Publishing to $bucket$prefix"
            aws s3 cp ./index.html s3://$bucket$prefix/index.html --acl=public-read
            aws s3 sync ./static s3://$bucket$prefix/static --delete --acl=public-read
            aws s3 sync ./scripts s3://$bucket$prefix/scripts --delete --acl=public-read
        end
    end
end
