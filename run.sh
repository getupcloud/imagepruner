#!/bin/bash

keep-complete=${KEEP_COMPLETE:-5}
keep-failed=${KEEP_FAILED:-1}
keep-tags=${KEEP_TAGS:-5}
keep-younger=${KEEP_YOUNGER:-24h}


oc adm prune deployments --orphans --keep-complete=$keep-complete --keep-failed=$keep-failed --keep-younger-than=$keep-younger --confirm

oc adm prune builds --orphans --keep-complete=$keep-complete --keep-failed=$keep-failed --keep-younger-than=keep-younger --confirm

oc adm prune images --keep-tag-revisions=$keep-tags --keep-younger-than=$keep-younger --confirm
