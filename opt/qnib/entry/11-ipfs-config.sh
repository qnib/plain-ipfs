#!/bin/bash
GATEWAY_PORT=${GATEWAY_PORT:-8080}
API_PORT=${API_PORT:-5001}

MY_IP=$(ip route |awk '/eth0/{print $NF}')
MY_IP=$(ip route |tail -n1 |awk '{print $NF}')
IPFS_DATA=${IPFS_DATA-/data/ipfs/}
cd ${IPFS_DATA}

if [ "X${IPFS_BIND_IP}" != "X" ];then
    ipfs config Addresses.Gateway /ip4/${IPFS_BIND_IP}/tcp/${GATEWAY_PORT}
    ipfs config Addresses.API /ip4/${IPFS_BIND_IP}/tcp/${API_PORT}
else
    if [ "X${IPFS_GATEWAY_ADDR}" != "X" ];then
        ipfs config Addresses.Gateway /ip4/${IPFS_GATEWAY_ADDR}/tcp/${GATEWAY_PORT}
    else
        ipfs config Addresses.Gateway /ip4/${MY_IP}/tcp/${GATEWAY_PORT}
    fi
    if [ "X${IPFS_API_ADDR}" != "X" ];then
        ipfs config Addresses.API /ip4/${IPFS_API_ADDR}/tcp/${API_PORT}
    else
        ipfs config Addresses.API /ip4/${MY_IP}/tcp/${API_PORT}
    fi
fi
