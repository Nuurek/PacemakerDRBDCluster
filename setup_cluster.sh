#!/usr/bin/env bash

pcs cluster auth n1 n2 n3 -u hacluster -p CHANGEME --force
pcs cluster setup --force --name pejsmejker n1 n2 n3
pcs cluster start --all

pcs property set stonith-enabled=false
pcs property set no-quorum-policy=ignore