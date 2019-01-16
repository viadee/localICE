[![Build Status](https://travis-ci.com/viadee/localICE.svg?branch=master)](https://travis-ci.com/viadee/localICE)
[![Coverage status](https://codecov.io/gh/viadee/localICE/branch/master/graph/badge.svg)](https://codecov.io/github/viadee/localICE?branch=master)

# localICE
Local Individual Conditional Expectation (localICE) is a local explanation approach from the field of eXplainable Artificial Intelligence (XAI). This is the repository of the ```R```-package ```localICE```.

# Theory
Local Individual Conditional Expectation (localICE) is a local explanation approach from the field of eXplainable Artificial Intelligence (XAI). It is proposed in the master thesis of Martin Walter as an extension to ICE and is a three-dimensional local explanation for particular data instances. The three dimensions are the two features at the horizontal and vertical axes as well as the target represented by different colors. The approach is applicable for classification and regression problems to explain interactions of two features towards the target. The given instance is added to the plot as two dotted lines according to the feature values. The ```localICE```-package can explain features of type ```factor``` and ```numeric``` of any machine learning model. For some model types, a predict function has to be provided as an argument in order to get access to the model, as described in the package description. For classification models, the number of classes can be more than two and each class is added as a different color to the plot.

See Goldstein et al (2013) at http://arxiv.org/abs/1309.6392 for the ICE approach. 

# Examples
### Regression

![regression]

### Classification
![classification]

# Installation
The package is planned to be released at CRAN. Till then, please use the following commands to install it:
```
if(require("devtools")){
  install_github("viadee/localICE")  
}
```

Restart your session in RStudio after installation:
```
.rs.restartR()
```

# License
BSD 3-Clause License

# Authors
Martin Walter - *Initial work* - [Martin Walter](https://github.com/aiwalter)


[regression]: 
https://github.com/viadee/localICE/blob/master/images/regression.png
"Regression"

[classification]: 
https://github.com/viadee/localICE/blob/master/images/classification.png
"Classification"
