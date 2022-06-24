using CRRao, StatsModels, DataFrames
using Documenter

DocMeta.setdocmeta!(CRRao, :DocTestSetup, :(using CRRao); recursive=true)

makedocs(;
    modules=[CRRao],
    authors="xKDR Forum",
    repo="https://github.com/codetalker7/CRRao.jl/blob/{commit}{path}#{line}",
    sitename="CRRao.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://codetalker.github.io/CRRao.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Manual" => Any[
            "Guide"=> "man/guide.md",
            "Examples"=> "man/examples.md",
        ],
        "API Reference" => Any[
            "General Interface" => "api/interface.md",
            "Frequentist Regression Models" => "api/frequentist_regression.md",
            "Bayesian Regression Models" => "api/bayesian_regression.md"
        ]
    ],
    strict = :doctest
)

deploydocs(;
    repo="github.com/codetalker7/CRRao.jl",
    target = "build",
    devbranch = "with-ghactions"
)
