rankhospital <- function(state, disease, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  
  matchDisease <- function(disease) {
    if (disease == "heart attack")
      11
    else if (disease == "heart failure")
      17
    else if (disease == "pneumonia")
      23
    else
      stop("invalid outcome")
  }
  
  matchNum <- function(num) {
    if (num == "best")
      return (best(state, disease))
    else if (num == "worst")
      # !!! min or max !!!
      return (best(state, disease, TRUE))
    else
      num
  }
  
  col <- matchDisease(disease)
  num <- matchNum(num)
  
  outcome <- read.csv(".data/outcome-of-care-measures.csv")
  
  outcome.in.state <- outcome[outcome$State == state, ]
  # outcome.in.state <- outcome.in.state[!is.na(outcome.in.state[, col]), ]
  outcome.in.state[, col] <- as.numeric(outcome.in.state[, col])
  outcome.in.state.sorted <- outcome.in.state[order(outcome.in.state[, col]), ]
  toString(outcome.in.state.sorted[num, 2])
}