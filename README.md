# gled-builder

Builds [Gled](https://github.com/gled-project/gled) together with the
external software it needs, ROOT included, into one install prefix. Gled
itself does not need gled-builder: it builds against any ROOT and any
prefix that has its externals (see `gled-build/INSTALL` in the gled
repository).

## Externals

The recipes in `external/<package>/` build these packages from source
tarballs:

| package | version in the cache | needed by |
|---|---|---|
| root | 6.40.04-gled (the v6-40-04 tag without docs) | GledCore |
| fltk | 1.3.6 | GledCore |
| ftgl | 2.1.2-gled (ROOT 6.28's FTGL, built static) | GledCore |
| DevIL | 1.7.4 | Geom1 |
| gts | 0.7.7-gled (a 2008 snapshot) | GledGTS |
| openal | 1.23.1 | Audio1 |
| freealut | 1.1.0-gled | Audio1 |

A recipe takes the newest tarball of its package from the local cache,
`cache/`, or downloads it from `rsync://rsync.gled.org/cache/HEAD`.
`update_cache.pl` fetches newer versions of the tarballs already in the
cache.

Install the build tools and the system libraries first: autoconf, automake,
libtool, cmake, rsync and git; the X11, OpenGL, GLU, freetype, libpng and
libjpeg development packages.

## Building

```sh
autoconf
./configure [--prefix=/opt/gled] [VAR=value ...]
make
```

`make` builds the externals that the selected libsets need, clones gled
into `gled/gled`, configures and builds it, and installs everything into
the prefix, by default `install/` here. The variables, also listed by
`./configure --help`:

| variable | default | |
|---|---|---|
| `LIBSETS` | `GledCore Audio1 GledGTS Geom1 Numerica Var1` | libsets to build, with their dependencies |
| `GLED_REPO`, `GLED_REF` | the GitHub repository, `main` | where to clone gled from |
| `GLED_HEP_REPO`, `GLED_HEP_REF` | empty, `main` | when set, gled-hep is cloned into `gled/gled-hep` and put on the libset path |
| `CACHE_DIR`, `CACHE_URL`, `CACHE_TAG` | `cache/`, the rsync server, `HEAD` | source tarballs |
| `MAKE_J_OPT` | `-j4` | parallel build |
| `ROOT_GLED_DEBUG` | empty | when set, ROOT and gled are built for debugging |
| `EXTRA_PATHS` | empty | `:`-separated prefixes added to the compiler and linker paths |

For the hep libsets:

```sh
./configure GLED_HEP_REPO=https://github.com/gled-project/gled-hep.git \
  LIBSETS="GledCore Geom1 Numerica Audio1 Net1 GledGTS Var1 RootGeo Alice AliEnViz XrdMon"
```

`configure-tag.sh <tag>` and `configure-branch.sh <branch>` configure the
build of a tag or branch of gled and gled-hep with the externals of the same
name on the rsync server.

Smaller steps:

```sh
make external            # externals of the selected libsets
make external-all        # all externals
make external-no-root    # all externals but ROOT
make -C external gts     # one package, with its dependencies
make -C external/gts unpack | configure | build | install
make -C gled checkout | configure | build | install
make -C gled update      # git pull; then make rebuilds
```

## Running

```sh
. <prefix>/gled-env.sh
cd <prefix>/demos/Geom1
gled images.C
```

`gled-env.csh` does the same for csh, and `gled-env-dump.sh` prints the
settings for a profile. From the build tree, `. binenv.sh` in
`gled/gled/gled-build` sets up the same environment.

## License

gled-builder is free software under the GNU Lesser General Public License,
version 3 or later. See `LICENSE`, `COPYING` and `COPYING.LESSER`. The
packages it builds keep their own licenses.
