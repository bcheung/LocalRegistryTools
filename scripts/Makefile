JULIA_DIR=/Users/bcheung/Documents/SoftwareProjects/julia
LOCAL_REG_TOOLS=/Users/bcheung/Documents/SoftwareProjects/julia/LocalRegistryTools
SCRIPTS=$(LOCAL_REG_TOOLS)/scripts
PKG_DIR=$(JULIA_CENTRAL_DEPOT)/dev
LOCAL_REG_NAME=Local
LOCAL_REG=$(JULIA_DIR)/Registries/$(LOCAL_REG_NAME)

all: get_pkgs build_local_registry

get_pkgs:
	julia $(LOCAL_REG_TOOLS)/src/get_pkgs.jl $(LOCAL_REG_TOOLS)

build_local_registry:
	$(SCRIPTS)/build_local_registry.sh $(JULIA_DIR) $(PKG_DIR) $(LOCAL_REG_NAME)

add_pkgs:
	julia $(LOCAL_REG_TOOLS)/src/add_pkgs.jl $(LOCAL_REG_TOOLS) $(LOCAL_REG)

build: build_local_registry add_pkgs

clean:
	rm -rf $(JULIA_CENTRAL_DEPOT)/*
	rm -rf $(LOCAL_REG)

.PHONY: build clean get_pkgs build_local_registry all