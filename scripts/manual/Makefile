JULIA_DIR=/Users/bcheung/Documents/SoftwareProjects/julia
LOCAL_REG_TOOLS=/Users/bcheung/Documents/SoftwareProjects/julia/LocalRegistryTools
SCRIPTS=$(LOCAL_REG_TOOLS)/scripts/manual
PKGS=$(JULIA_DIR)/Packages
LOCAL_REG=$(JULIA_DIR)/Registries/Local

all: download extract init_git create_local_registry register

download:
	$(SCRIPTS)/download_pkgs.sh $(JULIA_DIR)

extract:
	$(SCRIPTS)/extract_pkgs.sh $(JULIA_DIR)

init_git:
	$(SCRIPTS)/init_git.sh $(JULIA_DIR)

create_local_registry:
	$(SCRIPTS)/create_local_registry.sh $(JULIA_DIR) $(LOCAL_REG_TOOLS)

register:
	$(SCRIPTS)/register_pkgs.sh $(JULIA_DIR) $(LOCAL_REG_TOOLS)

build: extract init_git create_local_registry register

clean:
	rm -rf $(PKGS)
	rm -rf $(LOCAL_REG)

.PHONY: build clean download extract init_git create_local_registry register all