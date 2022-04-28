# Defined in /tmp/fish.Vzqxp5/msi-init.fish @ line 2
function msi-init
    aws-sso-util login --all

    echo https://gateway1.hawk.activeeye.com/gateway
    x-www-browser https://gateway1.hawk.activeeye.com/gateway
    echo https://gateway1.wasp.activeeye.com/gateway
    x-www-browser https://gateway1.wasp.activeeye.com/gateway
    echo https://gateway1.lion.activeeye.com/gateway
    x-www-browser https://gateway1.lion.activeeye.com/gateway
    echo https://gateway1.orca.activeeye.com/gateway
    x-www-browser https://gateway1.orca.activeeye.com/gateway
    # echo https://gateway1.ibex.activeeye.com/gateway
    # x-www-browser https://gateway1.ibex.activeeye.com/gateway
    echo https://gateway1.wolf.activeeye.com/gateway
    x-www-browser https://gateway1.wolf.activeeye.com/gateway

    sft list-servers >/dev/null
end
