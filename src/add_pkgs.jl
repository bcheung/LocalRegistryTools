import Pkg

root = ARGS[1]
registry_path = ARGS[2]

failed_pkgs = Dict()

Pkg.Registry.add(registry_path)

open("$root/config/deps.txt") do pkgs
  while !eof(pkgs)
    try
      pkg = readline(pkgs)
      Pkg.add(pkg)
    catch err
      failed_pkgs[pkg] = err
      @error "Failed to add package:" pkg err
    end
  end
end

@info "Packages added:" dep_set
@error "Failed to add packages:" failed_pkgs