#!/bin/bash

# Runs configure script with arguments appropriate for building of a
# given brach.
#
# NOTE: It is assumed that the rsync server with external packages has a
# directory with the provided branch name.

if [ $# -lt 1 ]; then
  echo "Usage: $0 <branch> [other options and variable assignments]"
  exit 1
fi

if [ ! -e "configure" ]; then
  echo "configure script not found, try running autoconf."
  exit 1
fi

BRANCH=$1
shift

./configure CACHE_TAG=$BRANCH GLED_REF=$BRANCH GLED_HEP_REF=$BRANCH "$@"
