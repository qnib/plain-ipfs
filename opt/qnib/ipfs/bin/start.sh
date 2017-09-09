#!/bin/bash

if [[ "X${IPFS_OFFLINE_MODE}" = "Xtrue" ]];then
    if [[ "X${IPFS_OPTS}" == "X" ]];then
        IPFS_OPTS="--offline"
    else
        IPFS_OPTS="${IPFS_OPTS} --offline"
    fi
fi

ipfs daemon --routing ${IPFS_ROUTING:-dht} ${IPFS_OPTS}
