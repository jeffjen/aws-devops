#!/bin/bash

CLUSTER=
STRATEGY=spread

while [ $# -gt 0 ]; do
    case ${1} in
        --cluster)
            shift 1; CLUSTER=${1}; shift 1
            ;;
        --strategy)
            shift 1; STRATEGY=${1}; shift 1
            ;;
    esac
done

if [ -z ${CLUSTER} ]; then
    echo "I need a CLUSTER identity"
    exit 1
fi

if [ -z ${DISCOVERY_URI} ]; then
    echo "I need DISCOVERY_URI identity"
    exit 2
fi

docker run -d --restart=always --name ${CLUSTER} \
    swarm \
    manage -H tcp://0.0.0.0:2375 --strategy ${STRATEGY} etcd://${DISCOVERY_URI}/${CLUSTER}
