# gts-cxx, the C++ rewrite of GTS, cloned from its repository as gled is.
# Only the library is built; the test programs need the C GTS library.

TOPDIR = ../..

include ${TOPDIR}/MakeBuildConf.inc

PACKAGE := gts-cxx

all: install

checkout:
	${ECHO} -G- Cloning ${PACKAGE} ${GTS_CXX_REF}
	${MUTE} rm -rf ${PACKAGE} $@
	${MUTE} git clone -q --branch ${GTS_CXX_REF} ${GTS_CXX_REPO} ${PACKAGE}
	${MUTE} touch $@

build: checkout
	${ECHO} -B- Building ${PACKAGE}
	${MUTE} rm -f $@
	${MUTE} ${MAKE} -C ${PACKAGE} ${MAKE_J_OPT} lib
	${MUTE} touch $@

install: build
	${ECHO} -I- Installing ${PACKAGE}
	${MUTE} rm -f $@
	${MUTE} ${MAKE} -C ${PACKAGE} install PREFIX=${PREFIX}
	${MUTE} touch $@

.PHONY: clean distclean

clean:
	${ECHO} -X- Cleaning  ${PACKAGE}
	${MUTE} if test -d ${PACKAGE}; then ${MAKE} -C ${PACKAGE} clean; fi
	${MUTE} rm -f build install

distclean: clean
	${MUTE} rm -f checkout
	${MUTE} rm -fr ${PACKAGE}
