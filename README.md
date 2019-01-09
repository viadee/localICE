# localICE
Local Individual Conditional Expectation (localICE) is a local explanation approach from the field of eXplainable Artificial Intelligence (XAI). This is the repository of the ```R```-package ```localICE```.

# Theory
Local Individual Conditional Expectation (localICE) is a local explanation approach from the field of eXplainable Artificial Intelligence (XAI). It is proposed in the master thesis of Martin Walter as an extension to ICE and is a three-dimensional local explanation for particular data instances. The three dimensions are the two features at the horizontal and vertical axes as well as the target represented by different colors. The approach is applicable for classification and regression problems to explain interactions of two features towards the target. The plot for discrete targets looks similar to plots of cluster algorithms like k-means, where different clusters represent different predictions. The given instance is added to the plot two dotted lines according to the feature values. The ```localICE```-package can explain features of type ```factor``` and ```numeric```. 

See Goldstein et al (2013) at http://arxiv.org/abs/1309.6392 for the ICE approach. 

# Example
## Regression

![regression]

## Classification
![classification]


[regression]: 
https://github.com/viadee/localICE/blob/master/Examples/regression.png
"Regression"

[classification]: 
https://github.com/viadee/localICE/blob/master/Examples/classification.png
"Classification"
