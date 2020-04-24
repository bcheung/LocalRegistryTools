import Pkg

root = ARGS[1]

file = "$root/config/pkgs.txt"
failed_pkgs = Dict()
dep_set = Set()
deps = []

# initialize dequeue and set with requested packages
open(file) do file
  while !eof(file)
    pkg_name = readline(file)
    if !in(pkg_name, dep_set)
      push!(dep_set, pkg_name)
      push!(deps, pkg_name)
    end
  end
end

Pkg.Registry.add("General")

# dfs for dependencies
while !isempty(deps)
  try
    dep = pop!(deps)
    Pkg.develop(dep)
    for (uuid, pkg) in Pkg.dependencies()
      pkg_name = pkg.name
      if !in(pkg_name, dep_set)
        push!(dep_set, pkg_name)
        push!(deps, pkg_name)
      end
    end
    Pkg.rm(pkg)
  catch err
    failed_pkgs[pkg] = err
    @error "Failed to add package:" pkg err
  end
end

Pkg.Registry.rm("General")

open("$root/config/deps.txt") do deps_file
  for dep in dep_set
    write(deps_file, "$dep\n")
  end
end

@info "Packages cloned:" dep_set
@error "Failed to add packages:" failed_pkgs