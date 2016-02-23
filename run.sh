#!/bin/bash

oc adm prune deployments --orphans --keep-complete=5 --keep-failed=1 --keep-younger-than=24h --confirm

oc adm prune builds --orphans --keep-complete=5 --keep-failed=1 --keep-younger-than=24h --confirm

oc adm prune images --keep-tag-revisions=5 --keep-younger-than=24h --confirm
