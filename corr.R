corr <- function(directory, threshold = 0) {
  totalCount <- 0
  for (idx in 1:332) {
    iname <- paste("00", toString(idx), sep="")
    iname <- substr(iname, nchar(iname)-2, nchar(iname))
    fname <- paste(directory, "/", iname, ".csv", sep="")
    da <- read.csv(fname)
    comp <- complete.cases(da)
    if (sum(comp) > threshold) {
      totalCount <- totalCount + 1
    }
  }
  
  corVals <- numeric(totalCount)
  curr <- 0
  for (idx in 1:332) {
    iname <- paste("00", toString(idx), sep="")
    iname <- substr(iname, nchar(iname)-2, nchar(iname))
    fname <- paste(directory, "/", iname, ".csv", sep="")
    da <- read.csv(fname)
    comp <- complete.cases(da)
    if (sum(comp) > threshold) {
      da <- da[comp, ]
      corVals[curr+1] <- cor(da[["sulfate"]], da[["nitrate"]])
      curr <- curr + 1
    }
  }
  corVals
}