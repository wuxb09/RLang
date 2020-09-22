rankhospital <- function(state, outcome, num = "best") {
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
  da[, 2] <- as.numeric(da[, 2])
  da <- da[!is.na(da[, 2]),] ##filter out NA rows
  names(da) <- c("hname", "drate")
  da <- da[order(da$drate, da$hname), ]
  
  totalHos <- nrow(da)
  bestHos <- ""
  if (num == "best") { bestHos <- da[1, 1] }
  else if (num == "worst") {bestHos <- da[totalHos, 1] }
  else if (!is.na(as.numeric(num))) {
    idx <- as.numeric(num)
    if(idx < 1 || idx > totalHos) {bestHos <- NA}
    else {bestHos <- da[idx, 1]}
  } else {stop("invalid num")}
  bestHos
}