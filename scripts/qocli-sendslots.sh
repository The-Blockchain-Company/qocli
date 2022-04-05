#!/usr/bin/env bash

function getStatus() {
    local result
    result=$(/usr/local/bin/qocli status \
        --db /root/scripts/qocli.db \
        --byron-genesis /home/bcc-node/config/mainnet-byron-genesis.json \
        --sophie-genesis /home/bcc-node/config/mainnet-sophie-genesis.json \
        | jq -r .status
    )
    echo "$result"
}

function sendSlots() {
    /usr/local/bin/qocli sendslots \
        --db /root/scripts/qocli.db \
        --byron-genesis /home/bcc-node/config/mainnet-byron-genesis.json \
        --sophie-genesis /home/bcc-node/config/mainnet-sophie-genesis.json \
        --config /root/scripts/pooltool.json
}

statusRet=$(getStatus)

if [[ "$statusRet" == "ok" ]]; then
    mv /root/scripts/sendslots.log /root/scripts/sendslots."$(date +%F-%H%M%S)".log
    sendSlots > /root/scripts/sendslots.log
    find . -name "sendslots.*.log" -mtime +15 -exec rm -f '{}' \;
else
    echo "QOCLI database not synced!!!"
fi

exit 0
