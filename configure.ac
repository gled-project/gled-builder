dnl Process this file with autoconf to produce a configure script.

#
# AC_ARG_CONF_VAR(<varname>, <desc>, <default-value>)
#
AC_DEFUN([AC_ARG_CONF_VAR],
[
  AC_ARG_VAR([$1], [$2 [$3]])
  if test "x$$1" = "x"; then
    $1=$3
  fi
])

#
# AC_EXEC_AND_EVAL(<command>, <run-intro>)
#
AC_DEFUN([AC_EXEC_AND_EVAL],
[
  { echo "$as_me:$LINENO: checking $2" >&5
    echo $ECHO_N "$2... $ECHO_C" >&6; }
  ene_result=`$1`
  if test $? != 0; then
    echo "${ECHO_T}error"
    echo "$ene_result"
    exit 1
  else
    eval $ene_result
    { echo "$as_me:$LINENO: result: ok ${ECHO_N}${ene_result}" >&5
      echo "${ECHO_T}ok" >&6; }
  fi
])


AC_INIT(gled-builder, 0)


AC_PROG_INSTALL

AC_PREFIX_DEFAULT("`pwd`/install")

AC_CANONICAL_BUILD


AC_ARG_CONF_VAR([CACHE_DIR],
                [local source package cache],
		["$PWD/cache"])

AC_ARG_CONF_VAR([CACHE_TAG],
                [Tag for external software],
		["HEAD"])

AC_ARG_CONF_VAR([CACHE_URL],
                [remote source package cache],
		["rsync://rsync.gled.org/cache/\${CACHE_TAG}"])

AC_ARG_CONF_VAR([GLED_REPO],
                [Gled git repository],
		["https://github.com/gled-project/gled.git"])

AC_ARG_CONF_VAR([GLED_REF],
                [Gled branch or tag to check out],
		["main"])

AC_ARG_CONF_VAR([GLED_HEP_REPO],
                [gled-hep git repository, cloned next to gled when set],
		[""])

AC_ARG_CONF_VAR([GLED_HEP_REF],
                [gled-hep branch or tag to check out],
		["main"])

AC_ARG_CONF_VAR([GTS_CXX_REPO],
                [gts-cxx git repository],
		["https://github.com/gled-project/gts-cxx.git"])

AC_ARG_CONF_VAR([GTS_CXX_REF],
                [gts-cxx branch or tag to check out],
		["main"])

AC_ARG_CONF_VAR([LIBSETS],
                [Gled libsets to build (space separated; dependencies are not checked)],
		["GledCore Audio1 GledGTS Geom1 Numerica Var1"])

AC_ARG_CONF_VAR([MAKE_J_OPT],
		[parallel build option (for packages that support it)],
		["-j4"])

AC_ARG_CONF_VAR([EXTRA_PATHS],
		[':' separated list of directories to use for build],
		[""])

AC_ARG_CONF_VAR([ROOT_GLED_DEBUG],
		[Set to build ROOT and Gled in debug mode.],
		[""])

# Redefine CFLAGS to empty if not set by user.
AC_ARG_CONF_VAR([CFLAGS],
                [Flags for C compiler],
		[""])

# Redefine CXXFLAGS to empty if not set by user.
AC_ARG_CONF_VAR([CXXFLAGS],
                [Flags for C++ compiler],
		[""])


AC_PROG_CPP
AC_PROG_CC
AC_PROG_CXX
AC_LANG([C++])


AC_EXEC_AND_EVAL([./compiler-version.pl $CC],
                 [determining compiler version])
AC_SUBST(CC_VERSION)
AC_SUBST(CC_MAJOR)
AC_SUBST(CC_MINOR)


AC_EXEC_AND_EVAL([./distro-details.pl $build_os],
                 [determining OS distribution details])

AC_SUBST(distro_vendor)
AC_SUBST(distro_name)
AC_SUBST(distro_version)


AC_CONFIG_FILES([GledBuildConf.pm MakeBuildConf.inc])
AC_OUTPUT
