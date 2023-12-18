#!/usr/bin/env julia

using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Glob

println("trying glob")
println("-----------------------")
fs = glob("*.toml", ".")
println("Found $(length(fs)) matches")
println("----- DONE -----")

