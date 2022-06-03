"""
Type to represent frequentist models returned by `fitmodel` functions. This type is used internally by the package to represent all frequentist regression models.
"""
struct FrequentistRegression{RegressionType}
   model
end

"""
```julia
FrequentistRegression(::Symbol, model)
```

Constructor for `FrequentistRegression`. `model` can be any regression model. Used by `fitmodel` functions to return a frequentist regression model containers.
"""
FrequentistRegression(RegressionType::Symbol, model) = FrequentistRegression{RegressionType}(model)

"""
```
getRegressionMethod(::FrequentistRegression)
```

Print details about the regression algorithm. This function must be implemented by each `FrequentistRegression` type.
"""
function getRegressionDetails(::FrequentistRegression) end

# Including fitmodel definitions

## Regression Models
include("fitmodel_defs/linear_regression.jl")
include("fitmodel_defs/logistic_regression.jl")
include("fitmodel_defs/negativebinomial_regression.jl")
include("fitmodel_defs/poisson_regression.jl")

"""
```julia
   @fitmodel(formula, args...)
```

Macro for calling `fitmodel` without using `@formula` to create the formula. 

# Example
```julia
using CRRao, RDatasets
sanction = dataset("Zelig", "sanction")
model = @fitmodel(Num ~ Target + Coop + NCost, sanction, NegBinomRegression())
```
"""
macro fitmodel(formula, args...)
   quote
      fitmodel(@formula($formula), $(map(esc, args)...))
   end
end
