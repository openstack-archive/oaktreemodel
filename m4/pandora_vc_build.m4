dnl  Copyright (C) 2009 Sun Microsystems, Inc.
dnl This file is free software; Sun Microsystems, Inc.
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

AC_DEFUN([PANDORA_TEST_VC_DIR],[
  pandora_building_from_vc=no

  if test -d ".git" ; then
    pandora_building_from_git=yes
    pandora_building_from_vc=yes
  else
    pandora_building_from_git=no
  fi
])

AC_DEFUN([PANDORA_BUILDING_FROM_VC],[
  m4_syscmd(PANDORA_TEST_VC_DIR
    m4_if(PCT_NO_VC_CHANGELOG,yes,[
      vc_changelog=no
      ],[
      vc_changelog=yes
      ])

    [

    if test "${pandora_building_from_git}" = "yes"; then
      echo "# Grabbing changelog and version information from git"
      PANDORA_RELEASE_VERSION=$(python -c "import pbr.version;print(pbr.version.VersionInfo('oaktreemodel').semantic_version().release_string())")
    fi

    if ! test -d config ; then
      mkdir -p config
    fi

    if test "${pandora_building_from_git}" = "yes" -o ! -f config/pandora_vc_revinfo ; then 
      cat > config/pandora_vc_revinfo.tmp <<EOF
PANDORA_RELEASE_VERSION=${PANDORA_RELEASE_VERSION}
EOF
      if ! diff config/pandora_vc_revinfo.tmp config/pandora_vc_revinfo >/dev/null 2>&1 ; then
        mv config/pandora_vc_revinfo.tmp config/pandora_vc_revinfo
      fi
      rm -f config/pandora_vc_revinfo.tmp
    fi
  ])
])

AC_DEFUN([_PANDORA_READ_FROM_FILE],[
  $1=`grep $1 $2 | cut -f2 -d=`
])

AC_DEFUN([PANDORA_VC_VERSION],[
  AC_REQUIRE([PANDORA_BUILDING_FROM_VC])

  PANDORA_TEST_VC_DIR

  AS_IF([test -f ${srcdir}/config/pandora_vc_revinfo],[
    _PANDORA_READ_FROM_FILE(
      [PANDORA_RELEASE_VERSION],${srcdir}/config/pandora_vc_revinfo)
  ])

  VERSION="${PANDORA_RELEASE_VERSION}"
  AC_DEFINE_UNQUOTED(
    [PANDORA_RELEASE_VERSION],
    ["${PANDORA_RELEASE_VERSION}"],
    [The real version of the software])
])

AC_DEFUN([PANDORA_VC_INFO_HEADER],[
  AC_REQUIRE([PANDORA_VC_VERSION])
  m4_define([PANDORA_VC_PREFIX],m4_toupper(m4_normalize(AC_PACKAGE_NAME))[_])

  AC_DEFINE_UNQUOTED(
    PANDORA_VC_PREFIX[RELEASE_VERSION],
    ["$PANDORA_RELEASE_VERSION"],
    [Release date and revision number of checkout])
])
