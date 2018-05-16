#!/bin/bash

if oc get serviceaccount image-pruner -n default -o name; then
  oc create serviceaccount image-pruner -n default
  oadm policy add-cluster-role-to-user cluster-admin system:serviceaccount:default:image-pruner
fi

cp pruner.cron /etc/cron.daily/pruner
chmod +x /etc/cron.daily/pruner
