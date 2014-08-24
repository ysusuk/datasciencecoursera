library(jpeg)
library(Hmisc)
library(plyr)

if(!file.exists(".data")) {
  dir.create(".data")
}

if(!file.exists(".data/housing_hid.csv")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  download.file(fileUrl, destfile=".data/housing_hid.csv", method="curl")
}

housing <- read.csv(".data/housing_hid.csv")
agriculture <- housing$ACR == 3 & housing$AGS == 6
print(head(which(agriculture), n = 3))

if(!file.exists(".data/jeff.jpg")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
  download.file(fileUrl, destfile=".data/jeff.jpg", method="curl")
}

jpeg <- readJPEG(".data/jeff.jpg", native = TRUE)
print(quantile(jpeg, probs = c(0.3, 0.8)))

if(!file.exists(".data/gdp.csv") | !file.exists(".data/gdp-ed.csv")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  download.file(fileUrl, destfile=".data/gdp.csv", method="curl")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  download.file(fileUrl, destfile=".data/gdp-ed.csv", method="curl")
}

gdp <- read.csv(".data/gdp.csv",
                col.names = c("id", "Ranking", "t", "Economy", "us.dollars", "t.1", "t.2", "t.3", "t.4", "t.5"),
                skip = 5, nrows = 190)

gdp.ed <- read.csv(".data/gdp-ed.csv")
print(length(gdp[gdp$id %in% gdp.ed$CountryCode, ]$id))

gdp.merged <- merge(gdp, gdp.ed, by.x = "id", by.y = "CountryCode", all = TRUE)
gdp.merged.sorted <- gdp.merged[order(gdp.merged$Ranking, decreasing = TRUE), ]
print(gdp.merged.sorted[13, "id"])

gdp.filtered <- gdp.merged.sorted[gdp.merged.sorted$Income.Group == "High income: OECD" 
                                  | gdp.merged.sorted$Income.Group == "High income: nonOECD", ]
gdp.melt <- melt(gdp.filtered, id = c("id", "Income.Group"), measure.vars = c("Ranking"), na.rm = TRUE)
rank <- dcast(gdp.melt, Income.Group ~ variable, mean)

table(cut2(gdp.merged.sorted$Ranking, g = 5), gdp.merged.sorted$Income.Group, useNA = "no")