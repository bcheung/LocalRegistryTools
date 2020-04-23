JULIA_DIR=$1
COMPRESSED_DIR=$JULIA_DIR/compressed
EXTRACTED_DIR=$JULIA_DIR/extracted
PKG_DIR=$JULIA_DIR/Packages
PACKAGE_URLS=$JULIA_DIR/package_urls.txt

mkdir -p $EXTRACTED_DIR
mkdir -p $PKG_DIR

for file in $COMPRESSED_DIR/*
do
  echo $file
  tar -xzf $file -C $EXTRACTED_DIR
done

for file in $EXTRACTED_DIR/*
do
  package="$PKG_DIR/$(awk -F'-|.jl-' '{print $(NF-1)}'<<<"$file")"
  mv $file $package
done

rm -rf $EXTRACTED_DIR