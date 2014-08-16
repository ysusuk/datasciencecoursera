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
  
  #if(length(id) == 0) {
  #  id <- 1:332
  #}
  
  improve <- function(what, with) {
    if (nchar(what) == 1)
      paste0(with, with, what)
    else if (nchar(what) == 2)
      paste0(with, what)
    else what
  }

  read <- function(monitorId) {
    file <- paste0(directory, "/", improve(monitorId, "0"), ".csv")
    if(file.exists(file)) {
      read.csv(file)
    }
  }
  
  not.na <- function(x) x[!is.na(x$Date) & !is.na(x$sulfate) & !is.na(x$nitrate) & !is.na(x$ID), ]
  
  observations <- lapply(id, read)
  observations.not.na <- lapply(observations, not.na)
  nobs <- unlist(lapply(observations.not.na, nrow))
  data.frame(id, nobs)
}