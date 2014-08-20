setwd("../..")

expect_that(rankhospital("TX", "heart attack"), equals("CYPRESS FAIRBANKS MEDICAL CENTER"))
#
expect_that(rankhospital("TX", "heart failure", 4), equals("DETAR HOSPITAL NAVARRO"))
expect_that(rankhospital("MD", "heart attack", "worst"), equals("HARFORD MEMORIAL HOSPITAL"))
# rankhospital("MN", "heart attack", 5000)