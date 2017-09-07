#!/bin/bash

MY_IP=$(ip route |tail -n1 |awk '{print $NF}')
IPFS_DATA=${IPFS_DATA-/data/ipfs/}
cd ${IPFS_DATA}
ipfs init
sleep 1
#ipfs config Datastore.Path ${IPFS_DATA}
if [ "X${IPFS_BOOTSTRAP_RM_ALL}" == "Xtrue" ];then
    ipfs bootstrap rm --all
fi
for peer in $(echo ${IPFS_BOOTSTRAP_PEERS} |sed -e 's/,/ /g');do
    ipfs bootstrap add ${peer}
done
