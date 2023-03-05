#! /usr/bin/env sh

if ! which sft >/dev/null 2>&1; then
    # https://help.okta.com/asa/en-us/Content/Topics/Adv_Server_Access/docs/sft-ubuntu.htm
    curl -fsSL https://dist.scaleft.com/GPG-KEY-OktaPAM-2023 | gpg --dearmor | sudo tee /usr/share/keyrings/oktapam-2023-archive-keyring.gpg >/dev/null
    echo "deb [signed-by=/usr/share/keyrings/oktapam-2023-archive-keyring.gpg] https://dist.scaleft.com/repos/deb jammy okta" | sudo tee /etc/apt/sources.list.d/scaleft.list
    sudo apt -y update
    sudo apt -y install scaleft-client-tools scaleft-url-handler
fi
