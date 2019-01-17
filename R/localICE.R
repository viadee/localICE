#' @import ggplot2
#' @import stats
#' @import utils
#' @export
localICE = function(instance,
                    data,
                    feature_1,
                    feature_2,
                    target,
                    model,
                    predict.fun = NULL,
                    regression = TRUE,
                    step_1 = 1,
                    step_2 = 1) {
  for (feature in c(feature_1, feature_2)) {
    if (class(data[, feature]) %in% c("logical", "character"))
      stop(
        paste(
          feature,
          "is not allowed to be of type 'logical' or 'character'.
          Please select another feature or convert it to type 'factor'
          and train your model again with feature type 'factor'!"
        )
        )
  }
  # Swap features
  if (class(data[, feature_1]) != "factor" &&
      class(data[, feature_2]) == "factor") {
    feature_temp = feature_1
    feature_1 = feature_2
    feature_2 = feature_temp
    step_temp = step_1
    step_1 = step_2
    step_2 = step_temp
  }
  # Predict fun
  if (!is.function(predict.fun)) {
    predict.fun = function(model, newdata) {
      prediction = predict(model, newdata)
      prediction = as.data.frame(prediction)
      prediction = prediction$prediction
      return(prediction)
    }
  }
  # Init
  point_matrix = matrix(NA, nrow = 0, ncol = ncol(instance) + 1)
  colnames(point_matrix) = c(colnames(instance), "target")
  instance_temp = instance
  error_1 = " is too big or too small for your data.
  Please use a different step, maybe even < 1"
  # One categorical feature:
  if (class(data[, feature_1]) == "factor" &&
      class(data[, feature_2]) != "factor") {
    num_categorical_features = 1
    if (step_2 > max(data[feature_2]) - min(data[feature_2]) ||
        step_1 <= 0) {
      stop(paste("Step = ",
                 step_2, error_1))
    }
    max_progress_steps = nlevels(instance_temp[, feature_1]) * (max(data[feature_2]) - min(data[feature_2])) / step_2
    count_progress = 0
    progress = txtProgressBar(min = 0,
                              max = max_progress_steps,
                              style = 3)
    for (i in unique(data[, feature_1])) {
      instance_temp[, feature_1] = factor(x = i, levels = unique(data[, feature_1]))
      for (j in seq(min(data[feature_2]), max(data[feature_2]), by = step_2)) {
        instance_temp[, feature_2] = j
        pred = predict.fun(model, instance_temp)
        pred = as.vector(pred)
        point_matrix = rbind(point_matrix, c(instance_temp, pred))
        count_progress = count_progress + 1
        setTxtProgressBar(progress, count_progress)
      }
    }
  }
  # Two categorical features
  else if (class(data[, feature_1]) == "factor" &&
           class(data[, feature_2]) == "factor") {
    num_categorical_features = 2
    count_progress = 0
    progress = txtProgressBar(min = 0,
                              max = nlevels(instance_temp[, feature_1]),
                              style = 3)
    for (i in unique(data[, feature_1])) {
      instance_temp[, feature_1] = factor(x = i, levels = levels(data[, feature_1]))
      for (j in unique(data[, feature_2])) {
        instance_temp[, feature_2] = factor(x = j, levels = levels(data[, feature_2]))
        pred = predict.fun(model, instance_temp)
        pred = as.vector(pred)
        point_matrix = rbind(point_matrix, c(instance_temp, pred))
      }
      count_progress = count_progress + 1
      setTxtProgressBar(progress, count_progress)
    }
  }
  # No categorical features
  else {
    num_categorical_features = 0
    if (step_1 > max(data[feature_1]) - min(data[feature_1]) ||
        step_1 <= 0) {
      stop(paste("Step = ",
                 step_1,
                 " of ",
                 feature_1, error_1))
    }
    if (step_2 > max(data[feature_2]) - min(data[feature_2]) ||
        step_2 <= 0) {
      stop(paste("Step = ",
                 step_2,
                 " of ",
                 feature_2, error_1))
    }
    progress = txtProgressBar(min = 0,
                              max = 1,
                              style = 3)
    for (i in seq(min(data[feature_1]), max(data[feature_1]), by = step_1)) {
      instance_temp[, feature_1] = i
      for (j in seq(min(data[feature_2]), max(data[feature_2]), by = step_2)) {
        instance_temp[, feature_2] = j
        pred = predict.fun(model, instance_temp)
        pred = as.vector(pred)
        point_matrix = rbind(point_matrix, c(instance_temp, pred))
      }
      setTxtProgressBar(progress, (i - min(data[feature_1])) / (max(data[feature_1]) - min(data[feature_1])))
    }
  }
  point_matrix = as.data.frame(point_matrix)
  if (num_categorical_features == 1) {
    explanation = ggplot(point_matrix,
                         aes(as.character(point_matrix[, feature_1]),
                             as.numeric(point_matrix[, feature_2]))) +
      scale_x_discrete(labels = unique(data[, feature_1]))

  } else if (num_categorical_features == 2) {
    explanation = ggplot(point_matrix,
                         aes(
                           as.character(point_matrix[, feature_1]),
                           as.character(point_matrix[, feature_2])
                         )) +
      scale_x_discrete(labels = unique(data[, feature_1])) +
      scale_y_discrete(labels = unique(data[, feature_2]))
  } else {
    explanation = ggplot(point_matrix,
                         aes(as.numeric(point_matrix[, feature_1]),
                             as.numeric(point_matrix[, feature_2])))
  }
  if (regression == TRUE) {
    # Regression
    explanation = explanation +
      scale_fill_gradientn(colours = c("#852339", "white"),
                           name = paste(target, " = ", round(
                             predict.fun(model, instance), digits = 1
                           ))) +
      geom_raster(aes(fill = unlist(point_matrix$target)), interpolate = T)
  } else {
    # Classification"
    explanation = explanation +
      scale_fill_manual(
        values = c(
          "#852339",
          "#c89ca6",
          "#8797a3",
          "#435c8b",
          "#009cb3",
          "#e77c12",
          "#87bf2a",
          "#5e5e65"
        ),
        name = paste(target, " = ", predict.fun(model, instance))
      ) +
      geom_raster(aes(fill = unlist(point_matrix$target)), interpolate = F)
  }
  # plot
  explanation = explanation +
    xlab(paste(feature_1, " = ", instance[, feature_1])) +
    ylab(paste(feature_2, " = ", instance[, feature_2])) +
    theme_bw()
  if (num_categorical_features == 1) {
    explanation = explanation +
      geom_vline(
        xintercept = which(unique(data[, feature_1]) == as.character(instance[, feature_1])),
        linetype = "dotted",
        color = "black",
        size = 1
      ) +
      geom_hline(
        yintercept = instance[, feature_2],
        linetype = "dotted",
        color = "black",
        size = 1
      )
  } else if (num_categorical_features == 2) {
    explanation = explanation +
      geom_vline(
        xintercept = which(unique(data[, feature_1]) == as.character(instance[, feature_1])),
        linetype = "dotted",
        color = "black",
        size = 1
      ) +
      geom_hline(
        yintercept = which(unique(data[, feature_2]) == as.character(instance[, feature_2])),
        linetype = "dotted",
        color = "black",
        size = 1
      )
  } else {
    explanation = explanation +
      geom_vline(
        xintercept = instance[, feature_1],
        linetype = "dotted",
        color = "black",
        size = 1
      ) +
      geom_hline(
        yintercept = instance[, feature_2],
        linetype = "dotted",
        color = "black",
        size = 1
      )
  }
  explanation = explanation +
    theme(legend.position = "bottom") +
    scale_size(guide = guide_legend(direction = "vertical"))
  close(progress)
  return(explanation)
  }
