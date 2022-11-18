#!/bin/bash
set -e

for f in examples/*/ projects/*/; do 
    if [ ! -e "${f}" ]; then continue; fi
    cd $f && terraform init -reconfigure && terraform validate && cd -
done
