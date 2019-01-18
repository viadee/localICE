[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![Build Status](https://travis-ci.com/viadee/localICE.svg?branch=master)](https://travis-ci.com/viadee/localICE)
[![codecov](https://codecov.io/gh/viadee/localICE/branch/master/graph/badge.svg)](https://codecov.io/gh/viadee/localICE)


# localICE
*Local Individual Conditional Expectation (localICE)* is a local explanation approach from the field of *eXplainable Artificial Intelligence (XAI)*. This is the repository of the ```R```-package ```localICE```.

# Introduction
localICE is a model-agnostic XAI approach which provides three-dimensional local explanations for particular data instances. The approach is proposed in the master thesis of Martin Walter as an extension to ICE. The three dimensions are the two features at the horizontal and vertical axes as well as the target represented by different colors. The approach is applicable for classification and regression problems to explain interactions of two features towards the target. For classification models, the number of classes can be more than two and each class is added as a different color to the plot. The given instance is added to the plot as two dotted lines according to the feature values. The ```localICE```-package can explain features of type ```factor``` and ```numeric``` of any machine learning model. Automatically supported machine learning libraries are \code{MLR}, \code{randomForest}, \code{caret} or all other with an \code{S3} predict functions. For further model types from other libraries, a predict function has to be provided as an argument in order to get access to the model, as described below by means of an \code{h2o} example. 

See Goldstein et al. (2013) at http://arxiv.org/abs/1309.6392 for the ICE approach. 

# Examples
### Regression

![regression]

### Classification
![classification]

### Using ```localICE``` with any machine learning library, in this case with ```h2o```:
```splus
if(require("h2o") && require("mlbench")){
  h2o.init()
  # Wrapping the h2o predict function and data type:
  predict.fun = function(model,newdata){
    prediction = h2o.predict(model, as.h2o(newdata))
    prediction = as.data.frame(prediction)
    return(prediction$predict)
  }
  data("PimaIndiansDiabetes")
  rf = h2o.randomForest(y = "glucose", training_frame = as.h2o(PimaIndiansDiabetes))
  explanation = localICE(
    instance = PimaIndiansDiabetes[1,],
    data = PimaIndiansDiabetes,
    feature_1 = "age",
    feature_2 = "diabetes",
    target = "glucose",
    model = rf,
    regression = TRUE,
    predict.fun = predict.fun,
    step_1 = 5
  )
  plot(explanation)
  h2o.shutdown(prompt = FALSE)
}
```
# Installation
The package is planned to be released at CRAN. Till then, please use the following commands to install it:
```splus
if(require("devtools")){
  install_github("viadee/localICE")  
}
```

Restart your session in RStudio after installation:
```splus
.rs.restartR()
```

# License
BSD 3-Clause License

# Authors
[Martin Walter](https://github.com/aiwalter) - *Initial work*


[regression]: 
https://github.com/viadee/localICE/blob/master/images/regression.png
"Regression"

[classification]: 
https://github.com/viadee/localICE/blob/master/images/classification.png
"Classification"
