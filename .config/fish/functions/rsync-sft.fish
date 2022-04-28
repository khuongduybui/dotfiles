function rsync-sft
    echo [WEB_WASP] >~/.allsshrc
    sft list-servers --columns hostname | grep web | grep wasp >>~/.allsshrc
    echo [WEB_LION] >>~/.allsshrc
    sft list-servers --columns hostname | grep web | grep lion >>~/.allsshrc
end
