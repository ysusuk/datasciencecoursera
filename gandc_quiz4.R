library(quantmod)

if(!file.exists(".data")) {
  dir.create(".data")
}

if(!file.exists(".data/housing_hid.csv")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  download.file(fileUrl, destfile=".data/housing_hid.csv", method="curl")
}

housing <- read.csv(".data/housing_hid.csv")
splited <- strsplit(colnames(h$value), "wgtp")[[123]]
print(splited)

if(!file.exists(".data/gdp.csv") | !file.exists(".data/gdp-ed.csv")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  download.file(fileUrl, destfile=".data/gdp.csv", method="curl")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  download.file(fileUrl, destfile=".data/gdp-ed.csv", method="curl")
}

gdp <- read.csv(".data/gdp.csv",
                col.names = c("id", "Ranking", "t", "Economy", "us.dollars", "t.1", "t.2", "t.3", "t.4", "t.5"),
                skip = 4, nrows = 190)
dollars <- gdp$us.dollars
dollars.without.commas <- gsub(",", "", dollars)
num.dollars <- as.numeric(dollars.without.commas)
print(mean(num.dollars, na.rm = TRUE))

gdp.ed <- read.csv(".data/gdp-ed.csv")
gdp.merged <- merge(gdp, gdp.ed, by.x = "id", by.y = "CountryCode", all = TRUE)
gdp.merged.with.fiscal.year <- gdp.merged[!is.na(gdp.merged$Special.Notes), ]
# fiscal.year <- gdp.merged.with.fiscal.year[grep("fiscal", gdp.merged.with.fiscal.year$Special.Notes), ]

amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
sampleTimes.2012 <- sampleTimes[grep("2012", sampleTimes)]
print(length(sampleTimes.2012))
count.monday.2012 <- length(sampleTimes.2012[weekdays(sampleTimes.2012) == "Montag"])