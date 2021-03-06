#!/bin/bash

set -e
source $HOME/.bash_profile

cd $GOSRC
source $(dirname $0)/lib.sh

req_env_var "
GOSRC $GOSRC
OS_RELEASE_ID $OS_RELEASE_ID
OS_RELEASE_VER $OS_RELEASE_VER
"

if [[ "$UID" == "0" ]]
then
    echo "Error: Expected to be running as a regular user"
    exit 1
fi

echo "."
echo "Hello, my name is $USER and I live in $PWD can I be your friend?"

record_timestamp "rootless test start"

cd "$GOSRC"
make
make varlink_generate
make test-binaries
make ginkgo

record_timestamp "rootless test end"
