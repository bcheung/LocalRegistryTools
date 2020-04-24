JULIA_DIR=$1
LOCAL_REG_TOOLS=$2
LOCAL_REG=$JULIA_DIR/Registries/Local

# use julia LocalRegistry to create local registry
julia --project=$LOCAL_REG_TOOLS -- $LOCAL_REG_TOOLS/src/create_registry.jl "$LOCAL_REG"
