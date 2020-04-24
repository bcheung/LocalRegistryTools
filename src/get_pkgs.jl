import Pkg
import DelimitedFiles

root = ARGS[1]
in_file = "$root/config/get_pkgs.txt"

failed_pkgs = Dict()

# initializeß dequeue and set with requested packages
dep_set = Set()
deps = []

open(in_file) do file
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
  dep = pop!(deps)
  try
    Pkg.develop(dep)
    for (uuid, pkg) in Pkg.dependencies()
      pkg_name = pkg.name
      if !in(pkg_name, dep_set)
        push!(dep_set, pkg_name)
        push!(deps, pkg_name)
      end
    end
    Pkg.rm(dep)
  catch err
    failed_pkgs[dep] = err
    @error "Failed to add package:" dep err
  end
end

Pkg.Registry.rm("General")

@info "Packages cloned:" dep_set
DelimitedFiles.writedlm("$root/out/get_pkgs_deps.txt", dep_set)

if !isempty(failed_pkgs)
  @error "Failed to add packages:" failed_pkgs
  DelimitedFiles.writedlm("$root/out/get_pkgs_errors.txt", failed_pkgs, "\t=>\t")
end