corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  complete.observations <- complete("specdata", 1:332)
  complete.observations.with.threshold <- complete.observations[complete.observations$nobs >= threshold, ]
  if (nrow(complete.observations.with.threshold) > 0) {
    help(directory, complete.observations.with.threshold$id, threshold)
  } else {
    numeric(0)
  }
  
}

help <- function(directory, id = 1:332, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  improve <- function(monitor) {
    if (nchar(monitor) == 1)
      paste0("00", monitor)
    else if (nchar(monitor) == 2)
      paste0("0", monitor)
    else monitor
  }
  
  read <- function(monitorId) {
    file <- paste0(directory, "/", improve(monitorId), ".csv")
    if (file.exists(file)) {
      read.csv(file)  
    }
  }
  
  not.na <- function(x) x[!is.na(x$Date) & !is.na(x$sulfate) & !is.na(x$nitrate) & !is.na(x$ID), ]
  cut.and.compute <- function(tb) {
    # x <- x[1:threshold, ]
    if (!is.null(tb)) {
      cor(x=tb$nitrate, y=tb$sulfate)
    }    
  }
  
  observations <- lapply(id, read)
  observations.not.na <- lapply(observations, not.na)
  corr <- unlist(lapply(observations.not.na, cut.and.compute))
  corr[!is.na(corr)]
}