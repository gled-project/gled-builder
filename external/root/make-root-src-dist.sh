#!/bin/sh
#
# make-root-src-dist.sh - make a source distribution of root
#
# Modified version of root/build/unix/makedistsrc.sh
# Fix the following variables before running:

# svnurl="https://github.com/root-project/root/branches/v5-34-00-patches"
# version="5.34.05"

# svnurl="https://github.com/root-project/root/branches/dev/matevz/5.34-patches-gled"
# version=5.34.01

# tag="v5-34-38"
# version="5.34.38"

tag="v6-40-04"
version="6.40.04"

dir="root"
tarfile="root-$version-gled.tar"

echo "Checking out ..."

rm -rf $dir
git clone -b $tag --single-branch --depth 1 https://github.com/root-project/root.git $dir
cd $dir

# echo "Merging gled-related changes ..."
# For 5.26.01, FTGL stuff
# svn merge -c 32740 $svntrunk

# echo "Generating etc/svninfo.txt"
# build/unix/svninfo.sh

# echo "Remove .svn directories ..."
# find . -depth -type d -name .svn -exec rm -rf {} \;

echo "Removing docs and git stuff ..."
find . -depth -type d -name  doc -exec rm -rf {} \;
rm -rf documentation
rm -rf .git .github
cd ..

echo "Making tarball ..."

tar cf $tarfile $dir
gzip -9 $tarfile

#rm -rf $dir

echo "Done!"
