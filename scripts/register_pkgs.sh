JULIA_DIR=$1
LOCAL_REG_TOOLS=$2
REG_PATH=$JULIA_DIR/Registries/Local
PKGS_PATH=$JULIA_DIR/Packages
MANIFEST_PATH=$JULIA_DIR/RequestedManifest.toml

for pkg in $PKGS_PATH/*
do
  julia --project=$LOCAL_REG_TOOLS -- $LOCAL_REG_TOOLS/src/register_pkgs.jl "$pkg" "$REG_PATH" "$MANIFEST_PATH"
done