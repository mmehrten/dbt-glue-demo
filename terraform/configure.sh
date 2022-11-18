#!/bin/bash
set -e

cd modules 
base=$(pwd)

for f in `find . -type d -d 1`; do 
    ln -sf ${base}/provider.tf ${base}/$f/provider.tf
    ln -sf ${base}/provider-variables.tf ${base}/$f/provider-variables.tf
done
