import Pkg
Pkg.instantiate()

import LocalRegistry

function create_registry(registry_path)
  LocalRegistry.create_registry(registry_path, registry_path)
end

create_registry(ARGS[1])
