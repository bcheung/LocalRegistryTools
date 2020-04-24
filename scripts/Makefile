JULIA_DIR=/Users/bcheung/Documents/SoftwareProjects/julia
LOCAL_REG_TOOLS=/Users/bcheung/Documents/SoftwareProjects/julia/LocalRegistryTools
SCRIPTS=$(LOCAL_REG_TOOLS)/scripts
PKG_DIR=$(JULIA_CENTRAL_DEPOT_PATH)/dev
LOCAL_REG_NAME=InternalLocal		# must be 1 word, dashes cause issues
LOCAL_REG=$(JULIA_DIR)/Registries/$(LOCAL_REG_NAME)

all: get_pkgs build_local_registry add_pkgs

get_pkgs:
	julia $(LOCAL_REG_TOOLS)/src/get_pkgs.jl $(LOCAL_REG_TOOLS)
	cp $(LOCAL_REG_TOOLS)/out/get_pkgs_deps.txt $(LOCAL_REG_TOOLS)/config/add_pkgs.txt

build_local_registry:
	$(SCRIPTS)/build_local_registry.sh $(JULIA_DIR) $(PKG_DIR) $(LOCAL_REG_NAME)

add_pkgs:
	julia $(LOCAL_REG_TOOLS)/src/add_pkgs.jl $(LOCAL_REG_TOOLS) $(LOCAL_REG)

build: build_local_registry add_pkgs

clean:
	rm -rf $(JULIA_CENTRAL_DEPOT_PATH)/*
	rm -rf $(LOCAL_REG)
	rm -f $(LOCAL_REG_TOOLS)/out/*

.PHONY: build clean get_pkgs build_local_registry all