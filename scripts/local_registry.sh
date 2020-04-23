JULIA_DIR=$1
LOCAL_REG_TOOLS=$2
# GEN_REG=$JULIA_DIR/CentralDepot/registries/General
LOCAL_REG=$JULIA_DIR/Registries/Local
# REG_PKGS=$JULIA_DIR/registry_pkgs.txt
# PKG_DIR=$JULIA_DIR/Packages

# use julia LocalRegistry to create local registry
julia --project=$LOCAL_REG_TOOLS -- $LOCAL_REG_TOOLS/src/create_registry.jl "$LOCAL_REG"

# manually create Registry.toml
# mkdir -p $LOCAL_REG

# echo "name = \"Local\"" >> $LOCAL_REG/Registry.toml
# echo "uuid = \"$(julia -e 'import UUIDs; println(UUIDs.uuid4())')\"" >> $LOCAL_REG/Registry.toml
# echo "repo = \"$JULIA_DIR/Registries/Local\"" >> $LOCAL_REG/Registry.toml
# echo "description = \"This is a local registry\"" >> $LOCAL_REG/Registry.toml
# echo >> $LOCAL_REG/Registry.toml
# echo "[packages]" >> $LOCAL_REG/Registry.toml

# copy General registry
# cat $REG_PKGS | while read reg_pkg
# do
#   pkg=$PKG_DIR/$(cut -d'/' -f2 <<<"$reg_pkg")
#   mkdir -p $LOCAL_REG/$reg_pkg
#   cp -r $GEN_REG/$reg_pkg/* $LOCAL_REG/$reg_pkg
#   grep -v "repo = " $LOCAL_REG/$reg_pkg/Package.toml > $LOCAL_REG/$reg_pkg/Package2.toml; mv $LOCAL_REG/$reg_pkg/Package2.toml $LOCAL_REG/$reg_pkg/Package.toml
#   echo "repo = \"$pkg/.git\"" >> $LOCAL_REG/$reg_pkg/Package.toml
#   grep "Installed $pkg " $JULIA_DIR/packages.txt | awk -F'= v' '{print "[["$2"]]"}' > $LOCAL_REG/$reg_pkg/Versions.toml
#   echo "git-tree-sha1 = \"$(cd $pkg && git rev-parse HEAD:./)\"" >> $LOCAL_REG/$reg_pkg/Versions.toml
#   # grep "version = " $pkg/Project.toml | awk -F' = ' '{print "[["$2"]]"}' > $LOCAL_REG/$pkg/Versions.toml
#   # echo "git-tree-sha1 = \"$(cd $pkg && git rev-parse HEAD:./)\"" >> $LOCAL_REG/$pkg/Versions.toml
#   grep "\"$reg_pkg\"" $GEN_REG/Registry.toml >> $LOCAL_REG/Registry.toml
# done

# (cd $LOCAL_REG && git init && git add -A && git commit -m "Initial commit");