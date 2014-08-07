fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile=".data/housing.csv", method="curl")
housing <- read.csv(".data/housing.csv")
val <- housing$VAL[housing$VAL == 24]
val.not.na <- val[!is.na(val)]
print(c("How many properties are worth $1,000,000 or more", length(val.not.na)))

library(xlsx)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile=".data/gas_aquisition.xlsx", method="curl")
dat <- read.xlsx(".data/gas_aquisition.xlsx", sheetIndex=1, colIndex=7:15, rowIndex=18:23)
print(c("result", sum(dat$Zip*dat$Ext,na.rm=T)))

library(XML)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
#download.file(fileUrl, destfile=".data/restaurants.xml", method="curl")
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
rootNode <- xmlRoot(doc)
zip <- xpath(rootNode, "//zipcode='21231'",xmlValue)
print(length(zip))
# print(c("How many restaurants have zipcode 21231?", zip))
