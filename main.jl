#!/usr/bin/env julia

using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Glob

function cosine_distance(v1, v2)
  # Ensure vectors are of the same length
  if length(v1) != length(v2)
    error("Vectors must have the same length")
  end

  # Calculate numerator (dot product)
  numerator = dot(v1, v2)

  # Calculate denominator (product of norms)
  denominator = norm(v1) * norm(v2)

  # Check for zero denominator to avoid division by zero
  if denominator == 0
    return 1.0  # Cosine distance of orthogonal vectors is 1
  end

  # Calculate and return cosine distance
  return 1.0 - (numerator / denominator)
end

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

#d = cosine_distance(emb_doc, emb_query)
#end_time = System.nanoTime()
#elapsed_time = (end_time - start_time) / 1e9 # convert to seconds
#elapsed_time = @elapsed cosine_distance(emb_doc, emb_query)

println("----- DONE -----")

