include ../MakeBuildGled.inc

PACKAGE  := gled
gled_dir := gled/gled-build

all: install


EMPTY :=
CONFIG_FLAGS := --libsets=$(subst ${EMPTY} ${EMPTY},:,$(strip ${GB_LIBSETS}))

ifneq (${GLED_HEP_REPO},)
CONFIG_FLAGS += --libsetpath=../libsets:../../gled-hep
endif

ifneq (${EXTRA_PATHS},)
CONFIG_FLAGS += --extrapaths=${EXTRA_PATHS}
endif

ifneq (${ROOT_GLED_DEBUG},)
CONFIG_FLAGS += --debug
endif


### checkout

checkout:
	${ECHO} -G- Cloning ${PACKAGE} ${GLED_REF}
	${MUTE} rm -rf gled gled-hep $@
	${MUTE} git clone -q --branch ${GLED_REF} ${GLED_REPO} gled
ifneq (${GLED_HEP_REPO},)
	${ECHO} -G- Cloning gled-hep ${GLED_HEP_REF}
	${MUTE} git clone -q --branch ${GLED_HEP_REF} ${GLED_HEP_REPO} gled-hep
endif
	${MUTE} touch $@

### configure

define configure-cmds
ln -sfn ${PREFIX} external;\
. binenv.sh;\
./configure --blobdir=${PREFIX} --external=${PREFIX} ${CONFIG_FLAGS}
endef

configure: checkout

configure:
	${ECHO} -C- Configuring ${PACKAGE}
	${MUTE} rm -f $@
	${MUTE} cd ${gled_dir}; $(configure-cmds)
	${MUTE} touch $@

### build

define build-cmds
. binenv.sh;\
${MAKE} ${MAKE_J_OPT}
endef

build: configure

build:
	${ECHO} -B- Building ${PACKAGE}
	${MUTE} rm -f $@
	${MUTE} cd ${gled_dir}; $(build-cmds)
	${MUTE} touch $@

### install

define install-cmds
. binenv.sh;\
${MAKE} blob_install
endef

install: build

install:
	${ECHO} -I- Installing ${PACKAGE}
	${MUTE} rm -f $@
	${MUTE} cd ${gled_dir}; $(install-cmds)
	${MUTE} rsync -r top-blob/ ${PREFIX}
	${MUTE} touch $@

### update

update: configure
	${ECHO} -U- Updating ${PACKAGE}
	${MUTE} git -C gled pull -q --ff-only
ifneq (${GLED_HEP_REPO},)
	${MUTE} git -C gled-hep pull -q --ff-only
endif
	${MUTE} rm -f build install
	${ECHO} -U- You should run make to build and install the new version.

### clean, distclean

.PHONY: clean distclean

define clean-cmds
. binenv.sh;\
${MAKE} clean
endef


clean:
	${ECHO} -X- Cleaning  ${PACKAGE}
	${MUTE} if test -d ${gled_dir} -a -e configure; then cd ${gled_dir}; $(clean-cmds); fi
	${MUTE} rm -f configure build install

distclean: clean
	${MUTE} rm -f checkout
	${MUTE} rm -fr gled gled-hep

echo_external:
	echo ${EXTERNAL}
