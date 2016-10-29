#  Copyright (C) 2009 Sun Microsystems, Inc.
#  This file is free software; Sun Microsystems, Inc.
#  gives unlimited permission to copy and/or distribute it,
#  with or without modifications, as long as this notice is preserved.

# Which version of the canonical setup we're using
AC_DEFUN([OAKTREE_CANONICAL_VERSION],[0.175])

AC_DEFUN([OAKTREE_CANONICAL_TARGET],[
  ifdef([m4_define],,[define([m4_define],   defn([define]))])
  ifdef([m4_undefine],,[define([m4_undefine],   defn([undefine]))])
  m4_define([PCT_ALL_ARGS],[$*])
  m4_define([PCT_REQUIRE_CXX],[no])
  m4_define([PCT_DONT_SUPPRESS_INCLUDE],[no])
  m4_define([PCT_NO_VC_CHANGELOG],[no])
  m4_define([PCT_VERSION_FROM_VC],[no])
  m4_define([PCT_USE_VISIBILITY],[yes])
  m4_foreach([pct_arg],[$*],[
    m4_case(pct_arg,
      [require-cxx], [
        m4_undefine([PCT_REQUIRE_CXX])
        m4_define([PCT_REQUIRE_CXX],[yes])
      ],
      [skip-visibility], [
        m4_undefine([PCT_USE_VISIBILITY])
        m4_define([PCT_USE_VISIBILITY],[no])
      ],
      [dont-suppress-include], [
        m4_undefine([PCT_DONT_SUPPRESS_INCLUDE])
        m4_define([PCT_DONT_SUPPRESS_INCLUDE],[yes])
      ],
      [no-vc-changelog], [
        m4_undefine([PCT_NO_VC_CHANGELOG])
        m4_define([PCT_NO_VC_CHANGELOG],[yes])
      ],
      [version-from-vc], [
        m4_undefine([PCT_VERSION_FROM_VC])
        m4_define([PCT_VERSION_FROM_VC],[yes])
    ])
  ])

  # We need to prevent canonical target
  # from injecting -O2 into CFLAGS - but we won't modify anything if we have
  # set CFLAGS on the command line, since that should take ultimate precedence
  AS_IF([test "x${ac_cv_env_CFLAGS_set}" = "x"],
        [CFLAGS=""])
  AS_IF([test "x${ac_cv_env_CXXFLAGS_set}" = "x"],
        [CXXFLAGS=""])

  m4_ifdef([AM_SILENT_RULES],[AM_SILENT_RULES([yes])])

  AC_REQUIRE([AC_PROG_CC])

  m4_if(PCT_NO_VC_CHANGELOG,yes,[
    vc_changelog=no
  ],[
    vc_changelog=yes
  ])
  m4_if(PCT_VERSION_FROM_VC,yes,[
    PANDORA_VC_INFO_HEADER
  ],[
    PANDORA_TEST_VC_DIR

    AC_DEFINE_UNQUOTED([PANDORA_RELEASE_VERSION],["$VERSION"],
                       [Version of the software])

    AC_SUBST(PANDORA_RELEASE_VERSION)
  ])

  AC_REQUIRE([AC_PROG_CXX])
  AM_PROG_CC_C_O

  PANDORA_OPTIMIZE

  PANDORA_HEADER_ASSERT

  # Enable PANDORA_WARNINGS once there is C++ code that's not generated, if
  # that's ever a time
  dnl PANDORA_WARNINGS(PCT_ALL_ARGS)

  PANDORA_ENABLE_DTRACE

  AM_CFLAGS="${AM_CFLAGS} ${CC_WARNINGS} ${CC_PROFILING} ${CC_COVERAGE}"
  AM_CXXFLAGS="${AM_CXXFLAGS} ${CXX_WARNINGS} ${CC_PROFILING} ${CC_COVERAGE}"

  AC_SUBST([AM_CFLAGS])
  AC_SUBST([AM_CXXFLAGS])
  AC_SUBST([AM_CPPFLAGS])
  AC_SUBST([AM_LDFLAGS])

])
