pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  complete <- function(monitor) {
    if (nchar(monitor) == 1)
      paste0("00", monitor)
    else if (nchar(monitor) == 2)
      paste0("0", monitor)
    else monitor
  }
  
  read <- function(monitorId) {
    file <- paste0(directory, "/", complete(monitorId), ".csv")
    if (file.exists(file)) {
      read.csv(file)  
    }
  }
  
  pollutants <- unlist(sapply(id, read)[pollutant,])
  round(mean(pollutants[!is.na(pollutants)]), 3)
}