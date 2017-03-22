#!/bin/bash
# Copyright (c) 2016 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.

BASEDIR=$(dirname $0)
export GOPATH=${GOPATH:-$HOME}
[[ ":$PATH:" != *":$GOPATH/bin:"* ]] && export PATH=$GOPATH/bin:$PATH

if ! type glide ; then
    curl https://glide.sh/get | sh
fi

if ! protoc --version | grep -q 3\. ; then
    echo "Protobuf v3 required - installing"
    $BASEDIR/install-proto3.sh
fi

if [ -z $VIRTUAL_ENV ]; then
    python3 -m pip install pbr
else
    python3 -m pip install --user pbr
fi

glide install
