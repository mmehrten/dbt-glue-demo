#!/bin/bash
set -e

for f in modules/*/ examples/*/ projects/*/; do 
    if [ ! -e "${f}" ]; then continue; fi
    terraform-docs $f > $f/README.md; 
    cd ${f} && terraform fmt && cd -
done
