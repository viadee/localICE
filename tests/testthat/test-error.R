context("test error")

test_that("Classification as regression", {

  if(require("randomForest")){
  rf = randomForest(Species ~., data = iris, ntree = 100)

  expect_error(
    localICE(
      instance = iris[3,],
      data = iris,
      feature_1 = "Sepal.Length",
      feature_2 = "Petal.Width",
      target = "Species",
      model = rf,
      regression = T,
      step_1 = 0.1,
      step_2 = 0.1
    )
  )
  }
})
# test_that("Regression as classification", {
#
#   if(require("randomForest")){
#   rf = randomForest(Petal.Width ~., data = iris, ntree = 100)
#
#   expect_error(
#     localICE(
#       instance = iris[3,],
#       data = iris,
#       feature_1 = "Sepal.Length",
#       feature_2 = "Species",
#       target = "Petal.Width",
#       model = rf,
#       regression = F,
#       step_1 = 0.1,
#       step_2 = 0.1
#     )
#   )
#   }
#
# })

