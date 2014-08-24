if(!file.exists(".data")) {
  dir.create(".data")
}

if(!file.exists(".data/wksst8110.txt")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
  download.file(fileUrl, destfile=".data/wksst8110.txt", method="curl")
}

sst <- read.fwf(file = ".data/wksst8110.txt", skip = 4, widths=c(12, 7,4, 9,4, 9,4, 9,4))
sum(sst[[1]]$V4)