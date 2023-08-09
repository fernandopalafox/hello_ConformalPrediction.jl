using MLJ
using Random
Random.seed!(123)

# Data 
X, y = make_moons(500; noise = 0.2)
train, test = partition(eachindex(y), 0.8, shuffle=true)

# Model 
KNNClassifier = @load KNNClassifier pkg = NearestNeighborModels
model = KNNClassifier(;K = 50)

# Training
using ConformalPrediction
model_conf = conformal_model(model; coverage = 0.9)
mach = machine(model_conf, X, y)
fit!(mach, rows = train)

# Select the first point from the test set
Xtest = selectrows(X, first(test))
ytest = selectrows(y, first(test))

# Prediction set for test point Xtest. Returns a set that includes the correct label ytest with probability 0.9
predict(mach, Xtest)[1] # Prediction set for test point Xtest. Returns a set that includes the correct label ytest with probability 0.9
