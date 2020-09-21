pollutantmean <- function(directory, pollutant, id=1:332) {
  totalLen <- 0L
  for (idx in id) {
    iname <- paste("00", toString(idx), sep="")
    iname <- substr(iname, nchar(iname)-2, nchar(iname))
    fname <- paste(directory, "/", iname, ".csv", sep="")
    da <- read.csv(fname)
    totalLen <- totalLen + length(da[[pollutant]])
  }
  means <- numeric(totalLen)
  currLen <- 0L
  for (idx in id) {
    iname <- paste("00", toString(idx), sep="")
    iname <- substr(iname, nchar(iname)-2, nchar(iname))
    fname <- paste(directory, "/", iname, ".csv", sep="")
    da <- read.csv(fname)
    tmpLen <- length(da[[pollutant]])
    means[(currLen + 1) : (currLen + tmpLen)] <- da[[pollutant]]
    currLen <- currLen + tmpLen
  }
  mean(means, na.rm=TRUE)
}