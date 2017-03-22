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

export GOPATH=${GOPATH:-$HOME}
[[ ":$PATH:" != *":$GOPATH/bin:"* ]] && export PATH=$GOPATH/bin:$PATH

GRPCDIR=$GOPATH/src/github.com/grpc/grpc
GRPCVER=$(curl -L http://grpc.io/release)

mkdir -p $(dirname $GRPCDIR)
# TODO(mordred) Can we get this added to zuul required-projects?
git clone --recursive -b $GRPCVER https://github.com/grpc/grpc $GRPCDIR
pushd $GRPCDIR
make

if [ $(id -u) = '0' ] ; then
    PREFIX_ARG=
    CONFIGURE_ARG=
else
    PREFIX_ARG="prefix=$GOPATH/bin"
    CONFIGURE_ARG="--prefix=$GOPATH"
fi

make install $PREFIX_ARG
pushd third_party/protobuf
./configure $CONFIGURE_ARG
make install
popd  # third_party/protobuf

popd  # $GRPCDIR
