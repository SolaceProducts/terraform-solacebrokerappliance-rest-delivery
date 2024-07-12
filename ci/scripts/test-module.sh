#!/bin/bash
# Basic terraform test on a config.
# Params: $1 is the directory name, @2 (optional) additional argument to pass to terraform commands, $3 (optional), the module registry URL, $4 (optional), the module version
set -e
pushd "$1"
if [ -n "$3" ] ; then sed -i "s@source =.*@source = \"$3\"@g" main.tf; fi
if [ -n "$4" ] ; then sed -i "s@# version =.*@version = \"$4\"@g" main.tf; fi
cat main.tf
terraform init
terraform validate
# Create
export SOLACEBROKER_SKIP_API_CHECK=true
terraform plan $2
terraform apply -auto-approve $2
# terraform plan $2 | grep "No changes"
sleep 1
terraform destroy -auto-approve
popd