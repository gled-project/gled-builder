#!/bin/bash

# Runs configure script with arguments appropriate for building of a
# tagged version.
#
# NOTE: It is assumed that rsync server with external packages has a
# directory with the provided tag.

if [ $# -lt 1 ]; then
  echo "Usage: $0 <tag> [other options and variable assignments]"
  exit 1
fi

if [ ! -e "configure" ]; then
  echo "configure script not found, try running autoconf."
  exit 1
fi

TAG=$1
shift

./configure CACHE_TAG=$TAG GLED_REF=$TAG GLED_HEP_REF=$TAG "$@"
