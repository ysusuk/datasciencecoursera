best <- function(state, disease) {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  match <- function(disease) {
    if (disease == "heart attack")
      11
    else if (disease == "heart failure")
      17
    else if (disease == "pneumonia")
      23
  }
  
  col <- match(disease)
  
  outcome <- read.csv(".data/outcome-of-care-measures.csv")
  outcome.in.state <- outcome[outcome$State == state,]
  outcome.in.state[, col] <- as.numeric(outcome.in.state[, col])
  observation <- outcome.in.state[which.min(outcome.in.state[, col]), ]
  observation$Hospital.Name
}