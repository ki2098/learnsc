using QuasiMonteCarlo, Distributions
using DataFrames, CSV, Statistics
include("foo.jl")

function run_qmc(N)
    dist = Normal()
    s = QuasiMonteCarlo.sample(N, 1, SobolSample())
    x = quantile.(dist, s)
    y = foo.(x)
    m = mean(y)
    return m, varm(y, m)
end

df = DataFrame(n=Int[], mean=[], var=[])

for arg in ARGS
    N = parse(Int, arg)
    m, v = run_qmc(N)
    push!(df, [N, m, v])
end

CSV.write("qmc.csv", df)