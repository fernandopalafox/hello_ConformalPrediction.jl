
# Hello [ConformalPrediction.jl](https://github.com/JuliaTrustworthyAI/ConformalPrediction.jl/tree/67712e870dc3a438bf0846d376fa48480612f042)

# Resources

- [Patrick Altmeyer's Blog con Conformal Prediction](https://www.paltmeyer.com/blog/posts/conformal-prediction/). Followed this for the most part. 
- [A Gentle Introduction to Conformal Prediction](https://arxiv.org/abs/2107.07511)

# What is this? 
This repo is part of a series where I familiarize myself with a new package, library, or technique. 
To follow along, start a Julia REPL in the root of this repo and type:
```julia
julia> ] instantiate
julia> include("experiment/{experiment_name}.jl")
```

# Notes
 
## What is it? 
Conformal prediction is a method for predicting sets for **any** model that uses **any** heueristic notion of uncertainty. 
## How does it work? 
1. Train a model $\hat{f}(x) \in [0,1]^K$ on the training data set.
2. Set aside a calibration data set with $n$ data points that the model has not seen before. 
3. Then, for each of the calibration data point, construct a prediction set of possible labels such that the probability of the true label being the prediction set is at least $1-\alpha$. To construct this set: 
    1. Compute the conformal score for each data point in the calibration set. $s_i = 1 - \hat{f}(X_i)_{Y_i}$[^1]. This value is high when the softmax output of the true class is low (model is wrong), and high when the softmax output of the true class is high (model is right).
    2. Define the $\hat{q} = \lceil(n+1)(1-\alpha)\rceil/n$ empirical quantile[^2] of the conformal scores $s_1, ... , s_n$. This is essentially the $1-\alpha$ quantile(with a small correction).
    3. Finally, for a test data point of choice $X_{test}$ (that's drawn from the calibration data set), create a prediction set $`C(X_{test}) = \{y: \hat{f}(X_{test})_y \geq 1 - \hat{q}\}`$ . This set will include all classes with a softmax output greater than the $\hat{q}$ quantile. This prediction set is guaranteed to satisfy the following property: $P(Y_{test} \in C(X_{test})) \geq 1 - \alpha$
## Why does it matter? 
- We can use the size of the prediction set to quantify the uncertainty of the model. The larger the set, the more uncertain the model is.
- We can use the prediction set to make a another prediction with rigurous uncertainty. For example, if the prediction set is $\{1,2,3\}$, we can predict that the label is either 1, 2, or 3 with a probability of at least $1-\alpha$.

[^1]: The quantile function ouputs the value of a random variable such that its probability is less than or equal to an input probability value. For examples, the 0.5 quantile of a normal distribution is 0.
[^2]: One can choose any conformal score as long as it returns larger values when there is disagreement between the data $x$ and the label $y$. 

## Other notes 
- Why is the uncertainty of the conformal prediction "rigorous"? 
- $\alpha$ is the error rate

  

