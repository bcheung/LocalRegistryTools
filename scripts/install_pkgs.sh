JULIA_DIR=$1
COMPRESSED_DIR=$JULIA_DIR/compressed
PACKAGE_URLS=$JULIA_DIR/package_urls.txt

mkdir -p $COMPRESSED_DIR

cat $PACKAGE_URLS | while read url
do
  wget -P $COMPRESSED_DIR $url
done
