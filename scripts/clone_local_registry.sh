JULIA_DIR=$1
DEPOT_DEV_DIR=$JULIA_DIR/$2
LOCAL_REG=$JULIA_DIR/Registries/$3

if [ ! -d $LOCAL_REG ]
then
  # copy General registry
  git clone https://github.com/JuliaRegistries/General.git $LOCAL_REG
  rm -rf $LOCAL_REG/.git

  # manually create Registry.toml
  # write registry information
  echo "name = \"Local\"" >> $LOCAL_REG/Registry2.toml
  echo "uuid = \"$(julia -e 'import UUIDs; println(UUIDs.uuid4())')\"" >> $LOCAL_REG/Registry2.toml
  echo "repo = \"$LOCAL_REG\"" >> $LOCAL_REG/Registry2.toml
  echo "description = \"This is a local registry\"" >> $LOCAL_REG/Registry2.toml
  echo >> $LOCAL_REG/Registry2.toml
  echo "[packages]" >> $LOCAL_REG/Registry2.toml
  # copy registry package uuid keys
  grep " = { name = " $LOCAL_REG/Registry.toml >> $LOCAL_REG/Registry2.toml
  rm $LOCAL_REG/Registry.toml
  mv $LOCAL_REG/Registry2.toml $LOCAL_REG/Registry.toml
  (cd $LOCAL_REG && git init && git add -A && git commit -m "Initial commit: cloned General registry and generated new Registry.toml");
fi

for pkg_path in $DEPOT_DEV_DIR/*
do
  pkg=$(awk -F'/' '{print $(NF)}'<<<"$pkg_path")
  reg_pkg_path=$(echo $pkg | cut -c1 | tr [a-z] [A-Z])/$pkg
  grep -v "repo = " $LOCAL_REG/$reg_pkg_path/Package.toml > $LOCAL_REG/$reg_pkg_path/Package2.toml; mv $LOCAL_REG/$reg_pkg_path/Package2.toml $LOCAL_REG/$reg_pkg_path/Package.toml
  echo "repo = \"$pkg_path/.git\"" >> $LOCAL_REG/$reg_pkg_path/Package.toml
  # populate registry package uuid keys manually
  # uuid=$(tr -d '"' <<< $(awk -F' = ' '{print $2}'<<<"$(grep "uuid = " $LOCAL_REG/$reg_pkg_path/Package.toml)"))
  # echo "$uuid = { name = \"$pkg\", path = \"$reg_pkg_path\" }" >> $LOCAL_REG/Registry.toml
done

(cd $LOCAL_REG && git add -A && git commit -m "Updated registry");
