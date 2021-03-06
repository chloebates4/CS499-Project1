#' K Nearest Neighbors Algorithm
#' 
#' A demo R function that wraps our C++ code. 
#'
#' @param X.mat numeric train feature matrix [n x p]
#' @param y.vec numeric train label vector [n], either 
#' all 0/1 for binary classification, or other real numbers
#' for regression (multi-class classification not supposrted).
#' @param testX.vec numeric test feature vector [p]
#' @param max.neighbors scalar integer, max number of neighbors.
#'
#' @return numeric vector of size max neighbors, predictions from 1 to max.neighbors 
#' @export 
#'
#' @examples 
#' data(zip.train, package="ElemStatLearn")
#' i01 <- which(zip.train[,1] %in% c(0,1))
#' train.i <- i01[1:5]
#' test.i <- i01[6]
#' X <- zip.train[train.i, -1]
#' y <- zip.train[train.i, 1]
#' testX <- zip.train[test.i, -1]
#' knn(X, y, testX, 3)
#' zip.train[test.i, 1]
knn <- function(X.mat, y.vec, testX.vec, max.neighbors){
  result.list <- .C(
    "knn_interface", as.double(X.mat), as.double(y.vec), 
    as.double(testX.vec), as.integer(nrow(X.mat)), 
    as.integer(ncol(X.mat)), as.integer(max.neighbors), 
    predictions=double(max.neighbors), PACKAGE="NearestNeighbors")
  result.list$predictions
}

