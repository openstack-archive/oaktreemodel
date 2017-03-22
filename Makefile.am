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

ACLOCAL_AMFLAGS = -I m4

PYTHON ?= python3
SUFFIXES =
lib_LTLIBRARIES = liboaktreemodel.la
noinst_LTLIBRARIES =

SUBDIRS= .

DIST_SUBDIRS = ${SUBDIRS}

BUILT_SOURCES=
BUILT_MAINT_SRC=
EXTRA_DIST= \
	    config/pandora_vc_revinfo \
	    ${top_srcdir}/m4/*m4

CLEANFILES= \
	$(top_builddir)/oaktree-go-stamp \
	${BUILT_SOURCES}
DISTCLEANFILES=		config/top.h

MAINTAINERCLEANFILES=
MAINTAINERCLEANFILES+= autom4te.cache

maintainer-clean-local:
	find . -type f -name '*~' -exec rm -f '{}' \;
	-rm -rf @PACKAGE@-*.rpm
	-rm -rf @PACKAGE@-*.tar.gz
	-rm -r -f autom4te.cache
	-rm -f Makefile.in
	-rm -f aclocal.m4
	-rm -f config/config.guess
	-rm -f config/config.sub
	-rm -f config/depcomp
	-rm -f config/install-sh
	-rm -f config/ltmain.sh
	-rm -f config/missing
	-rm -f config.in
	-rm -f config.log
	-rm -f config.status
	-rm -f configure
	-rm -f m4/libtool.m4
	-rm -f m4/ltoptions.m4
	-rm -f m4/ltsugar.m4
	-rm -f m4/ltversion.m4
	-rm -f m4/lt~obsolete.m4


liboaktreemodel_la_CXXFLAGS = ${AM_CXXFLAGS} ${PROTOSKIP_WARNINGS} ${NO_WERROR}
liboaktreemodel_la_SOURCES = \
	oaktreemodel/common.pb.cc \
	oaktreemodel/flavor.pb.cc \
	oaktreemodel/floating_ip.pb.cc \
	oaktreemodel/image.pb.cc \
	oaktreemodel/security_group.pb.cc \
	oaktreemodel/oaktree.pb.cc \
	oaktreemodel/oaktree.grpc.pb.cc

pkginclude_HEADERS = \
	oaktreemodel/common.pb.h \
	oaktreemodel/flavor.pb.h \
	oaktreemodel/floating_ip.pb.h \
	oaktreemodel/image.pb.h \
	oaktreemodel/security_group.pb.h \
	oaktreemodel/oaktree.pb.h \
	oaktreemodel/oaktree.grpc.pb.h

# TODO: There is a lot of repetition here
BUILT_SOURCES += \
	oaktreemodel/common.pb.cc \
	oaktreemodel/common.pb.h \
	oaktreemodel/common_pb2.py \
	oaktreemodel/flavor.pb.cc \
	oaktreemodel/flavor.pb.h \
	oaktreemodel/flavor_pb2.py \
	oaktreemodel/floating_ip.pb.cc \
	oaktreemodel/floating_ip.pb.h \
	oaktreemodel/floating_ip_pb2.py \
	oaktreemodel/image.pb.cc \
	oaktreemodel/image.pb.h \
	oaktreemodel/image_pb2.py \
	oaktreemodel/oaktree.grpc.pb.cc \
	oaktreemodel/oaktree.grpc.pb.h \
	oaktreemodel/oaktree.pb.cc \
	oaktreemodel/oaktree.pb.h \
	oaktreemodel/oaktree_pb2.py \
	oaktreemodel/security_group.pb.cc \
	oaktreemodel/security_group.pb.h \
	oaktreemodel/security_group_pb2.py

GO_BUILT_FILES = \
	common.pb.go \
	flavor.pb.go \
	floating_ip.pb.go \
	image.pb.go \
	oaktree.pb.go \
	security_group.pb.go
if HAVE_GO_PLUGIN
BUILT_SOURCES += $(GO_BUILT_FILES)
endif

PROTO_FILES = \
	oaktreemodel/common.proto \
	oaktreemodel/flavor.proto \
	oaktreemodel/floating_ip.proto \
	oaktreemodel/image.proto \
	oaktreemodel/security_group.proto \
	oaktreemodel/oaktree.proto
EXTRA_DIST += $(PROTO_FILES)

SUFFIXES += .proto .grpc.pb.cc .grpc.pb.h .pb.cc .pb.h py .pb.go
PROTOS_PATH=${top_srcdir}
PROTO_OUTPUT=${top_builddir}
.proto.grpc.pb.cc:
	$(PROTOC) -I $(PROTOS_PATH) \
        	--grpc_out=${PROTO_OUTPUT} \
		--plugin=protoc-gen-grpc=${GRPC_CPP_PLUGIN} $<
.proto.grpc.pb.h:
	$(PROTOC) -I $(PROTOS_PATH) \
        	--grpc_out=${PROTO_OUTPUT} \
		--plugin=protoc-gen-grpc=${GRPC_CPP_PLUGIN} $<
.proto.pb.cc:
	$(PROTOC) -I $(PROTOS_PATH) --cpp_out=${PROTO_OUTPUT} $<

.proto.pb.h:
	$(PROTOC) -I $(PROTOS_PATH) --cpp_out=${PROTO_OUTPUT} $<

oaktree-go-stamp: $(GO_BUILT_FILES)
	go build $(top_srcdir) && touch oaktree-go-stamp

$(GO_BUILT_FILES): $(PROTO_FILES)
	$(PROTOC) -I $(PROTOS_PATH) --go_out=${GOPATH}/src $(PROTOS_PATH)/oaktreemodel/*.proto

# Have to do this with make matching not automake matching
# Yay _pb2.py extension!
%_pb2.py: %.proto
	$(PYTHON) -m grpc_tools.protoc -I $(PROTOS_PATH) \
		--python_out=${PROTO_OUTPUT} \
		--grpc_python_out=${PROTO_OUTPUT} $<
