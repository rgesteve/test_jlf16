#!/usr/bin/env julia

using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Glob

function t16()
  numType = Float16
  A = rand(numType, 10000, 10000)
  B = rand(numType, 10000, 10000)
  C = Array{numType,2}(undef, 10000, 10000)
  @time C .= A .* B
end

function t32()
  numType = Float32
  A = rand(numType, 10000, 10000)
  B = rand(numType, 10000, 10000)
  C = Array{numType,2}(undef, 10000, 10000)
  @time C .= A .* B
end

println("**** Starting run")
#println("-----------------------")
#fs = glob("*.toml", ".")

println("Running f16 version")
#time16 = t16()
t16()
println("Running f32 version")
#time32 = t32()
t32()

#println("Running times: f16: $(time16), f32: $(time32) .");
println("----- DONE -----")

