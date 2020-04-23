JULIA_DIR=$1
PACKAGE_DIR=$JULIA_DIR/Packages

for dir in $PACKAGE_DIR/*; do
  (cd $dir &&
  git init &&
  git add -A &&
  git commit -m "Initial commit");
done
