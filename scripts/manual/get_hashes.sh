JULIA_DIR=$1
PACKAGE_DIR=$JULIA_DIR/Packages

for pkg in $PACKAGE_DIR/*; do
  echo "git-tree-sha1 = \"$(cd $pkg && git rev-parse HEAD:./)\"" >> $JULIA_DIR/package_hashes.txt
done

