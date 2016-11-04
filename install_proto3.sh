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

if [ -z $GOPATH ]; then
    echo "oaktreemodel requires a golang environment."
    echo "Please set GOPATH and make sure GOPATH/bin is in your PATH."
    exit 1
fi
GRPCDIR=$GOPATH/src/github.com/grpc/grpc
GRPCVER=$(curl -L http://grpc.io/release)
mkdir -p $(dirname $GRPCDIR)
git clone -b $GRPCVER https://github.com/grpc/grpc $GRPCDIR
pushd $GRPCDIR

git submodule update --init
make
if [ $(id -u) = '0' ] ; then
    SUDO=
else
    SUDO=sudo
fi
$SUDO make install
cd third_party/protobuf
$SUDO make install

popd

go get google.golang.org/grpc
go get -u github.com/golang/protobuf/{proto,protoc-gen-go}
