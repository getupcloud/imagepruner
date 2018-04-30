#!/bin/bash

keep_complete=${KEEP_COMPLETE:-10}
keep_failed=${KEEP_FAILED:-10}
keep_tags=${KEEP_TAGS:-10}
keep_younger=${KEEP_YOUNGER:-720h}

# only needed for writing a kubeconfig:
master_url=${MASTER_URL:-https://kubernetes.default.svc.cluster.local:443}
master_ca=${MASTER_CA:-/var/run/secrets/kubernetes.io/serviceaccount/ca.crt}
token_file=${TOKEN_FILE:-/var/run/secrets/kubernetes.io/serviceaccount/token}
project=${PROJECT:-default}


# set up configuration for openshift client
if [ -n "${WRITE_KUBECONFIG}" ]; then
    echo Creating kube config
    # craft a kubeconfig, usually at $KUBECONFIG location
    oc config set-cluster master \
  --certificate-authority="${master_ca}" \
  --server="${master_url}"
    oc config set-credentials account \
  --token="$(cat ${token_file})"
    oc config set-context current \
  --cluster=master \
  --user=account \
  --namespace="${project}"
    oc config use-context current
fi

#prune deployments and builds
for i in deployments builds; do
  cmd="oc adm prune $i --orphans \
  --keep-complete=$keep_complete \
  --keep-failed=$keep_failed \
  --keep-younger-than=$keep_younger \
  --confirm"
  echo
  echo "---> $cmd"
  eval $cmd
done

#prune images 
cmd="oc adm prune images \
--keep-tag-revisions=$keep_tags \
--keep-younger-than=$keep_younger \
--confirm"
echo
echo "---> $cmd"
eval $cmd
