dnl -*- bash -*-
dnl Process this file with autoconf to produce a configure script.

dnl Copyright (C) 2009 Sun Microsystems, Inc.
dnl
dnl This program is free software; you can redistribute it and/or modify
dnl it under the terms of the GNU General Public License as published by
dnl the Free Software Foundation; version 2 of the License.
dnl
dnl This program is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl GNU General Public License for more details.
dnl
dnl You should have received a copy of the GNU General Public License
dnl along with this program; if not, write to the Free Software
dnl Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA


AC_INIT(
  [liboaktreemodel],
  [1.0],
  [http://storyboard.openstack.org],
  [liboaktreemodel],
  [http://openstack.org/])

AC_CONFIG_AUX_DIR([config])

AM_INIT_AUTOMAKE([-Wall -Werror -Wno-portability subdir-objects foreign tar-ustar])
AC_PREREQ(2.59)dnl		Minimum Autoconf version required.

AC_CANONICAL_HOST
AC_CANONICAL_BUILD
AC_ARG_PROGRAM
AC_USE_SYSTEM_EXTENSIONS

AC_CONFIG_MACRO_DIR([m4])

AC_CONFIG_HEADERS([config.h])

AC_CONFIG_SRCDIR([oaktreemodel/oaktree.proto])

OAKTREE_CANONICAL_TARGET([require-cxx, version-from-vc]) 

LT_PREREQ([2.4])
LT_INIT
LT_LANG([C++])


gl_VISIBILITY
AX_ASSERT


AS_IF([test "x${pandora_cv_skip_requires}" != "xno"],[

  AC_ARG_WITH([comment],
    [AS_HELP_STRING([--with-comment],
      [Comment about compilation environment. @<:@default=off@:>@])],
    [with_comment=$withval],
    [with_comment=no])
  AS_IF([test "$with_comment" != "no"],[
    COMPILATION_COMMENT=$with_comment
    ],[
    COMPILATION_COMMENT="Source distribution (${PANDORA_RELEASE_COMMENT})"
    ])
  AC_DEFINE_UNQUOTED([COMPILATION_COMMENT],["$COMPILATION_COMMENT"],
    [Comment about compilation environment])
])


PKG_CHECK_MODULES(PROTOBUF, protobuf >= 2.4.0)
AC_SUBST(PROTOBUF_LIBS)
AC_SUBST(PROTOBUF_CFLAGS)
AC_SUBST(PROTOBUF_VERSION)
AM_CFLAGS="${PROTOBUF_CFLAGS} ${AM_CFLAGS}"
AM_LDFLAGS="${PROTOBUF_LIBS} ${AM_LDFLAGS}"

AC_PATH_PROG(
  [PROTOC],
  [protoc],
  [AC_MSG_ERROR([oaktreemodel requires protobuf])],
)

AC_PATH_PROG(
  [GRPC_CPP_PLUGIN],
  [grpc_cpp_plugin],
  [AC_MSG_ERROR([oaktreemodel requires grpc_cpp_plugin])],
)

AC_PATH_PROG(
  [GRPC_PYTHON_PLUGIN],
  [grpc_python_plugin],
  [AC_MSG_ERROR([oaktreemodel requires grpc_python_plugin])],
)

AC_PATH_PROG(
  [GRPC_GO_PLUGIN],
  [protoc-gen-go])

AM_CONDITIONAL([HAVE_GO_PLUGIN], [test "x$ac_cv_path_GRPC_GO_PLUGIN" != "x"])

AX_PTHREAD([
  AM_CXXFLAGS="${PTHREAD_CFLAGS} ${AM_CXXFLAGS}"
  AM_LDFLAGS="${PTHREAD_LIBS} ${AM_LDFLAGS}"
  LIBS="${PTHREAD_LIBS} ${LIBS}"
  ], [AC_MSG_ERROR([oaktreemodel requires pthreads])])

#########################################################################

AS_IF([test "$lt_cv_prog_gnu_ld" = "yes"],[
  LDFLAGS="${LDFLAGS} ${LD_VERSION_SCRIPT}"
  ])

AM_CXXFLAGS="-std=c++11 $AM_CXXFLAGS"

AC_CONFIG_FILES([Makefile])

AC_OUTPUT

echo "---"
echo "Configuration summary for $PACKAGE_NAME version $VERSION"
echo ""
echo "   * Installation prefix:       $prefix"
echo "   * System type:               $host_vendor-$host_os"
echo "   * Host CPU:                  $host_cpu"
echo "   * C++ Compiler:              $CXX_VERSION"
echo "   * C++ Flags:                 $CXXFLAGS"
echo "   * C++ AM Flags:              $AM_CXXFLAGS"
echo "   * CPP Flags:                 $CPPFLAGS"
echo "   * CPP AM Flags:              $AM_CPPFLAGS"
echo "   * Assertions enabled:        $ac_cv_assert"
echo "   * Debug enabled:             $with_debug"
echo "   * Profiling enabled:         $ac_profiling"
echo "   * Coverage enabled:          $ac_coverage"
echo "   * Warnings as failure:       $ac_cv_warnings_as_errors"
echo ""
echo "---"

dnl libtoolize scans configure.ac  and needs to see some text
m4_define([LIBTOOLIZE_AC_INIT], [])
m4_define([UNUSED_MACRO], [
  LT_INIT
  AC_CONFIG_MACRO_DIR([m4])
])
