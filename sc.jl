using FastGaussQuadrature
using LinearAlgebra
using DataFrames
using CSV
include("foo.jl")

function run_sc(N)
    x, w = gausshermite(N)

    ξ = x .* sqrt(2)
    ω = w ./ sqrt(pi)

    y = foo.(ξ)

    mean = dot(y, ω)

    M2 = dot(y.^2, ω)

    var = M2 - mean

    return mean, var
end

df = DataFrame(n=Int[], mean=[], var=[])

for arg in ARGS
    N = parse(Int, arg)
    mean, var = run_sc(N)
    push!(df, [N, mean, var])
end

CSV.write("sc.csv", df)