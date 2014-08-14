complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  complete <- function(what, with) {
    if (nchar(what) == 1)
      paste0(with, with, what)
    else if (nchar(what) == 2)
      paste0(with, what)
  }

  read <- function(monitorId) {
    read.csv(paste0(directory, "/", complete(monitorId, "0"), ".csv"))
    # apply(observations, 1, is.na)
  }
  
  observations <- sapply(id, read)
}