context("return ggplot object")

test_that("Classification as regression", {

  if(require("randomForest")){
  rf = randomForest(Species ~., data = iris, ntree = 100)
  explanation = localICE(
    instance = iris[3,],
    data = iris,
    feature_1 = "Sepal.Length",
    feature_2 = "Petal.Width",
    target = "Species",
    model = rf,
    regression = F,
    step_1 = 0.1,
    step_2 = 0.1)
  }

    expect_class(explanation, "ggplot")


})
