#!/usr/bin/env julia

using Pkg
Pkg.activate(".")
Pkg.instantiate()

using LinearAlgebra
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

function cosine_distance2(v1, v2)
  # Ensure vectors are of the same length
  if length(v1) != length(v2)
    error("Vectors must have the same length")
  end

  # Dot product and norms
  dot_product = sum(v1 .* v2)
  norm_v1 = sqrt(sum(v1 .^ 2))
  norm_v2 = sqrt(sum(v2 .^ 2))

  return 1.0 - dot_product / (norm_v1 * norm_v2)
end

const DIMEN = 3072 # VilBERT -- image/text embeddings
#const DIMEN = 1536
#const DIMEN = 768 # a la CLiP
#const DIMEN = 300 # a la word2vec
const ITER = 100000

function cd16()
  numType = Float16

  for i in 1:ITER
    v1 = rand(numType, DIMEN)
    v2 = rand(numType, DIMEN)
    d = cosine_distance2(v1, v2)
    #println("The result of the distance calculation is $(d)..")
  end
end

function cd32()
  numType = Float32

  for i in 1:ITER
    v1 = rand(numType, DIMEN)
    v2 = rand(numType, DIMEN)
    d = cosine_distance2(v1, v2)
    #println("The result of the distance calculation is $(d)..")
  end
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
#t16()
@time cd16()
println("Running f32 version")
#time32 = t32()
#t32()
@time cd32()

#println("Running times: f16: $(time16), f32: $(time32) .");

#d = cosine_distance(emb_doc, emb_query)
#end_time = System.nanoTime()
#elapsed_time = (end_time - start_time) / 1e9 # convert to seconds
#elapsed_time = @elapsed cosine_distance(emb_doc, emb_query)


println("----- DONE -----")

