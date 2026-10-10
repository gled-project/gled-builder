#!/usr/bin/perl

# Output of this file is dumped into make-config.inc

use lib "../..";
use GledBuildExternal;

$package  = "root";

$homepage = "https://root.cern/";

$comment  = <<"FNORD";
OO framework for data analysis, storage and more.
Released under LGPL-2.1.
FNORD

$parallel = 1;

setup_package($package);

# ROOT 6 is CMake-only -- the ./configure of the 5.x days is long gone, so we
# drive cmake directly instead of going through target_configure().  Build tree
# lives inside TARDIR so that 'make clean' (rm -fr ${TARDIR}) takes it along.

my $builddir = "build-gled";

my @cmake_args =
  (
   "-DCMAKE_INSTALL_PREFIX=\${PREFIX}/root",
   "-DCMAKE_BUILD_TYPE=" . ($ROOT_GLED_DEBUG ? "Debug" : "RelWithDebInfo"),
   # Gled is built with root-config --cflags, so the standard has to be the
   # one ROOT itself was compiled with; GledGTS's gts-cxx needs C++23.
   "-DCMAKE_CXX_STANDARD=23",
   # Was '--disable-builtin-freetype'; the FTGL in GledCore links the
   # system freetype and the two must agree.
   "-Dbuiltin_freetype=OFF",
   # Gled needs the GL renderers and the FLTK-side GUI, nothing from tmva.
   "-Dopengl=ON",
   "-Dtmva=OFF",
   # 6.40 fails without GIF/LZ4 development packages; use the builtins.
   "-Dbuiltin_gif=ON",
   "-Dbuiltin_lz4=ON",
  );

# ROOT used to be picky about xrootd/hdfs versions; keep the escape hatch.
# Contents are passed to cmake verbatim, so use -Dfoo=bar form.
if (defined $ENV{'GLED_ROOT_CONFIG_OPTS'})
{
  push @cmake_args, $ENV{'GLED_ROOT_CONFIG_OPTS'};
}

my $cmake_args = join(" \\\n    ", @cmake_args);

target('configure', <<"FNORD");
cmake -S . -B $builddir \\
    $cmake_args
FNORD

target('build', <<"FNORD");
cmake --build $builddir ${MAKE_J_OPT}
FNORD

target('install', <<"FNORD");
cmake --install $builddir
FNORD

# GledCore carries its own FTGL (Rnr/GL/FTGL.{h,cxx}); ROOT's is no longer
# installed for it.
