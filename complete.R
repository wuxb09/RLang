complete <- function(directory, id=1:332) {
  compCount <- numeric(length(id))
  currLen <- 0
  for (idx in id) {
    iname <- paste("00", toString(idx), sep="")
    iname <- substr(iname, nchar(iname)-2, nchar(iname))
    fname <- paste(directory, "/", iname, ".csv", sep="")
    da <- read.csv(fname)
    comp <- complete.cases(da)
    compCount[currLen+1] <- sum(comp)
    currLen <- currLen + 1
  }
  data.frame(id=id, nobs=compCount)
}