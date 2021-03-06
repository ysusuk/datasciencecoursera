library(xlsx)
library(XML)
library(data.table)

if(!file.exists(".data")) {
  dir.create(".data")
}

### csv

if(!file.exists(".data/housing_hid.csv")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  download.file(fileUrl, destfile=".data/housing_hid.csv", method="curl")
}

housing <- read.csv(".data/housing_hid.csv")
val <- housing$VAL[!is.na(housing$VAL) & housing$VAL == 24]
print(paste(c("How many properties are worth $1,000,000 or more", length(val)), collapse = " "))

### xlsx

if(!file.exists(".data/gas_aquisition.xlsx")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
  download.file(fileUrl, destfile=".data/gas_aquisition.xlsx", method="curl")
}
dat <- read.xlsx(".data/gas_aquisition.xlsx", sheetIndex=1, rowIndex=18:23, colIndex=7:15)
print(c("result", sum(dat$Zip*dat$Ext, na.rm=TRUE)))

### xml

if(!file.exists(".data/restaurants.xml")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
  download.file(fileUrl, destfile=".data/restaurants.xml", method="curl")  
}
doc <- xmlTreeParse(".data/restaurants.xml", useInternal=TRUE)
zip <- xpathSApply(doc, "//zipcode",xmlValue)
zip.eq.21231 <- zip[zip == "21231"]
print(c("How many restaurants have zipcode 21231?", length(zip.eq.21231)))

### data.frame
if(!file.exists(".data/housing_pid.csv")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
  download.file(fileUrl, destfile=".data/housing_pid.csv", method="curl")
}
DT <- fread(".data/housing_pid.csv")

print(system.time({
  mean(DT[DT$SEX==1,]$pwgtp15)
  mean(DT[DT$SEX==2,]$pwgtp15)
}))

# start.time <- Sys.time()
# rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2];
# print(Sys.time() - start.time)
DT <- fread(".data/housing_pid.csv")

print(system.time(mean(DT$pwgtp15,by=DT$SEX)))


DT <- fread(".data/housing_pid.csv")
print(system.time(DT[,mean(pwgtp15),by=SEX]))


DT <- fread(".data/housing_pid.csv")
print(system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)))


DT <- fread(".data/housing_pid.csv")
print(time.system(tapply(DT$pwgtp15,DT$SEX,mean)))