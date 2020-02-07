[![CRAN Status Badge](http://www.r-pkg.org/badges/version/localICE)](https://CRAN.R-project.org/package=localICE)
[![GitHub Status Badge](https://img.shields.io/badge/GitHub-0.1.0-green.svg)](https://github.com/viadee/localICE)
[![Build Status](https://travis-ci.com/viadee/localICE.svg?branch=master)](https://travis-ci.com/viadee/localICE)
[![codecov](https://codecov.io/gh/viadee/localICE/branch/master/graph/badge.svg)](https://codecov.io/gh/viadee/localICE)
[![CRAN Downloads](http://cranlogs.r-pkg.org/badges/grand-total/localICE?color=brightgreen
)](https://CRAN.R-project.org/package=localICE)
[![](https://cranlogs.r-pkg.org/badges/localICE)](https://cran.r-project.org/package=localICE)
[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

# localICE
*Local Individual Conditional Expectation (localICE)* is a local explanation approach from the field of *eXplainable Artificial Intelligence (XAI)*. This is the repository of the ```R```-package ```localICE```.

# Introduction
### Idea
localICE is a model-agnostic XAI approach which provides three-dimensional local explanations for particular data instances. The approach is proposed in the master thesis of Martin Walter as an extension to ICE (see Reference). The three dimensions are the two features at the horizontal and vertical axes as well as the target represented by different colors. The approach is applicable for classification and regression problems to explain interactions of two features towards the target. For classification models, the number of classes can be more than two and each class is added as a different color to the plot. The given instance is added to the plot as two dotted lines according to the feature values. The ```localICE```-package can explain features of type ```factor``` and ```numeric``` of any machine learning model. Automatically supported machine learning libraries are ```MLR```, ```randomForest```, ```caret``` or all other with an ```S3``` predict function. For further model types from other libraries, a predict function has to be provided as an argument in order to get access to the model, as described below by means of an example with the ```h2o``` library. 
### Reference
Alex Goldstein et al. *“Peeking Inside the Black Box: Visualizing Statistical Learning With Plots of Individual Conditional Expectation”*. In: *Journal of Computational and Graphical Statistics* 24.1 (2013), pp. 44–65. URL: http://arxiv.org/abs/1309.6392 

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

  # Get data and train a random forest
  data("PimaIndiansDiabetes")
  rf = h2o.randomForest(y = "glucose", training_frame = as.h2o(PimaIndiansDiabetes))

  # Get explanation
  explanation = localICE(
    instance = PimaIndiansDiabetes[1, ],
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
For official version, install via CRAN:
```splus
install.packages("localICE")
require("localICE")
help("localICE")
```
For developmental version, install via GitHub:
```splus
if(require("devtools")){
  install_github("viadee/localICE")  
}
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
