best <- function(state, outcome) {
  ## Read outcome data
  da <- read.csv("./hospitaldata/outcome-of-care-measures.csv")
  ## Check that state and outcome are valid
  states <- unique(da$State)
  if (!(state %in% states)) {
    stop("invalid state")
  }
  
  outIdx <- 0L
  if (outcome == "heart attack") {
    outIdx <- 11L
  }
  else if (outcome == "heart failure") {
    outIdx <- 17L
  }
  else if(outcome == "pneumonia") {
    outIdx <- 23L
  }
  else {
    stop("invalid outcome")
  }
  ## Return hospital name in that state with lowest 30-day death rate
  da <- da[da$State == state, c(2, outIdx)]
  drate <- as.numeric(da[, 2])
  nhospital <- length(drate)
  
  bestHospital <- ""
  lowestRate <- 100
  for (i in 1:nhospital) {
    if(is.na(drate[i])) next
    if(drate[i] < lowestRate) {
      lowestRate <- drate[i]
      bestHospital <- da[i, 1]
    }
    else if(drate[i] == lowestRate && da[i, 1] < bestHospital) {
      bestHospital <- da[i, 1]
    }
  }
  bestHospital
}