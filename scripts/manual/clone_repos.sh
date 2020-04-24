JULIA_DIR=$1
PACKAGE_URLS=$JULIA_DIR/repo_urls.txt
PACKAGE_DIR=$JULIA_DIR/Packages

mkdir -p $PACKAGE_DIR

cat $PACKAGE_URLS | while read url
do
  git clone $url "$PACKAGE_DIR/$(awk -F'/|.jl.git' '{print $(NF-1)}'<<<"$url")"
done