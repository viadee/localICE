\name{localICE}
\alias{localICE}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Local Individual Conditional Expectation (localICE)
}
\description{
Local Individual Conditional Expectation (localICE) is a local explanation approach from the field of eXplainable Artificial Intelligence (XAI). It is proposed in the master thesis of the author of this package as an extension to ICE and is a three-dimensional local explanation for particular data instances. The three dimensions are the two features at the horizontal and vertical axes as well as the target represented by different colors. The approach is applicable for classification and regression problems to explain interactions of two features towards the target. The plot for discrete targets looks similar to plots of cluster algorithms like k-means, where different clusters represent different predictions. The given \code{instance} is added to the plot as two dotted lines according to the feature values. The \code{localICE}-package can explain features of type \code{factor} and \code{numeric}.
}
\usage{
localICE(
  instance,
  data,
  feature_1,
  feature_2,
  target,
  model,
  predict.fun = NULL,
  regression = TRUE,
  step_1 = 1,
  step_2 = 1
  )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{instance}{instance is a row of \code{data} that has to be explained by means of localICE.
  }
  \item{data}{a data frame containing all predictors and a representative distribution of data instances (rows). The data set can be the test data from model creation and does not have to contain predictions or true labels. The data set is needed to get the data distribution of \code{feature_1} and \code{feature_2} that should be explained for the given \code{instance}. The data distribution is then used to perturb the values of the two given features.}
  \item{feature_1}{a feature of interest as \code{character}}
  \item{feature_2}{an other feature of interest as \code{character}}
  \item{target}{the name of the target as \code{character}. It is required to name the legend of the plot.}
  \item{model}{a machine learning model as object.}
  \item{predict.fun}{a prediction function if \code{model} is not of type \code{randomForest}, \code{mlr} or \code{caret}. An exemplary function for the machine learning library \code{h2o} is shown below in the "Examples" section}
  \item{regression}{if the model is not a regression problem but a classification problem, then set \code{regression = FALSE}.}
  \item{step_1}{set how accurate the explanation according to \code{feature_1} should be. Step is only required if \code{feature_1} is numeric. The greater the step, the faster the computation and the less accurate the explanation for \code{feature_1}. The step has to be smaller than \code{max(data[,feature_1]) - min(data[,feature_1])} and greater than \code{0}. For integer features, the step should also be an integer to avoid biased model predictions.}
  \item{step_2}{same as \code{step_1} but for \code{feature_2}}

}
\details{
The computation time of \code{localICE} is strongly dependent to the distribution of \code{feature_1}, \code{feature_2} and the steps \code{step_1} and \code{step_2} for numerical features.}
\value{
The function \code{localICE} returns a \code{ggplot2} object that can be modified with further \code{ggplot2} functions.}
\references{
Goldstein, Alex; Kapelner, Adam; Bleich, Justin; Pitkin, Emil (2013): "Peeking Inside the Black Box: Visualizing Statistical Learning With Plots of Individual Conditional Expectation". In: Journal of Computational and Graphical Statistics 24.1 (2013), pp. 44-65. doi: 10.1080/10618600.2014.907095. url: https://doi.org/10.1080/10618600.2014.907095
}
\examples{
# Regression example:
if(require("randomForest")){
  rf = randomForest(Sepal.Length ~., data = iris, ntree = 20)

  explanation = localICE(
    instance = iris[1, ],
    data = iris,
    feature_1 = "Species",
    feature_2 = "Sepal.Width",
    target = "Sepal.Length",
    model = rf,
    regression = TRUE,
    step_2 = 0.1
  )
  plot(explanation)
}

# Classification example:
if(require("randomForest") && require("mlbench")){
  data("PimaIndiansDiabetes")
  rf = randomForest(diabetes ~., data = PimaIndiansDiabetes, ntree = 20)

  explanation = localICE(
    instance = PimaIndiansDiabetes[8, ],
    data = PimaIndiansDiabetes,
    feature_1 = "age",
    feature_2 = "glucose",
    target = "diabetes",
    model = rf,
    regression = FALSE,
    step_1 = 5,
    step_2 = 5
  )
  plot(explanation)
}
# An example of how to use predict.fun to use any machine learning library,
# in this case the library h2o (please see GitHub for the complete h2o example):
predict.fun = function(model, newdata){
  prediction = h2o.predict(model, as.h2o(newdata))
  prediction = as.data.frame(prediction)
  prediction = prediction$prediction
  return(prediction)
}
}


