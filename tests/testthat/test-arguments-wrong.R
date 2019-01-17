context("wrong arguments")

test_that("aruments", {

  if(require("randomForest")){
    rf = randomForest(Species ~., data = iris, ntree = 10)

    # instance (missing comma)
    expect_error(
      localICE(
        instance = iris[1],
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
    # data (character)
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
    # feauture_1 (no character)
    expect_error(
      localICE(
        instance = iris[1,],
        data = iris,
        feature_1 = Sepal.Length,
        feature_2 = "Petal.Width",
        target = "Species",
        model = rf,
        regression = F,
        step_1 = 0.5,
        step_2 = 0.5
      )
    )
    # feauture_2 (no character)
    expect_error(
      localICE(
        instance = iris[1,],
        data = iris,
        feature_1 = "Sepal.Length",
        feature_2 = Petal.Width,
        target = "Species",
        model = rf,
        regression = F,
        step_1 = 0.5,
        step_2 = 0.5
      )
    )
    # target (no character)
    expect_error(
      localICE(
        instance = iris[1,],
        data = iris,
        feature_1 = "Sepal.Length",
        feature_2 = "Petal.Width",
        target = Species,
        model = rf,
        regression = F,
        step_1 = 0.5,
        step_2 = 0.5
      )
    )
    # model (character)
    expect_error(
      localICE(
        instance = iris[1,],
        data = iris,
        feature_1 = "Sepal.Length",
        feature_2 = "Petal.Width",
        target = "Species",
        model = "rf",
        regression = F,
        step_1 = 0.5,
        step_2 = 0.5
      )
    )
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

    # wrong data input (character)
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
    # wrong data input (numeric)
    expect_error(
      localICE(
        instance = iris[1,],
        data = 1,
        feature_1 = "Sepal.Length",
        feature_2 = "Petal.Width",
        target = "Species",
        model = rf,
        regression = F,
        step_1 = 0.5,
        step_2 = 0.5
      )
    )
    #wrong predict.fun (character)
    expect_error(
      localICE(
        instance = iris[1,],
        data = iris,
        feature_1 = "Sepal.Length",
        feature_2 = "Petal.Width",
        target = "Species",
        model = rf,
        regression = F,
        predict.fun = "predict.fun",
        step_1 = 0.5,
        step_2 = 0.5
      )
    )
  }
})
