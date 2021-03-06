import Pkg
Pkg.instantiate()

import LocalRegistry

function register_pkg(pkg_path, registry_path, manifest_path=nothing)
  @info "ARGS" pkg_path registry_path
  repo = "$pkg_path/.git"
  LocalRegistry.register(pkg_path, registry_path, manifest_path, repo=repo)
end

register_pkg(ARGS...)
