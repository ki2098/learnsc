using Distributions
using DataFrames
using CSV
using Statistics
include("foo.jl")

function run_mc(N)
    d = Normal()
    x = rand(d, N)
    y = foo.(x)
    m = mean(y)
    return m, varm(y, m)
end

df = DataFrame(n=Int[], mean=[], var=[])

for arg in ARGS
    N = parse(Int, arg)
    m, v = run_mc(N)
    push!(df, [N, m, v])
end

CSV.write("mc.csv", df)
