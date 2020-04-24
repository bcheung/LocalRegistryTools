import Pkg
import DelimitedFiles

root = ARGS[1]
registry_path = ARGS[2]

in_file = "$root/config/add_pkgs.txt"

failed_pkgs = Dict()
dep_set = Set()

Pkg.Registry.add(Pkg.RegistrySpec(path=registry_path))

open(in_file) do pkgs
  while !eof(pkgs)
    try
      pkg = readline(pkgs)
      push!(dep_set, pkg)
      Pkg.add(pkg)
    catch err
      failed_pkgs[pkg] = err
      @error "Failed to add package:" pkg err
    end
  end
end

DelimitedFiles.writedlm("$root/out/add_pkgs_deps.txt", dep_set)
DelimitedFiles.writedlm("$root/out/add_pkgs_errors.txt", failed_pkgs, "\t\t\t\t\t=>\t")

@info "Packages added:" dep_set
@error "Failed to add packages:" failed_pkgs

Pkg.precompile()