SHELL = /bin/bash

PACKAGES := root fltk DevIL gts-cxx openal freealut

all: ${PACKAGES}

# Libsets of the gled repository, then of gled-hep.

LIBSETS := GledCore Geom1 Numerica Audio1 Net1 GledGTS Var1 RootGeo Tmp1 \
           Alice AliEnViz XrdMon


# Inter-libset dependencies:

GledCore:
Geom1:    GledCore
Numerica: GledCore
Audio1:   GledCore
Net1:     GledCore
GledGTS:  GledCore Numerica
Var1:     GledCore Geom1 GledGTS Numerica Audio1
RootGeo:  GledCore
Alice:    GledCore Geom1 RootGeo
AliEnViz: GledCore Geom1 Var1
XrdMon:   GledCore Net1
Tmp1:     GledCore Geom1 GledGTS


# Dependencies of libsets on external software

GledCore: root fltk
Geom1:    DevIL
Audio1:   openal freealut
GledGTS:  gts-cxx


.PHONY: ${PACKAGES} ${LIBSETS} all all-but-root

# Currently disabled packages:
#
# lcms - there was really no need for it.
# DevIL:    lcms
#
# glew - used from root (or from system)

all: ${PACKAGES}

all-but-root: $(filter-out root, ${PACKAGES})

# Package dependencies

freealut: openal

# Targets

${PACKAGES}:
	${MAKE} -C $@

%:
	for pkg in ${PACKAGES}; do ${MAKE} -C $$pkg $@; done
