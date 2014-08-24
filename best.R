best <- function(state, disease, last = FALSE) {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  outcome <- read.csv(".data/outcome-of-care-measures.csv")
  
  if (!(state %in% outcome$State)) {
    stop("invalid state")
  }
  
  match <- function(disease) {
    if (disease == "heart attack")
      11
    else if (disease == "heart failure")
      17
    else if (disease == "pneumonia")
      23
    else
      stop("invalid outcome")
  }
  
  col <- match(disease)
  
  outcome.in.state <- outcome[outcome$State == state, ]
  # outcome.in.state <- outcome.in.state[!is.na(outcome.in.state[, col]), ]
  outcome.in.state[, col] <- as.numeric(outcome.in.state[, col])
  
  outcome.in.state.sorted <- outcome.in.state[order(outcome.in.state$Hospital.Name), ]

  func <- ifelse(last, which.max, which.min)
  
  observation <- outcome.in.state.sorted[func(outcome.in.state.sorted[, col]), ]
  
  # observation <- outcome.in.state[which.min(outcome.in.state[, col]), ]
  # print(colnames(observation)[col])
  toString(observation$Hospital.Name)
}