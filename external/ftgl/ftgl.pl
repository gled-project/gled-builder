#!/usr/bin/perl

# Output of this file is dumped into make-config.inc

use lib "../..";
use GledBuildExternal;

$package  = "ftgl";

$homepage = "http://ftgl.sourceforge.net/";

$comment  = <<"FNORD";
OpenGL font rendering on top of FreeType.
This is ROOT's fork of FTGL 2.1.2, taken from root-6.28.06/graf3d/ftgl, which
adds FTFont::Render(text, w_max, w_fade) and PreRender()/PostRender() -- both
used by GledCore/Rnr/GL.  ROOT dropped the in-tree copy after 6.30 and its
builtin is now upstream 2.4.0, which has neither.
Released under the MIT license.
FNORD

$parallel = 1;

setup_package($package);

# No configure; the tarball ships a plain Makefile.
target('configure', "true");
target('build',     "make ${MAKE_J_OPT} PREFIX=\${PREFIX}");
target('install',   "make install PREFIX=\${PREFIX}");
