function logistic_reg_predicts(obj, newdata::DataFrame)
    formula = obj.formula
    fm_frame = ModelFrame(formula, newdata)
    X = modelmatrix(fm_frame)
    beta = obj.beta
    z = X * beta

    if (obj.Link == "LogitLink")
        p = exp.(z) ./ (1 .+ exp.(z))

    elseif (obj.Link == "ProbitLink")
        p = Probit_Link.(z)

    elseif (obj.Link == "CauchitLink")
        p = Cauchit_Link.(z)

    elseif (obj.Link == "CloglogLink")
        p = Cloglog_Link.(z)

    else
        println("This link function is not part of logistic regression family.")
        println("-------------------------------------------------------------")
    end
    p
end

function logistic_reg(formula::FormulaTerm, data::DataFrame, Link::GLM.Link)
    formula = apply_schema(formula, schema(formula, data))
    model = glm(formula, data, Binomial(), Link)
    return FrequentistRegression(:LogisticRegression, model)
end

"""
```julia
fitmodel(formula::FormulaTerm, data::DataFrame, modelClass::LogisticRegression, Link::Logit)
```

Fit a Logistic Regression model on the input data using the Logit link. Uses the `glm` method from the [GLM](https://github.com/JuliaStats/GLM.jl) package under the hood. Returns an object of type `FrequentistRegression{:LogisticRegression}`.
"""
function fitmodel(
    formula::FormulaTerm,
    data::DataFrame,
    modelClass::LogisticRegression,
    Link::Logit
)
    return logistic_reg(formula, data, LogitLink())
end

"""
```julia
fitmodel(formula::FormulaTerm, data::DataFrame, modelClass::LogisticRegression, Link::Probit)
```

Fit a Logistic Regression model on the input data using the Probit link. Uses the `glm` method from the [GLM](https://github.com/JuliaStats/GLM.jl) package under the hood. Returns an object of type `FrequentistRegression{:LogisticRegression}`.
"""
function fitmodel(
    formula::FormulaTerm,
    data::DataFrame,
    modelClass::LogisticRegression,
    Link::Probit
)
    return logistic_reg(formula, data, ProbitLink())
end

"""
```julia
fitmodel(formula::FormulaTerm, data::DataFrame, modelClass::LogisticRegression, Link::Cloglog)
```

Fit a Logistic Regression model on the input data using the Cloglog link. Uses the `glm` method from the [GLM](https://github.com/JuliaStats/GLM.jl) package under the hood. Returns an object of type `FrequentistRegression{:LogisticRegression}`.
"""
function fitmodel(
    formula::FormulaTerm,
    data::DataFrame,
    modelClass::LogisticRegression,
    Link::Cloglog
)
    return logistic_reg(formula, data, CloglogLink())
end

"""
```julia
fitmodel(formula::FormulaTerm, data::DataFrame, modelClass::LogisticRegression, Link::Cauchit)
```

Fit a Logistic Regression model on the input data using the Cauchit link. Uses the `glm` method from the [GLM](https://github.com/JuliaStats/GLM.jl) package under the hood. Returns an object of type `FrequentistRegression{:LogisticRegression}`.
"""
function fitmodel(
    formula::FormulaTerm,
    data::DataFrame,
    modelClass::LogisticRegression,
    Link::Cauchit
)
    return logistic_reg(formula, data, CauchitLink())
end
