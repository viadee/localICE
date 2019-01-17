context("test arguments")

test_that("aruments", {

  if(require("randomForest")){
    rf = randomForest(Species ~., data = iris, ntree = 10)

    # wrong step_1
    expect_error(
      localICE(
        instance = iris[1,],
        data = iris,
        feature_1 = "Sepal.Length",
        feature_2 = "Petal.Width",
        target = "Species",
        model = rf,
        regression = F,
        step_1 = 0,
        step_2 = 0.5
      )
    )
    # wrong step_2
    expect_error(
      localICE(
        instance = iris[1,],
        data = iris,
        feature_1 = "Sepal.Length",
        feature_2 = "Petal.Width",
        target = "Species",
        model = rf,
        regression = F,
        step_1 = 0.5,
        step_2 = 0
      )
    )
    # wrong data input
    expect_error(
      localICE(
        instance = iris[1,],
        data = "iris",
        feature_1 = "Sepal.Length",
        feature_2 = "Petal.Width",
        target = "Species",
        model = rf,
        regression = F,
        step_1 = 0.5,
        step_2 = 0.5
      )
    )
    # no target
    expect_error(
      localICE(
        instance = iris[1,],
        data = iris,
        feature_1 = "Sepal.Length",
        feature_2 = "Petal.Width",
        model = rf,
        regression = F,
        step_1 = 0.5,
        step_2 = 0.5
      )
    )
    # no model
    expect_error(
      localICE(
        instance = iris[1,],
        data = iris,
        feature_1 = "Sepal.Length",
        feature_2 = "Petal.Width",
        target = "Species",
        regression = F,
        step_1 = 0.5,
        step_2 = 0.5
      )
    )
    # missing feature_1
    expect_error(
      localICE(
        instance = iris[1,],
        data = iris,
        feature_2 = "Petal.Width",
        target = "Species",
        model = rf,
        regression = F,
        step_1 = 0.5,
        step_2 = 0.5
      )
    )
    # missing feature_2
    expect_error(
      localICE(
        instance = iris[1,],
        data = iris,
        feature_1 = "Sepal.Length",
        target = "Species",
        model = rf,
        regression = F,
        step_1 = 0.5,
        step_2 = 0.5
      )
    )
    # missing data
    expect_error(
      localICE(
        instance = iris[1,],
        feature_1 = "Sepal.Length",
        feature_2 = "Petal.Width",
        target = "Species",
        model = rf,
        regression = F,
        step_1 = 0.5,
        step_2 = 0.5
      )
    )
    # missing instance
    expect_error(
      localICE(
        data = iris,
        feature_1 = "Sepal.Length",
        feature_2 = "Petal.Width",
        target = "Species",
        model = rf,
        regression = F,
        step_1 = 0.5,
        step_2 = 0.5
      )
    )
  }
})
