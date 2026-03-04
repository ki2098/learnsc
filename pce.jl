using DataFrames, CSV, PolyChaos

include("foo.jl")

function run_pce(N; degree=5)
    if degree > N
        degree = N
    end
    op = GaussOrthoPoly(degree, Nrec=N+1, addQuadrature=true)

    x = op.quad.nodes
    w = op.quad.weights
    y = foo.(x)
    τ = computeSP2(op)
    f = zeros(degree+1)

    for i=1:N
        ψ = vec(evaluate(x[i], op))
        f .+= (y[i] * w[i]) .* (ψ ./ τ)
    end
    
    mean = f[1]
    var = 0
    for k=2:degree+1
        var += f[k]^2 * τ[k]
    end

    return mean, var
end

df = DataFrame(n=Int[], mean=[], var=[])

for arg in ARGS
    N = parse(Int, arg)
    mean, var = run_pce(N)
    push!(df, [N, mean, var])
end

CSV.write("pce.csv", df)